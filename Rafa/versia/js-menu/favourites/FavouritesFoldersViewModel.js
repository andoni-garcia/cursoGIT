function FavouritesFoldersViewModel() {
    var self = this;
    const FAVOURITES_FOLDERS_MODAL = '#favouritesFoldersModal';

    ko.di.require({
        REPOSITORY: "FavouritesFoldersRepository"
    }, self);

    //Respository
    var REPOSITORY = new FavouritesFoldersRepository();

    // -- Attributes --

    //Updating folder
    self.updatingFolder = ko.observable(false);

    //Update dom when first change
    self.needChange = ko.observable(true);
    self.showTree = ko.observable(false);

    //Loading attributes
    self.loadingFolders = ko.observable(false);
    self.loadingFoldersXhr = null;
    self.deferredLoading;

    //Saving attributes
    self.savingFolder = false;
    self.savingFoldersXhr = null;

    //Selector components attributes
    self.selectInputParentFolder = ko.observable('');
    self.boxInputFolderName = ko.observable('');

    //Arrays contains folders data
    self.folders = ko.observableArray([]);

    //Selector component selected folder attributes
    self.selectedFolderId = ko.observable(null);
    self.isSelectionValid = false;

    //Change name or create input
    self.disableFolderSelector = ko.observable(false);
    self.treeSelectedFolderId = ko.observable('');
    self.treeModalFolderName = ko.observable('');

    //Redirect overlay
    self.processingRedirect = ko.observable(false);

    //Prevent Subscriber
    var selectSubscribe = false;

    /**
     * Get favourites folders 
     * @param isTreeFolder specifies what array need to refresh 
     *                     if is true only refresh tree array else only selector component array
     *                     if is undefined both arrays
     */
    self.getFolders = function () {

        if (self.loadingFolders()) {
            self.loadingFoldersXhr.abort();
        }

        self.loadingFolders(true);

        self.deferredLoading = $.Deferred();

        self.loadingFoldersXhr = REPOSITORY.doGetFolders({
            success: function (res) {
                self.constructFoldersArray(res);
                self.loadingFolders(false);
                self.showTree(true);
                self.deferredLoading.resolve(res);
            },
            error: function(err) {
                self.deferredLoading.reject(err);
            }
        });

        return self.deferredLoading.promise();

    }

    /**
     * Creates a folder
     * @param parentFolder parent folder, if is undefined or null will be a parent folder
     * @param folderName name for the folder will be created
     */
    self.createFolder = function (parentFolder, folderName) {

        var deferred = $.Deferred();

        self.savingFolder = true;

        forceToLoad().then(function () {

            var folderFound = findFolderInsideTree(self.folders(), parentFolder);

            self.savingFoldersXhr = REPOSITORY.doAddFolder(parentFolder, folderName, {
                success: function (res) {

                    self.savingFolder = false;

                    var folder = new Folder(res);
                    folder.parent(folderFound);
                    addFolderToTree(folderFound, folder);

                    smc.NotifyComponent.info(addedFolderMsg);

                    deferred.resolve();
                },
                error: function (err) {
                    deferred.reject();
                }
            });

        });

        return deferred.promise();

    }

    /**
     * Updates folder information for favourites folders tree
     * @param folder folder to update
     */
    self.updateFolderName = function (folderId) {

        var deferred = $.Deferred();
        self.updatingFolder(true);
        self.selectedFolderId(folderId);

        forceToLoad().then(function () {

            var folderFound = findFolderInsideTree(self.folders(), folderId);

            if (folderFound) {

                if (folderFound.childrenFolders().length > 0) {
                    self.disableFolderSelector(true);
                } else {
                    self.disableFolderSelector(false);
                }

                if (folderFound.parent()) {
                    self.treeSelectedFolderId(folderFound.parent().folderId);
                } else {
                    self.treeSelectedFolderId('');
                }
                self.treeModalFolderName(folderFound.name());

                //Change name modal
                createConfirmDialog('modal-tree-folders', null, null, cancelBtn, updateBtn, true,
                    function (confirm) {

                        //TODO: if treeModalFolderName empty then show message and dont update
                        if (confirm) {

                            REPOSITORY.doUpdateNameFolder(folderFound.folderId, self.treeSelectedFolderId(), self.treeModalFolderName(), {
                                success: function (res) {
                                    folderFound.name(self.treeModalFolderName());

                                    updateFolder(folderFound, self.treeSelectedFolderId());

                                    self.treeSelectedFolderId('');
                                    self.treeModalFolderName('');

                                    smc.NotifyComponent.info(updateFolderMsg);

                                    deferred.resolve();
                                },
                                error: function (err) {
                                    deferred.reject();
                                    self.updatingFolder(false);
                                }
                            });
                        } else {
                            self.updatingFolder(false);
                        }

                    });

            } else {
                deferred.reject();
                self.updatingFolder(false);
            }

        }).catch(function() {
            self.updatingFolder(false);
        });

        return deferred.promise();

    }

    /**
     * Removes specified folder for favourites folders tree
     * @param folder folder to delete
     */
    self.deleteFolder = function (folderId) {

        var deferred = $.Deferred();

        forceToLoad().then(function () {

            var folderFound = findFolderInsideTree(self.folders(), folderId);
            var message = deleteFolderMssg.replace('{0}', folderFound.name());

            //Confirmation modal
            createConfirmDialog('modal-component', deleteFolderTitle, message,
                BASKET_MESSAGES.modalDeleteCancelButtonText, BASKET_MESSAGES.modalDeleteConfirmButtonText, true)
                .then(function(){
                    REPOSITORY.doDeleteFolder(folderId, {
                        success: function (res) {

                            deleteFolderFromTree(folderId);

                            smc.NotifyComponent.info(deletedFolderMsg);
                            if(parseInt(currentFolder) === folderId) {
                                self.processingRedirect(true);
                                setTimeout(function(){
                                    window.location.href = favouritesRelativePath;
                                }, 2000);
                            }
                            deferred.resolve();
                            
                        },
                        error: function (err) {
                            deferred.reject();
                        }
                    });
                }, function(){
                    deferred.reject();
                });

        });

        return deferred.promise();

    }

    /**
     * Creates new folders for selector component
     */
    self.createFolderSelector = function () {

        if (self.boxInputFolderName() !== '' && !self.savingFolder) {

            self.savingFolder = true;

            self.createFolder(self.selectInputParentFolder(), self.boxInputFolderName()).then(function () {
                self.selectInputParentFolder('');
                self.boxInputFolderName('');
                $(FAVOURITES_FOLDERS_MODAL).trigger('next.m.1');
            }, function () {

            });

        }

    }

    self.createFolderTree = function () {

        var deferred = $.Deferred();

        forceToLoad().then(function () {

            self.treeSelectedFolderId('');
            self.treeModalFolderName('');

            createConfirmDialog('modal-tree-folders', null, null, cancelBtn, createBtn, true,
                function (confirm) {

                    //TODO: if treeModalFolderName empty then show message and dont create

                    if (confirm) {

                        self.createFolder(self.treeSelectedFolderId(), self.treeModalFolderName()).then(function () {
                            deferred.resolve();
                        }, function () {
                            deferred.reject();
                        });

                    } else {
                        deferred.reject();
                    }

                });

        });

        return deferred.promise();

    }

    /**
     * Constructs array for specified zone
     */
    self.constructFoldersArray = function (folders) {

        if (folders) {

            var arrayToCopy = [];
            for (var i = 0; i < folders.length; i++) {
                var folder = new Folder(folders[i]);
                arrayToCopy.push(folder);
            }

            self.folders(arrayToCopy);

        }

    }

    self.getSelectedFolder = function () {

        if (self.isSelectionValid) {
            return self.selectedFolderId();
        } else {
            return null;
        }

    }

    self.setSelected = function (folderId) {

        selectSubscribe = true;

        self.isSelectionValid = true;

        self.selectedFolderId(folderId);

        selectSubscribe = false;

    }

    self.selectedFolderId.subscribe(function(newValue) {
        if(newValue) {
            self.isSelectionValid = true;
        }
    });

    //Modal step
    self.show = function () {

        if (self.currentMoveDeferred) {
            console.log(self.currentMoveDeferred.state());
        }

        if (self.currentMoveDeferred && self.currentMoveDeferred.state() === 'pending') {
            return $.Deferred().reject(new Error('Pending deferred'));
        } else {
            self.currentMoveDeferred = $.Deferred();
        }

        self.selectedFolderId(null);
        self.isSelectionValid = false;
        self.getFolders();

        var confirm = $(FAVOURITES_FOLDERS_MODAL);
        confirm.modal('show');
        confirm.trigger('next.m.1');

        $(FAVOURITES_FOLDERS_MODAL).on('hidden.bs.modal', function () {
            $(FAVOURITES_FOLDERS_MODAL).modal('hide');
            self.currentMoveDeferred.reject(new Error('Response error'));
        })

        return self.currentMoveDeferred.promise();

    }

    self.closeWithoutSave = function () {

        $(FAVOURITES_FOLDERS_MODAL).modal('hide');

        self.currentMoveDeferred.reject(new Error('Response error'));

    }

    self.closeWithSave = function () {

        if (self.getSelectedFolder() == null) {
            return;
        }

        $(FAVOURITES_FOLDERS_MODAL).modal('hide');

        self.currentMoveDeferred.resolve(parseInt(self.selectedFolderId()));

    }

    self.sendEvent = function (domId, step, forceLoading) {

        if (forceLoading) {
            self.getFolders();
        }

        sendEvent(domId, step);

    }


    /**
     * Search for folder with id into tree folders
     * @param tree 
     * @param folderId 
     */
    var findFolderInsideTree = function (tree, folderId) {

        if (!folderId) return null;

        var endSearch = false;

        var parentCounter = 0;

        if (tree && tree.length > 0) {

            while (!endSearch) {

                var element = tree[parentCounter];
                if (element.folderId === folderId) {
                    return element;
                } else {
                    if (element.childrenFolders && element.childrenFolders()) {
                        var childrenFoundFolder = findFolderInsideTree(element.childrenFolders(), folderId);
                        if (childrenFoundFolder) return childrenFoundFolder;
                    }
                }
                parentCounter++;
                if (tree.length === parentCounter) endSearch = true;
            }

        }

        return null;
    }

    /**
     * Adds children folder to existing folder
     * @param existingFolder 
     * @param addFolder 
     */
    var addFolderToTree = function (existingFolder, addFolder) {
        if (addFolder) {
            if (existingFolder) {
                var childrens = existingFolder.childrenFolders();
                childrens.push(addFolder);
                existingFolder.childrenFolders(childrens);
            } else {
                var folders = self.folders();
                folders.push(addFolder);

                self.folders(folders);
            }
        }
    }

    /**
     * Deletes specific folder from tree
     * @param folderId 
     */
    var deleteFolderFromTree = function (folderId) {

        var folderFound = findFolderInsideTree(self.folders(), folderId);

        if (!folderFound) return;

        var arr;
        if (folderFound.parent() == null) {
            arr = self.folders();
        } else {
            arr = folderFound.parent().childrenFolders();
        }

        arr = arr.filter(function (ele) {
            return ele.folderId != folderId;
        });

        if (folderFound.parent() == null) {
            self.folders(arr);
        } else {
            folderFound.parent().childrenFolders(arr);
        }


    }

    /**
     * Forces to load data
     */
    var forceToLoad = function () {

        var deferred = $.Deferred();

        if (self.needChange()) {

            self.getFolders().then(function () {
                self.needChange(false);
                deferred.resolve(true);
            }, function () {
                self.needChange(true);
                deferred.resolve(false);
            });

        } else {
            deferred.resolve(false);
        }

        return deferred.promise();

    }

    var updateFolder = function (folder, destFolderId) {

        var folderOrigin = null;
        var originalParentId = null;
        destFolderId = destFolderId === '' ? null : destFolderId;
        if (folder.parent() != null) {
            folderOrigin = folder.parent().childrenFolders;
            originalParentId = folder.parent().folderId;
        }

        if(originalParentId === destFolderId) return;

        //Assign folder to parent folder
        if (!destFolderId || destFolderId === '') {

            folder.parent(null);

            var mainFolders = self.folders();
            mainFolders.push(folder);
            self.folders(mainFolders);

        } else {

            var parentFolderFound = findFolderInsideTree(self.folders(), destFolderId);
            folder.parent(parentFolderFound);

            //Update subfolders of parent
            var subFolders = parentFolderFound.childrenFolders();
            subFolders.push(folder);
            parentFolderFound.childrenFolders(subFolders);

        }


        var koObservableArray;
        if (folderOrigin) {
            koObservableArray = folderOrigin;
        } else {
            koObservableArray = self.folders;
        }

        var arr = koObservableArray().filter(function (ele) {
        return ele.folderId != folder.folderId;
        });
        koObservableArray(arr);

    }

}