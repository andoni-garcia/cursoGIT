function CustomerContacInformation(data){
    this.id = data.id;
    this.address= data.address;
    this.company= data.company;
    this.email= data.email;
    this.fax= data.fax;
    this.name= data.name;
    this.phone= data.phone;
    this.town= data.town;
    this.zipCode= data.zipCode
    this.active=ko.observable(false);
}

ko.components.register('smc-modal-customer-contact', {
    viewModel: function (params) {

        const MODAL_ID = '#modal-customer-contact';

        var self = this;

        var showModalObservable = params.showModal;

        //Labels params
        self.titleLabel = params.titleLabel;
        self.confirmLabel = params.confirmLabel;
        self.cancelLabel = params.cancelLabel;
        self.noItemsLabel = params.noItemsLabel;

        self.titleReConfirmLabel = params.titleReConfirmLabel;
        self.bodyReConfirmLabel = params.bodyReConfirmLabel;

        var ignoreShowModalSubscribe = false;
        self.contactList = ko.observableArray([]);
        self.selectedData = ko.observable(null);

        var lastSelectedData = null;

        var deferred = null;

        /**
         * Get list of contacts
         */
        var doGetContactList = function () {
            return $.ajaxHippo({
                type: 'POST',
                url: loadContactsByDesignerURL,
                dataType: 'json',
                async: true
            });
        }

        var doRemoveContact = function(idParam) {
            return $.ajaxHippo({
                type: 'POST',
                url: deleteCustomerByIdURL,
                data: {
                    customerId: idParam
                },
                
                async: true
            });
        }
        
        var doSaveCustomerOnCache = function(customer) {
        	return $.ajaxHippo({
                type: 'POST',
                url: saveCustomerOnCacheUrl,
                data: {
                	customerContact: JSON.stringify(customer)
                }
            });
        }

        self.selectCustomer = function(selectedDataParam) {
            if(lastSelectedData != null) {
                lastSelectedData.active(false);
            }
            selectedDataParam.active(true);
            self.selectedData(selectedDataParam);
            lastSelectedData = self.selectedData();
            console.log(selectedDataParam);
        }

        self.deleteCustomer = function(selectedDataParam) {

            doRemoveContact(selectedDataParam.id).then(function() {
                let updatedList = _.filter(self.contactList(), function(contact){
                    return contact. id !== selectedDataParam.id;
                });
                self.contactList(updatedList);

                if(self.selectedData() && selectedDataParam.id === self.selectedData().id) {
                    self.selectedData(null);
                }
                
            }).catch(function(err){
                console.log(err);
            })

        }

        self.confirm = function() {
            if(self.selectedData()) {
                $('#id').val(self.selectedData().id);
                $('#contactName').val(self.selectedData().name);
                $('#contactCompany').val(self.selectedData().company);
                $('#contactInputEmail4').val(self.selectedData().email);
                $('#contactAddress').val(self.selectedData().address);
                $('#contactTelephone').val(self.selectedData().phone);
                $('#contactTown').val(self.selectedData().town);
                $('#contactFax').val(self.selectedData().fax);
                $('#contactZip').val(self.selectedData().zipCode);
                doSaveCustomerOnCache(self.selectedData()).always(function() {
                	deferred.resolve();
                    resetModalData();
                });
                
            }
        }

        self.cancel = function() {
            deferred.reject();
            resetModalData();
        }

        //Reset modal
        var resetModalData = function() {
            self.selectedData(null);
            showModalObservable(false);
        }

        //Jquery functions
        $(MODAL_ID).on('hidden.bs.modal', function () {
            resetModalData();
            deferred.reject();
            showModalObservable(false);
        });

        showModalObservable.subscribe( function(newValue) {
            if(!ignoreShowModalSubscribe) {
                if(newValue) {
                    doGetContactList().then(function(res){
                        self.contactList([]);
                        var temporalArray = [];
                        for(var i = 0; i<res.length; i++) {
                            var customer = new CustomerContacInformation(res[i]);
                            temporalArray.push(customer);
                        }
                        self.contactList(temporalArray);
                    });
                    $(MODAL_ID).modal('show');
                    deferred = $.Deferred();
                    params.selectedDataParam = deferred.promise();
                } else {
                    $(MODAL_ID).modal('hide');
                }
            }
        });

    },
    // Mandatory custom-modal.ftl inclusion with modal id specified in component
    template: { name: 'smc-modal-customer-contact' }
});