(function () {

    let spinner = document.getElementById("spinner");

    const params = [
        'userTitle',
        'name',
        'lastName',
        'company',
        'orderNumber',
        'cif',
        'departament',
        'positions',
        'customerId',
        'address',
        'street',
        'cp',
        'place',
        'location',
        'country',
        'telephone',
        'fax',
        'email',
        'website'
    ];

    const addEventByClassName = function addEventByClassName(className, trigger, callback) {
        let classname = document.getElementsByClassName(className);

        for (var i = 0; i < classname.length; i++) {
            classname[i].addEventListener(trigger, callback, false);
        }

    };

    const isOldUserRegisterType = function isOldUserRegisterType() {
        const selectedValue = document.querySelector('input[name="userType"]:checked').value;

        return selectedValue === 'existClient';
    };


    const showByClass = function showByClass(show, className) {
        let classname = document.getElementsByClassName(className);

        for (var i = 0; i < classname.length; i++) {

            if (show) {
                classname[i].style.display = "block";
                classname[i].getElementsByTagName('input')[0].setAttribute('type', 'text');
            } else {
                classname[i].style.display = "none";
                classname[i].getElementsByTagName('input')[0].setAttribute('type', 'hidden');
            }

        }
    };

    const showFieldsByActiveUserType = function showFieldsByActiveUserType() {

        if (isOldUserRegisterType()) {
            showByClass(true, 'old-user');
            showByClass(false, 'new-user');
        } else {
            showByClass(true, 'new-user');
            showByClass(false, 'old-user');
        }

    };

    const showSpinner = function () {
        $(spinner).removeClass('ko-hide');
    };

    const hideSpinner = function () {
        $(spinner).addClass('ko-hide');
    };

    const getSelectedUserType = function getSelectedUserType() {
        return document.querySelector('input[name="accessLevel"]:checked').value;
    };

    const doRegister = function doRegister(data) {
        return $.ajaxHippo($.extend({
            url: registerEshopUrl,
            method: 'POST',
            dataType: 'json',
            data: {
                data: JSON.stringify(data)
            }
        }));

    }
    const getActiveValues = function getActiveValues() {

        const size = params.length;
        let data = {};
        for (var index = 0; index < size; index++) {
            const param = params[index];
            
            const input = document.getElementById(param);

            let inputValue = '';

            if(input.tagName === 'select'){
               inputValue = input.options[input.selectedIndex].value;
            } else {
                inputValue = document.getElementById(param).value;
            }

           

            if (inputValue && typeof inputValue === typeof "s" && inputValue.length > 0) {
                data[param] = inputValue;
            }

        }

        data.isNewUser = !isOldUserRegisterType();
        data.userType = getSelectedUserType();
        return data;
    };

    //On load
    showFieldsByActiveUserType();
    addEventByClassName('user-type-radio', 'change', showFieldsByActiveUserType);
    $('#registerForm').submit(function (e) {
        e.preventDefault();

        doRegister(getActiveValues())
            .then(function (res) {
                addEventToDataLayer();
                createConfirmDialog('modal-register', successRegisterTitle, successRegisterMessage,
                    labelCancel, labelAccept, true,
                    function (confirm) {
                        window.location = smc.channelPrefix;
                        hideSpinner();
                    });
            })
            .catch(function (res) {
                createConfirmDialog('modal-register', errorRegisterTitle, errorRegisterMessage,
                    labelCancel, labelAccept, true,
                    function (confirm) {
                        hideSpinner();
                    });
            });
    });

})();

function addEventToDataLayer(){
    try{//Germany asked for trace of this event (only for PRD)
        if (window.location.href.indexOf("smc.eu") > 0){
            window.dataLayer = window.dataLayer || [];
            dataLayer.push({ 'event': 'eshop registration successful' });
        }
    }catch(error){
        console.log("[addEventToDataLayer] error ",error);
    }
}