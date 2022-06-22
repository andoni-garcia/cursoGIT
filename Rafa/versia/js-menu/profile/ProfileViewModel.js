function ProfileViewModel() {
    var self = this;

    var REPOSITORY = new ProfileRepository();
    var PASSWORD_REGEX = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,20}$");

    self.updatePassword = ko.observable('');
    self.updatePasswordRepeat = ko.observable('');

    self.deleteUser = function () {
        var deferred = $.Deferred();
        createConfirmAsyncDialog('modal-delete', null, null, cancelBtn, deleteBtn, true, 'error-delete-dialog', function (confirm) {
            if (confirm) {
                REPOSITORY.doDeleteUser({
                    success: function () {
                        location.href = "/";
                        return deferred.resolve();
                    },
                    error: function (err) {
                        return deferred.reject(errorDeletingProfile);
                    }
                });
            }
        });

    }

    self.showPasswordModal = function () {
        var deferred = $.Deferred();

        createConfirmAsyncDialog('modal-password', null, null, cancelBtn, updateBtn, true, 'error-update-dialog', function (confirm) {
            if (confirm) {
                if (self.updatePassword() !== self.updatePasswordRepeat()) {
                    return deferred.reject(notEqualsPasswordsMssg);
                } else if (!PASSWORD_REGEX.test(self.updatePassword())) {
                    return deferred.reject(regexPasswordErrorMssg);
                } else {
                    return updateUserPassword();

                }
            }

        });
    }

    var updateUserPassword = function () {
        var deferred = $.Deferred();

        REPOSITORY.doUpdatePassword(self.updatePassword(), {
            success: function (res) {

                if (res.status === 400 || res.status === '400') return deferred.reject(errorUpdatingPasswordMssg);
                self.updatePassword('');
                self.updatePasswordRepeat('');
                smc.NotifyComponent.info(successUpdatePassword);
                return deferred.resolve();
            },
            error: function (err) {
                smc.NotifyComponent.error(errorUpdatePassword);
                return deferred.reject(errorUpdatingPasswordMssg);
            }
        });

        return deferred.promise();
    }

}