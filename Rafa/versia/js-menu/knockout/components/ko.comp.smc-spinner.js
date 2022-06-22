ko.components.register('smc-spinner-inside-element', {
    viewModel: function (params) {

        var self = this;

        self.isButton = params.isButton;
        self.backgroundColor = params.backgroundColor;

        self.loaded = ko.observable(false);
        self.loading = ko.observable(params.loading);
        self.loaded(true);

    },
    template: { name : 'smc-spinner-inside-element'}
});
