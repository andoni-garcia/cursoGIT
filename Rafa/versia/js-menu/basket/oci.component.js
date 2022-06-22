function OciComponent() {

    let self = this;

    self.confirmOciOrder = function () {
        return getOciParameters()
            .then(function (ociData) {

                if (!ociData) {
                    return smc.NotifyComponent.error(OCI_MESSAGES.invalidResponse);
                }
                createHiddenForm(ociData);
            })
            .catch(function (err) {
                return smc.NotifyComponent.error(OCI_MESSAGES.defaultError);
            });

    }

    const createHiddenForm = function (ociData) {
        if (!ociData) {
            return smc.NotifyComponent.error(OCI_MESSAGES.dataNotFound);
        } else if (!ociData.hookUrl) {
            return smc.NotifyComponent.error(OCI_MESSAGES.hookUrlNotFound);
        } else if (ociData.products.length === 0) {
            return smc.NotifyComponent.error(OCI_MESSAGES.productsNotFound);
        }
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = ociData.hookUrl;

        _.map(ociData.products, function (product, idx) {
            appendProductParameters(form, product.parameters, idx+1);
        });

        document.body.appendChild(form);
        logoutOciUser()
            .then(function () {
                form.submit();
            })
            .catch(function (err) {
                return smc.NotifyComponent.error(OCI_MESSAGES.logoutError);
            });
    }

    const appendProductParameters = function (form, parameters, idx) {
        let currentInput;
        for (let parameter in parameters) {
            if (parameters.hasOwnProperty(parameter)) {
                currentInput = document.createElement('input');
                currentInput.name = parameter.replace('__idx__', idx);;
                currentInput.value = parameters[parameter];
                form.appendChild(currentInput);
            }
        }
    }



    const getOciParameters = function () {
        var deferred = $.Deferred();

        $.ajaxHippo({
            url: getOciValues,
            type: 'POST',
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
        return deferred;
    }

    const logoutOciUser = function () {
        const deferred = $.Deferred();
        $.ajaxHippo({
            url: logoutOciUrl,
            type: 'POST',
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
        return deferred;
    }
}