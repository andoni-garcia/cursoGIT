function SuccessStoriesRepository() {
    var self = this;

    self.doExportStories = function(type){
        return $.ajaxHippo({
            method: 'GET',
            url: '/exportss/$id',
            async: true,
            data: {
                type: type
            }
        });
    },
    self.doDeleteStory = function(id){
        return $.ajaxHippo({
            method: 'GET',
            url: '/deletess/$id',
            async: true,
            data: {
                id: id
            }
        });
    }
}