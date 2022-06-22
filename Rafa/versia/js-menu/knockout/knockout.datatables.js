(function(ko){
    ko.components.register('ik-datatable-pager', {
        viewModel: function(params) {
            this.context = params.viewModel.datatable;
        },
        template: { name : 'datatables_pager'}
    });
    ko.components.register('ik-datatable-showing', {
        viewModel: function(params) {
            this.context = params.viewModel.datatable;
        },
        template: { name : 'datatables_showing'}
    });
    ko.components.register('ik-datatable-records-selector', {
        viewModel: function(params) {
            this.context = params.viewModel.datatable;
            this.clear = typeof params["clear"] === 'undefined' ? true : params["clear"];
            this.cssClass = params.viewModel.css || "ikRecordsPerPageRow";
        },
        template: { name : 'datatable_records_selector'}
    });
    ko.components.register('ik-datatable-empty', {
        viewModel: function(params) {
            this.context = params.viewModel;
        },
        template: { name : 'datatable_empty'}
    });
    ko.components.register('ik-datatable-sorting', {
        viewModel: function(params) {
            this.context = params.viewModel.datatable;
            this.clear = typeof params["clear"] === 'undefined' ? true : params["clear"];
            this.cssClass = params.viewModel.css || "ikSortingSelectorRow";
        },
        template: { name : 'datatable_sorting'}
    });
    ko.components.register('ik-datatable-ajax-wait', {
        viewModel: function(params) {
            var self = this;
            this.context = params.viewModel;
            //initialized
            var contelem = $(params["selector"] ? params["selector"] : "#" + self.context.datatable.container);
            this.context.datatable.ajaxWait = {
                // width : ko.observable(0 + 'px'),
                // height: ko.observable(0 + 'px'),
                width : ko.observable(contelem.width() + 'px'),
                height: ko.observable(contelem.height() + 'px')
            };

            var selector = params["selector"] ? params["selector"] : "#" + self.context.datatable.container;
            var subsFunc = function(val){
                if (val){
                    var elem = $(selector);
                    self.context.datatable.ajaxWait.width(elem.width() + 'px');
                    self.context.datatable.ajaxWait.height(elem.height() + 'px');
                }
            };
            this.context.datatable.loading.subscribe(subsFunc);
            if ($.isArray(params["subscribeTo"])){
                params["subscribeTo"].forEach(function(elem){
                    elem.subscribe(subsFunc);
                });
            }
            console.log(params);
        },
        template: { name : 'datatable_ajax_wait'}
    });
})(ko);
