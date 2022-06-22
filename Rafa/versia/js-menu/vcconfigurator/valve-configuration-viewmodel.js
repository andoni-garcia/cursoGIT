function SimpleSpecialData(code, error) {
    this.error = ko.observable(error);
    this.simpleSpecialCode = ko.observable(code);
}

function ValveConfigurationViewModel() {

    var self = this;

    self.copying = ko.observable(false);

    self.enabledSimpleSpecial = ko.observable(false);
    self.loadingBom = null;

    self.showModalContact = ko.observable(false);
    self.selectedContact = null;

    self.titleLabel = modalContactLabels.title;
    self.confirmLabel = modalContactLabels.confirm;
    self.cancelLabel = modalContactLabels.cancel;
    self.noItemsLabel = modalContactLabels.noItems;

    self.bomItemsList = ko.observableArray([]);
    self.totalLeadTime = ko.observable('-');
    self.totalListPrice = ko.observable('-');
    self.totalNetPrice = ko.observable('-');
    self.invalid = ko.observable(false);

    self.customerCode = ko.observable(aliasCustomerCode);
    self.customerName = ko.observable(aliasCustomerName);
    self.endUserCode = ko.observable(endCustomerCode);
    self.endUserName = ko.observable(endCustomerName);

    self.loadingBomItemsList = ko.observable(false);
    self.isPricesTable = ko.observable(checkedPriceAndLeadtime);

    self.isOpenedGroup = ko.observable(null);
    self.creatingProcess = ko.observable(false);

    self.simpleSpecialCode = ko.observable(null);
    self.creatingPdf = ko.observable(false);
    self.sendingProduct = ko.observable(false);

    if(typeof simpleSpecialCode === undefined) {
        let simpleSpecialCode = null;
    }

    self.simpleSpecialCode(new SimpleSpecialData(simpleSpecialCode, null));

    // Private methods
    const resetValues = function() {
        self.bomItemsList([]);
        self.totalLeadTime('-');
        self.totalListPrice('-');
        self.totalNetPrice('-');
        self.customerCode(aliasCustomerCode);
        self.customerName(aliasCustomerName);
        self.endUserCode(endCustomerCode);
        self.endUserName(endCustomerName);
    }

    // Public methods

	self.doLoadSimpleSpecialBom = function(loadPrices, callbacks) {

        var urlParam;
        if(loadPrices) {
            urlParam = loadSimpleSpecialListPricesUrl;
        } else {
            urlParam = loadSimpleSpecialBomUrl;
        }

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: urlParam,
			dataType: 'json'
		}, callbacks));

    }

    self.doSetCloseGroup = function(callbacks) {

        return $.ajaxHippo($.extend({
			type: 'POST',
			url: closeGroupUrl,
			dataType: 'json'
		}, callbacks));

    }

    self.loadSimpleSpecial = function(loadPrices) {

        if(self.enabledSimpleSpecial() && !self.copying() && !self.loadingBomItemsList()) {

            self.loadingBomItemsList(true);

            self.loadingBom = self.doLoadSimpleSpecialBom(loadPrices);

            self.loadingBom.then(function(data){
                self.bomItemsList(data.elements);
                self.totalLeadTime(data.totalLeadTime);
                self.totalListPrice(data.totalListPrice);
                self.totalNetPrice(data.totalNetPrice);
                self.customerCode(data.customerCode);
                self.customerName(data.customerName);
                self.endUserCode(data.endUserCode);
                self.endUserName(data.endUserName);
                self.invalid(data.invalid);
                self.loadingBomItemsList(false);

                if(loadPrices) {
                    console.log('loadSimpleSpecialPrices');
                    self.isPricesTable(true);
                } else {
                    console.log('loadSimpleSpecialBom');
                    self.isPricesTable(false);
                }

            }, function(e) {
                console.log(e);
            });

        }

    }

    self.loadExternalPriceAndDelivery = function() {

        if(!self.enabledSimpleSpecial()) return;

        if (self.loadingBom != null) {
            self.loadingBom.abort();
            self.loadingBom = null;
        }
        self.loadingBomItemsList(false);
        self.loadSimpleSpecial(true);
        $('#valve_external_pdSummary').show();
    }

    self.openWizardModal = function() {
        if(self.isOpenedGroup()) {
            self.doSetCloseGroup().then(function(){
                self.isOpenedGroup(false);
                wizardSimpleSpecialViewModel.showWizard();
            });
        } else {
            wizardSimpleSpecialViewModel.showWizard();
        }
    }


    const isSendEnabled = function(targetId){

        const element = document.getElementById(targetId);
        return element && element.getAttribute('data-configuration') === 'valid';
    }

    self.sendVcBasket = function() {

        if(!isSendEnabled('sendVcToBasket')){
            return;
        }

        let syImageData = self.getImageData();
        smc.NotifyComponent.info(labelStartSendingVcToBasket);

        self.sendingProduct(true);

        $.ajaxHippo({
            type: 'POST',
            url: sendVcToBasketUrl,
            dataType: 'json',
            data: {
                syImage: syImageData
            },
        }).then(function(data) {
            console.log('Correct');
            smc.NotifyComponent.info(BASKET_MESSAGES.productAdded);
            basketViewModel.firstDataLoad(false);
            basketViewModel.getBasketData();
            self.sendingProduct(false);
        
            if(!self.simpleSpecialCode() || !self.simpleSpecialCode().simpleSpecialCode()){
                self.simpleSpecialCode(new SimpleSpecialData(data, null))
            }

            stateMachine.controllers.tabs.afterUndoRedo();
            self.isOpenedGroup(false);
            
        })
        .catch(function(e) {

            if(e.status === 409 ){
                smc.NotifyComponent.error(BASKET_MESSAGES.productAlreadyAdded);
            } else {
                smc.NotifyComponent.error(labelErrorSendingVcToBasket);
            }
            self.sendingProduct(false);
        });
    }

    self.sendVcFavourites = function() {

        if(!isSendEnabled('sendVcToFavourites')){
            return;
        }

        var deferred = $.Deferred();

        console.log('sendVcFavourites');
        //If no loged in page redirect to login and reload with requested action
        if(typeof favouritesFoldersViewModel === 'undefined') {
            var originUrl = new URL(window.location.href);
            originUrl.searchParams.set('componentId', 'ValveConfigurationViewModel');
            originUrl.searchParams.set('action', 'sendVcFavourites');
            originUrl.searchParams.set('actionParams', '');

            var url = new URL(originUrl.origin + smc.channelPrefix + '/secured-resource');
            url.searchParams.set('resource', originUrl.toString().replace(originUrl.origin, ''));
            window.location = url;

            deferred.reject();
        } else {

            console.log('Logged');

            var modalDeferred = favouritesFoldersViewModel.show();
            modalDeferred.then(function (selectedFolder) {
                smc.NotifyComponent.info(labelStartSendingVcToFavourites);

            self.sendingProduct(true);

                console.log(selectedFolder);

                let syImageData = self.getImageData();

                $.ajaxHippo({
                    type: 'POST',
                    url: sendVcToFavouritesUrl,
                    data: {
                        folderId: selectedFolder,
                        syImage: syImageData
                    },
                    dataType: 'json',
                }).then(function(data) {
                    self.sendingProduct(false);
                    smc.NotifyComponent.info(BASKET_MESSAGES.favouritesSuccess);
                    if(!self.simpleSpecialCode() || !self.simpleSpecialCode().simpleSpecialCode()){
                        self.simpleSpecialCode(new SimpleSpecialData(data, null))
                    }
                    console.log('Correct');

                    stateMachine.controllers.tabs.afterUndoRedo();
                    self.isOpenedGroup(false);

                })
                .catch(function(e) {
                    self.sendingProduct(false);

                    smc.NotifyComponent.error(labelErrorSendingVcToBasket);
                });
                       

            }).catch(function(err) {
                deferred.reject(new BasketError(BASKET_ERROR_CODES.UI_MODAL_REJECTED));
            });

            deferred.resolve();

        }

        return deferred.promise();
    }

    self.getImageData = function() {
        var visibleElems = $('.input_element:visible, .manifold_d2:visible, .output_element:visible, .manifold_d:visible, .station_element:not(.label):visible, .manifold_u:visible, .mixed_element:visible');

        var leftmostOffset = visibleElems.filter(':first').offset().left;
        var rightmostCorner = visibleElems.filter(':last').offset().left
                + visibleElems.filter(':last').width();

        var totalWidth = rightmostCorner - leftmostOffset;

        var topmostOffset = $('.graphical_editor').offset().top;

        var totalHeight = 230;

        var syImageObj = visibleElems.map(
                function() {
                    var $this = $(this);
                    var selected = $this.hasClass('selected');
                    if (selected)
                        $this.removeClass('selected');
                    var bckImg = $this.css('backgroundImage')
                            .split('/').reverse()[0].replace('")', '');
                    var bckPos = $this.css('backgroundPosition');
                    if (!bckPos) {
                        bckPos = $this.css('backgroundPositionX') + ' '
                                + $this.css('backgroundPositionY');
                    }
                    var width = $this.width();
                    var height = $this.height();
                    var offset = $this.offset();
                    if (selected)
                        $this.addClass('selected');
                    if ($this.hasClass('block_disk')
                            && !$this.hasClass('no_image')
                            && bckImg == 'none')
                        return;
                    return {
                        image : bckImg,
                        position : bckPos,
                        height : height,
                        width : width,
                        top : offset.top - topmostOffset,
                        left : offset.left - leftmostOffset
                    };
                }).toArray();

        var visibleLabels = $('.graphical_editor .label:visible');

        var syLabelsObj = visibleLabels.map(function() {
            var $this = $(this);
            var text = $.trim($this.text());
            var bckColor = $this.css('backgroundColor');
            var width = $this.width();
            var height = $this.height();
            var offset = $this.offset();
            return {
                text : text,
                bckColor : bckColor,
                height : height,
                width : width,
                top : offset.top - topmostOffset,
                left : offset.left - leftmostOffset
            };
        }).toArray();

        var data = {
            imgElems : syImageObj.length,
            totalWidth : Math.round(totalWidth),
            totalHeight : Math.round(totalHeight)
        };
        for ( var i = 0; i < syImageObj.length; i++) {
            data['image_' + i] = syImageObj[i].image;
            data['position_' + i] = syImageObj[i].position;
            data['height_' + i] = Math.round(syImageObj[i].height);
            data['width_' + i] = Math.round(syImageObj[i].width);
            data['top_' + i] = Math.round(syImageObj[i].top);
            data['left_' + i] = Math.round(syImageObj[i].left);
        }

        data['lblElems'] = syLabelsObj.length;
        for ( var i = 0; i < syLabelsObj.length; i++) {
            data['l_text_' + i] = syLabelsObj[i].text;
            data['l_color_' + i] = syLabelsObj[i].bckColor.replace(
                    'rgb(255, 255, 255)', 'w').replace('rgb(0, 0, 0)',
                    'b').replace("black", "b").replace("white", "w");
            data['l_height_' + i] = Math.round(syLabelsObj[i].height);
            data['l_width_' + i] = Math.round(syLabelsObj[i].width);
            data['l_top_' + i] = Math.round(syLabelsObj[i].top);
            data['l_left_' + i] = Math.round(syLabelsObj[i].left);
        }

        return window.JSON.stringify(data)
                .replace(/[\(|\)|\{|\}]/g, '');
    }

    self.generateImage = function() {

        let deferred = $.Deferred();

        let syImageData = self.getImageData();

        $.ajaxHippo({
            type: 'POST',
            url: generateSyImageUrl,
            dataType : 'text',
            data: {
                syImage: syImageData
            },
            success: function(data) {
                deferred.resolve(data);
            }, error: function(e) {
                console.log('Error generating sy_image');
                deferred.reject();
            }
        });

        return deferred.promise();

    }

    self.openClosedConfiguration = function() {
        $.ajaxHippo({
            type: 'POST',
            url: openClosedConfigUrl,
            dataType: 'json',
            async: true
        }).then(function(res) {
            self.isOpenedGroup(true);
            stateMachine.controllers.tabs.afterUndoRedo();
            $('#valve_external_pdSummary').hide();
            if(isInternalUser) {
                var element = document.getElementById("sendVcToFavourites");
                element.setAttribute('data-configuration', 'invalid');
            }
        }, function(err) {
            console.log(err);
            smc.NotifyComponent.error(globalError);
        });
    }

    self.isOpenedGroup.subscribe(function (newValue) {
        if(newValue) {
            stateMachine.closedConfiguration = 'false';
            self.creatingProcess(true);
            self.isPricesTable(false);
            self.simpleSpecialCode(new SimpleSpecialData(null, null));
        } else {
            stateMachine.closedConfiguration = 'true';

            // Reload table
            self.loadSimpleSpecial(true);

        }
        console.log('Send advise to state machine closed configuration : ' + stateMachine.closedConfiguration);
    });

    self.enabledSimpleSpecial.subscribe(function(newValue) {
        if(!newValue) {
            resetValues();
        } else {
            self.loadSimpleSpecial(self.isPricesTable());
        }
    });

    $('#load-btn').on('click', function(){
        console.log("loadButton");
        self.showModalContact(true);
    });

    self.isOpenedGroup(isOpenedGroup);
    self.creatingProcess(creatingProcess);

    $(document).trigger('smc.registercomponent', ['ValveConfigurationViewModel', self]);

}