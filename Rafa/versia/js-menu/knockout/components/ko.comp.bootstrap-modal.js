ko.components.register('bs-modal-widget', {
    viewModel: function (params) {

        var self = this;
        self.loaded = ko.observable(false);

        //--------------------------------
        //--- Simple string for labels ---
        //--------------------------------
        //TODO -> ID For specify in modal ID's

        if (params.options && params.options.acceptLabel) {
            self.modalAcceptButton = params.options.acceptLabel;
        } else {
            self.modalAcceptButton = 'Ok';
        }

        if (params.options && params.options.cancelLabel) {
            self.modalCancelButton = params.options.cancelLabel;
        } else {
            self.modalCancelButton = 'Cancel';
        }

        if (params.options && params.options.id) {
            self.htmlId = params.options.id;
        } else {
            self.htmlId = 'customer-partnumber-modal-component';
        }
        var htmlIdentifier = '#' + self.htmlId;

        self.title = '';
        if (params.options && params.options.title) {
            self.title = params.options.title;
        }

        //--------------------------------
        //--------------------------------



        //--------------------------------
        //------ Required paramseters -----
        //--------------------------------

        //Received deferred
        self.receivedDefFn = params.options.deferredFn;


        //Visibility observable
        self.isVisible = params.options.isVisible;

        self.isVisible.subscribe(function (newValue) {
            if (newValue === true) {
                $(htmlIdentifier).modal('show');
            } else {
                $(htmlIdentifier).modal('hide');
            }
        });

        self.haveTemplate = false;
        self.userInnerHtml = false;
        if (params.options && params.options.templateName && params.options.templateData) {
            self.haveTemplate = true;
            self.templateName = params.options.templateName;
        } else {

            if (params.options && params.options.message) {
                self.message = params.options.message;
            } else {
                self.userInnerHtml = true;
            }

        }
        //--------------------------------
        //--------------------------------

        $(htmlIdentifier).on('hidden.bs.modal', function () {
            $(htmlIdentifier).modal('hide');
            self.isVisible(false);
        })

        self.loading = ko.observable(false);

        self.accept = function () {
            if (self.receivedDefFn) {
                self.loading(true);
                self.receivedDefFn().then(function (res) {
                    self.isVisible(false);
                }).always(function() {
                    self.loading(false);
                });
            } else {
                self.isVisible(false);    
            }
        }

        self.cancel = function () {
            self.isVisible(false);
        }

        self.loaded(true);

    },
    template: '<div class="modal fade ko-hide" data-bind="attr: {id: htmlId, \'data-bind\': \'\', visible: loaded}" role="dialog">\
        <div class="modal-dialog modal-lg">\
            <div class="modal-content">\
                <div class="modal-header">\
                    <h4 class="modal-title" data-bind="text: title, \'data-bind\': \'\'"></h4>\
                    <button type="button" class="close" data-bind="click: cancel.bind($data)">&times;</button>\
                </div>\
                <div class="modal-body">\
                    <!-- ko if: userInnerHtml -->\
                    <div data-bind="template: { nodes: $componentTemplateNodes }"></div>\
                    <!-- /ko -->\
                    <!-- ko if: !userInnerHtml -->\
                        <!-- ko if: haveTemplate -->\
                        <div data-bind="template: {name: templateName, data: templateData}"></div>\
                        <!-- /ko -->\
                        <!-- ko if: !haveTemplate -->\
                        <span data-bind="text: message"></span>\
                        <!-- /ko -->\
                    <!-- /ko -->\
                </div>\
                <div class="modal-footer">\
                    <button type="button" id="bs-modal-return" class="btn btn-secondary" data-bind="click: cancel.bind($data), text: modalCancelButton"></button>\
                    <button type="button" id="bs-modal-submit" class="btn btn-primary" data-bind="click: accept.bind($data), text: modalAcceptButton"></button>\
                </div>\
            </div>\
        </div>\
    </div>'
});