(function () {

    let password = document.getElementById("password1");
    let confirmPassword = document.getElementById("password2");
    let regex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,20}$");
    let usernameElement = document.getElementById("username");
    let form = document.getElementById("registerForm");
    let usernameValidationSpinner = $("#usernameValidationSpinner");
    let validUsername = $("#validUsername");
    let wrongUsername = $("#wrongUsername");
    let spinner = document.getElementById("spinner");

    const isValidPassword = function () {

        if (!regex.test(password.value) || !regex.test(confirmPassword.value)) {
            confirmPassword.setCustomValidity(regexPasswordMssg);
        } else if (password.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity(notEqualMssg);
        } else {
            confirmPassword.setCustomValidity('');
            $(confirmPassword).addClass("is-valid").removeClass("is-invalid");
            $(password).addClass("is-valid").removeClass("is-invalid");
        }
    }

    const checkExistingUser = function () {
        if (!usernameElement.value || usernameElement.value.length < 4 || usernameElement.value.length > 50) {
            return setWrongUsername(wrongLengthError);
        } else if (usernameElement.value && usernameElement.value.indexOf('http') !== -1){
            return setWrongUsername(invalidNameIncludesError);
        }

        $(usernameValidationSpinner).removeClass("hide");

        $.ajaxHippo({
            type: 'POST',
            url: existsUserUrl,
            async: true,
            data: {
                username: usernameElement.value,
            },
            success: function (res) {
                if (!res || res === "false") {
                    return setWrongUsername();
                }

                return setValidUsername();
            },
            error: function (res) {
                setWrongUsername();
            }
        });
    }

    const setWrongUsername = function (message) {
        $(validUsername).addClass("hide");
        $(wrongUsername).removeClass("hide");
        document.getElementById('wrongUsername').innerText = (message ? message : usernameAlreadyExists);
        $(usernameValidationSpinner).addClass("hide");
        usernameElement.setCustomValidity(message ? message : usernameAlreadyExists);
        $(usernameElement).removeClass('is-valid').addClass('is-invalid');
    };

    const setValidUsername = function () {
        $(wrongUsername).addClass("hide");
        $(validUsername).removeClass('hide');
        $(usernameValidationSpinner).addClass("hide");
        usernameElement.setCustomValidity('');
        $(usernameElement).addClass('is-valid').removeClass('is-invalid');
    }

    const showSpinner = function () {
        $(spinner).removeClass('ko-hide');
    }

    const hideSpinner = function () {
        $(spinner).addClass('ko-hide');
    }

    $(form).submit(function () {
        showSpinner();
        $.post($(this).attr('action'), $(this).serialize())
            .done(function (res) {
                createConfirmDialog('modal-register', successRegisterTitle, successRegisterMessage,
                    labelCancel, labelAccept, true,
                    function (confirm) {
                        /*
                        if(redirectUrl){
                            window.location = redirectRegister;
                        } else {
                            window.location = smc.channelPrefix;
                        }
                       */
                        window.location = smc.channelPrefix;
                        hideSpinner();
                    });

            })
            .fail(function (res) {
                createConfirmDialog('modal-register', errorRegisterTitle, errorRegisterMessage,
                    labelCancel, labelAccept, true,
                    function (confirm) {
                        hideSpinner();
                    });
            });

        return false; // prevent default action
    });


    //triggers
    confirmPassword.onkeyup = isValidPassword;
    usernameElement.onchange = checkExistingUser;
    //form.onclick = confirmRegister;
})();