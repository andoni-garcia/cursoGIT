(function (globalKoUtils) {

    function FavouritesFoldersSimpleViewModel(params) {
        var self = this;

        //Respository
        var REPOSITORY = new FavouritesFoldersRepository();

        // -- Params --
        var parentVm = params.parentVm;
        var preventSubscribe = false;
        //Parent viewmodel observable
        self.creatingNewFolder = parentVm.creatingNewFolder;
        self.saveFolder = parentVm.saveFolder;
        var confirmCreationEvent = parentVm.confirmFolderCreation || ko.observable(null);
        var confirmSelectionEvent = parentVm.confirmFolderSelection || ko.observable(null);
        var selectedFolderId = parentVm.selectedFolderId || ko.observable(null);
        var currentPage = parentVm.currentPage || ko.observable(null);
        var displayingStep = params.displayComponentStep;

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
                error(err) {
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
         * Creates new folders for selector component
         */
        var createFolderSelector = function () {

            var deferred = $.Deferred();

            if (self.boxInputFolderName() !== '' && !self.savingFolder) {

                self.savingFolder = true;

                self.createFolder(self.selectInputParentFolder(), self.boxInputFolderName()).then(function () {
                    self.selectInputParentFolder('');
                    self.boxInputFolderName('');
                    self.creatingNewFolder(false);
                    deferred.resolve();
                }, function () {
                    deferred.reject();
                });

            } else {
                deferred.reject();
            }

            return deferred.promise();

        }

        self.createFolderTree = function () {

            var deferred = $.Deferred();

            forceToLoad().then(function () {

                self.treeSelectedFolderId('');
                self.treeModalFolderName('');

                createConfirmDialog('modal-tree-folders', null, null, cancelBtn, createBtn, true,
                    function (confirm) {

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

            // selectSubscribe = true;

            self.isSelectionValid = true;

            self.selectedFolderId(folderId);

            // selectSubscribe = false;

        }

        // -- Subscribers --
        self.selectedFolderId.subscribe(function (newValue) {
            if (newValue) {
                parentVm.disableNext(false);
                self.isSelectionValid = true;
            }

            if (newValue == null) {
                parentVm.disableNext(true);
                self.isSelectionValid = false;
            }

            parentVm.selectedFolderId(newValue);
        });

        confirmCreationEvent.subscribe(function (newValue) {
            if (!preventSubscribe && newValue == true) {
                preventSubscribe = true;
                createFolderSelector();
                preventSubscribe = false;
            }
        });

        confirmSelectionEvent.subscribe(function (newValue) {
            if (!preventSubscribe && newValue == true) {
                preventSubscribe = true;
                selectedFolderId(self.getSelectedFolder());
                preventSubscribe = false;
            }
        });

        self.saveFolder.subscribe(function(newValue) {
            if(newValue) {
                createFolderSelector().then(function(){
                    self.saveFolder(false);
                },function(){});
                
            }
        });

        parentVm.creatingNewFolder.subscribe(function(newValue) {
            if(newValue) {
                self.selectedFolderId(null);
                self.treeSelectedFolderId('');
            }
        });

        selectedFolderId.subscribe(function(newValue){
            if(newValue == null) {
                self.selectedFolderId(null);
            }
        });

        self.isShowingComponent = ko.computed(function(){
            if((displayingStep && currentPage() === displayingStep) || !displayingStep) {
                init();
                return true;
            }
            return false;
        });

        var init = function () {

            if (self.currentMoveDeferred) {
                console.log(self.currentMoveDeferred.state());
            }

            if (self.currentMoveDeferred && self.currentMoveDeferred.state() === 'pending') {
                return $.Deferred().reject(new Error('Pending deferred'));
            } else {
                self.currentMoveDeferred = $.Deferred();
            }

            self.selectedFolderId(null);
            self.treeSelectedFolderId('');
            self.isSelectionValid = false;
            self.getFolders();

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

    }

    ko.components.register('smc-favourites-simple-selector', {
        viewModel: {

            createViewModel: function (params, componentInfo) {
                return new FavouritesFoldersSimpleViewModel(params);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)