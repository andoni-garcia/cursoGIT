function Folder(folder, parent) {

    var self = this;
    
    self.parent = ko.observable(null);
    if(parent) self.parent(parent);

    self.folderId = folder.folderId;
    self.defaultFolder = folder.defaultFolder;
    self.name = ko.observable(folder.name);
    self.numFavouriteElements = ko.observable(folder.numFavouriteElements);
    self.childrenFolders = ko.observableArray([]);

    if(folder.childrenFolders) {
        var childrenFolders = [];
        for(var i=0; i<folder.childrenFolders.length; i++) {
            var folderModel = new Folder(folder.childrenFolders[i], this);
            childrenFolders.push(folderModel);
        }
        self.childrenFolders(childrenFolders);
    }

}