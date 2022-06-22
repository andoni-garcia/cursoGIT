(function(globalConfig) {

    var notificationOptions = {
        allow_dismiss: false,
        type: 'info',
        delay: 2000,
        z_index: 9999,
        placement: {
            from: 'top',
            align: 'center'
        },
        animate: {
            enter: 'animated fadeInDown',
            exit: 'animated fadeOutUp'
        }
    };

    function NotifyComponent() {}

    NotifyComponent.notify = info;
    NotifyComponent.info = info;
    NotifyComponent.warn = warn;
    NotifyComponent.error = error;

    function info(message) {
        notify(message, 'info');
    }

    function warn(message) {
        notify(message, 'warning');
    }

    function error(message) {
        notify(message, 'danger');
    }

    function notify(message, type) {
        notificationOptions.type = type;
        $.notify(message, notificationOptions);
    }

    globalConfig.NotifyComponent = globalConfig.NotifyComponent || NotifyComponent;
})(window.smc);