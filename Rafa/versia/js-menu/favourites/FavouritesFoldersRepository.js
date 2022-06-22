function FavouritesFoldersRepository() {
    var self = this;

    ko.di.register(self, "FavouritesFoldersRepository");
    ko.di.require({
        jq: "jQuery"
    }, self);

    self.doGetFolders = function (callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: favouritesFoldersServerListUrl,
            dataType: 'json',
            async: true,
        }, callbacks));

    }

    self.doAddFolder = function (folderId, folderName, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: favouritesFoldersServerAddUrl,
            dataType: 'json',
            data: {
                id: folderId,
                name: folderName
            },
            async: true,
        }, callbacks));

    }

    self.doUpdateNameFolder = function(folderId, folderParentId, folderName, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: favouritesFoldersServerUpdateUrl,
            dataType: 'json',
            data: {
                id: folderId,
                parentId: folderParentId,
                name: folderName
            },
            async: true,
        }, callbacks));

    }

    self.doDeleteFolder = function(folderId, callbacks) {

        return $.ajaxHippo($.extend({
            type: "POST",
            url: favouritesFoldersServerDeleteUrl,
            dataType: 'json',
            data: {
                id: folderId
            },
            async: true,
        }, callbacks));

    }

}