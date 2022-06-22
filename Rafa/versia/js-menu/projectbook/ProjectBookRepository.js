function ProjectBookRepository(){
    let self = this;
    self.doUnsubscribe = function(projectBookId){
        let deferred = $.Deferred();

        return $.ajaxHippo({
            method: 'POST',
            url: projectBookUnsubscribe,
            async: true,
            data: {
                projectBook: projectBookId,
            },
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
    }

    self.doExport = function(projectBookId, products, isEntirePbParam, type, isAdvancedParam) {

        return $.ajaxHippo({
            method: 'POST',
            url: projectBookExportToXlsxUrl,
            async: true,
            data: {
                projectBook: projectBookId,
                products: JSON.stringify(products),
                isEntirePb: isEntirePbParam,
                TYPE: type,
                isAdvanced: isAdvancedParam
            }
        });

    }

}