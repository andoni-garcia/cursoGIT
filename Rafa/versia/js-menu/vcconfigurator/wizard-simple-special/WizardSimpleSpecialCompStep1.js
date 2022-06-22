(function (globalKoUtils) {

    const STEP_NUMBER = 1;
    const STEP = 'step-' + STEP_NUMBER;

    function WssCustomer(numberParam, nameParam, addressNameParam, zipParam){
        this.customer = {
            number: numberParam,
            name: nameParam
        };
        this.address = {
            name: addressNameParam,
            zip: zipParam
        };
        this.active = ko.observable(false);
    }

    function WssStep1ViewModel(params, nodes) {
        var self = this;

        var rootVm = params.parentVm;
        rootVm.stepComponents[STEP] = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();

        var displayingStep = params.displayComponentStep;

        self.loading = ko.observable(true);

        self.selectedCustomer = ko.observable(null);
        self.customerNumber = ko.observable('');
        self.customerName = ko.observable('');

        self.listOfCustomers = ko.observableArray([]);

        self.showError = ko.observable(true);
        self.errorType = ko.observable(6);

        self.versioningPermission = rootVm.versioningPermission;
        self.versioningState = rootVm.versioningState;
        self.versioningChildComponent = null;

        self.loadingData = ko.observable(false);

        var getCustomers = function() {
            self.loadingData(true);
            self.REPOSITORY.doGetCustomers(self.customerNumber(), self.customerName(), {
                success: function(res) {
                    var listOfCustomers = [];
                    var response = res.response.customers;
                    var status = res.response.state;
                    for(var i=0; i<response.length; i++) {
                        var responseElement = response[i];
                        var customer = new WssCustomer(responseElement.customerNumber, responseElement.customerName, responseElement.addressName, responseElement.zip);
                        listOfCustomers.push(customer);
                    }
                    self.showError(status !== 0);
                    self.errorType(status);
                    self.listOfCustomers(listOfCustomers);
                    self.loadingData(false);
                }, error: function(err) {
                    self.loadingData(false);
                }
            });
        }

        self.selectCustomer = function(customer) {
            if(self.selectedCustomer()) {
                self.selectedCustomer().active(false);
            }

            customer.active(true);
            self.selectedCustomer(customer);
            self.validation();

            rootVm.selectedCustomerNumber(customer.customer.number);
            rootVm.selectedCustomerName(customer.customer.name);
        }

        self.getFilteredCustomers = function() {
            getCustomers();
        }

        self.reset = function() {
            self.customerNumber('');
            self.customerName('');
            rootVm.selectedCustomerNumber(null);
        }

        self.isShowingComponent = ko.pureComputed(function(){
            if((displayingStep && currentPage() === displayingStep) || !displayingStep) {
                self.getCustomers();
                return true;
            }
            return false;
        });

        self.validation = function() {
            var step1Condition = self.selectedCustomer() == null;
            var versioningCondition = false;
            if (self.versioningPermission && self.versioningChildComponent != null) {
                versioningCondition = self.versioningChildComponent.validation();
            }
            rootVm.disableNext(step1Condition || versioningCondition);
        }

        /**
         * Called from root viewmodel
         */
        self.defaults = function() {
            if(self.selectedCustomer() != null) {
                self.selectedCustomer().active(false);
            }
            self.selectedCustomer(null);
            self.customerNumber('');
            self.customerName('');
            self.listOfCustomers([]);
            self.showError(true);
            self.errorType(6);
            self.loadingData(false);
            self.versioningState(false);
        }

        self.loading(false);

    }

    ko.components.register('smc-wss-' + STEP, {
        viewModel: {

            createViewModel: function(params, componentInfo) {
                return new WssStep1ViewModel(params, componentInfo.templateNodes);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)