var loadingStartTime = 0;
(function(window) {
    var globalConfig = window.smc;
    function AccessoryModal(config) {
        this.id = config.id;
        this.config = config;
    }

    AccessoryModal.prototype.init = init;
    AccessoryModal.prototype.showModalWindow = showModalWindow;
    AccessoryModal.prototype.updateSettingsValuesIfNeeded = updateSettingsValuesIfNeeded;
    AccessoryModal.prototype.checkForUpdatedData = checkForUpdatedData;
    AccessoryModal.prototype.printProductInfoPreview = printProductInfoPreview;

    function init() {
        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };
        if (this.config.showParameter === 'details' && this.config.showModal  === "true" ) {
            this.showModalWindow();
        }
    }

    function showModalWindow(event){
        if (event) event.preventDefault();
        var confirm = $("#_showAccessory");
        confirm.modal('show');
        $("#_showAccessory .modal-dialog").removeClass("hidden");
        loadingStartTime =(new Date()).getTime();
        this.updateSettingsValuesIfNeeded();
    }


    function updateSettingsValuesIfNeeded(){
        if ($("#modal_settings_container").html().trim() === ""){
            //then we try to load by ajax
            var data = {
                componentId: this.id,
                productId: this.config.productId,
                partNumber: this.config.partNumber
            };
            var url =smc.details.urls.showAccessoryDetail;
            $.get(url, data).then(function (response) {
                console.log("");
                checkForUpdatedData(response);
            });
        }
    }

    function checkForUpdatedData(response) {
        var def = $.Deferred();
        if (response.status === 'UPDATED') {
            printProductInfoPreview(response);
        } else if (response.status !== 'ERROR') {
            var currentTimeInMillic = (new Date()).getTime();
            if ((currentTimeInMillic - this.loadingStartTime) < 100000 &&  loadingStartTime !== 0) {
                setTimeout(function(){
                    updateSettingsValuesIfNeeded();
                },3000);
            }
        } else {
            loadingStartTime = 0 ;
        }
        return def.promise();
    }

    function printProductInfoPreview(response) {
        if (response !== undefined){
            var attributesHTML = '';
            response && response.data.forEach(function (attribute) {
                attributesHTML +="<div class=\"detail-register\">";
                if (attribute.key === "PITW_SETTING_CONFIGURATION_FILE"){
                    attributesHTML +="<div class=\"pl-2 pr-0 key-text\"><a  target = \"_blank\" href='"+attribute.value+"'>"+this.config.messages.PITW_SETTING_CONFIGURATION_FILE+"</a></div>";
                    attributesHTML +="<div class=\"pl-1 pr-0 key-text-value\"></div>";
                } else if (attribute.key === "PITW_SETTING_DRIVERS"){
                    attributesHTML +="<div class=\"pl-2 pr-0 key-text\"><a  target = \"_blank\" href='"+attribute.value+"'>"+this.config.messages.PITW_SETTING_DRIVERS+"</a></div>";
                    attributesHTML +="<div class=\"pl-1 pr-0 key-text-value\"></div>";
                } else if (attribute.key === "PITW_SETTING_SOFTWARE"){
                    attributesHTML +="<div class=\"pl-2 pr-0 key-text\"><a  target = \"_blank\" href='"+attribute.value+"'>"+this.config.messages.PITW_SETTING_SOFTWARE+"</a></div>";
                    attributesHTML +="<div class=\"pl-1 pr-0 key-text-value\"></div>";
                } else {
                    attributesHTML +="<div class=\"pl-2 pr-0 key-text\">"+attribute.key+":</div>";
                    attributesHTML +="<div class=\"pl-1 pr-0 key-text-value\">"+attribute.value+"</div>";
                }
                attributesHTML +="</div>";
            });
            $("#modal_settings_container").html(attributesHTML);
        }
    }

    window.smc.AccessoryModal = AccessoryModal;
})(window);