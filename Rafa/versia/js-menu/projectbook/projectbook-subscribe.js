(function(){

    let acceptBtn = document.getElementById('pbSubBtn');
    let spinner = document.getElementById('subscription-spinner');
    let nameInput = document.getElementById('pbSubName');
    let passInput = document.getElementById('pbSubPwd');

    const requestSubscribe = function(name, password){
        let deferred = $.Deferred();

        return $.ajaxHippo({
            method: 'POST',
            url: projectBookSubscribe,
            dataType: 'json',
            data: {
                name: name,
                key: password
            },
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
    }

    const subscribeToProjectBook = function(){
        startLoading();

        let name = nameInput.value || "";
        let password = passInput.value || "";

        if(name.length === 0 || password.length === 0){
            smc.NotifyComponent.error(subscribeInputErrorMesssage);
            return endLoading();
        }
        let confirmBtn = isAuthenticated ? acceptBtnText : loginBtn;

        requestSubscribe(name, password)
            .then(function(res){
                const message = res.subscribedToPb || !isAuthenticated ? subscribeSuccessMesssage : alreadySubscribedMssg;
                const projectBookId = res.pbId;
                createConfirmAsyncDialog('modal-pb-subscribe', "", message, cancelBtn, confirmBtn, true, 'error-dialog-delete',function(confirm){
                    if(confirm){
                            window.location = smc.channelPrefix + '/projectbook?projectBook=' + projectBookId;
                    }
                });
                endLoading();
            })
            .fail(function(err){
                smc.NotifyComponent.error(subscribeInvalidMesssage);
                endLoading();
            })
    }

    const startLoading = function(){
        spinner.classList = "";
    };

    const endLoading = function(){
        spinner.classList = "ko-hide";
    }
    
    const onPressEnter = function(cb){
        return function(e) {
            if(e.which === 13 || e.keyCode === 13){
                return cb();
            }
        }
    };

    const triggerSubscription = onPressEnter(subscribeToProjectBook);

    acceptBtn.onclick = subscribeToProjectBook;
    passInput.onkeydown = triggerSubscription;
    nameInput.onkeydown = triggerSubscription;
})();