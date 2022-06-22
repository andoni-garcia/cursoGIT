(function(ko){
    ko.components.register('ik-ajax-wait', {
        viewModel: function(params) {
            var self = this;
            self.ajaxWait = {
                width : ko.observable(0 + 'px'),
                height: ko.observable(0 + 'px')
            };
            var selector = params["selector"];
            var subsFunc = function(val){
                if (val){
                    var elem = $(selector);
                    self.ajaxWait.width(elem.width() + 'px');
                    self.ajaxWait.height(elem.height() + 'px');
                }
            };
            if ($.isArray(params["subscribeTo"])){
                params["subscribeTo"].forEach(function(elem){
                    elem.subscribe(subsFunc);
                });
            }
            console.log(params);
        },
        template: { name : 'ajax_wait'}
    });
})(ko);