function PartNumberInfoComponent() {
    let self = this;
    const loadingScreen = document.getElementById("partnumber-info");

    self.loading = ko.observable(false);

    self.getPartNumberUrl = function (partNumber, type) {
        if (!partNumber) {
            return smc.NotifyComponent.error(urlNotFoundMssg);
        }

        startPageLoading();
        getProductUrl(partNumber, type)
            .then(function (res) {
                window.location.href = buildUrl(res);
            })
            .catch(function (err) {
                smc.NotifyComponent.error(urlNotFoundMssg);
                endPageLoading();
            });
    }


    //TODO: Move from basketViewModel
    self.getPartNumberDetails = function (partNumber) {
    }

    self.getFamilies = function(data) {
        return request(ssiFamiliesListUrl, data)();
    }
        
    /**
     * 
     * HELPERS
     */


    const getProductUrl = function (partNumber, type) {
        let deferred = $.Deferred();
        $.ajaxHippo({
            type: 'POST',
            url: partnumberLinkUrl,
            data: {
                searchPartNumber: partNumber,
                productType: type
            },
            async: true,
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            }
        });
        return deferred;
    }

    window.onload = function () { //Remove loading after redirect
        endPageLoading();
    }

    var startPageLoading = function () {
        $(loadingScreen).addClass("loading-full");
        self.loading(true);
    }

    var endPageLoading = function () {
        $(loadingScreen).removeClass("loading-full");
        self.loading(false);
    }

    var buildUrl = function (url) {
        url = url.split('"').join('');
        url.substring(1);
        return url;
    }

    const request = function(url, data) {
        return function () {
            let deferred = $.Deferred();
            const params = {
                type: 'POST',
                url: url,
                async: true,
                success: function (res) {
                    return deferred.resolve(res);
                },
                error: function (err) {
                    return deferred.reject(err);
                }
            };

            const requestParams = $.extend(params, { data: data });
            $.ajaxHippo(requestParams);
            return deferred;
        };
    }

}