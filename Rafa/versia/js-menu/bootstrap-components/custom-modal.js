function createSimpleModal(modalId) {

    var deferred = $.Deferred();

    var confirm = $('#' + modalId);
    confirm.modal('show');

    var confirmButton = confirm.find('#btn-submit');
    var cancelButton = confirm.find('#btn-return');

    $('#' + modalId).on('hidden.bs.modal', function () {
        $('#' + modalId).modal('hide');
        deferred.resolve();
    });

    $('#' + modalId).on('shown.bs.modal', function() {
        confirmButton.focus();
    });

    confirmButton.off('click').click(function (event) {
        deferred.resolve();
    });

    cancelButton.off('click').click(function (event) {
        deferred.resolve();
    });

    return deferred.promise();

}

function createConfirmDialog(modalId, title, message, cancelString, confirmString, isConfirmation, callback) {

    var deferred = $.Deferred();

    var defaultClassCancel = "btn-secondary";
    var alternativeClassCancel = "btn-primary";

    var confirm = $('#' + modalId);
    confirm.modal('show');

    var confirmButton = confirm.find('#btn-submit');
    var cancelButton = confirm.find('#btn-return');

    $('#' + modalId).on('hidden.bs.modal', function () {
        $('#' + modalId).modal('hide');
        if (callback) callback(false);
        if (isConfirmation) {
            deferred.reject();
        } else {
            deferred.resolve();
        }
    });

    $('#' + modalId).on('shown.bs.modal', function() {
        if(isConfirmation) {
            confirmButton.focus();
        } else {
            cancelButton.focus();
        }
    });

    if (title) {
        confirm.find('.modal-title').html(title);
    }

    if (message) {
        confirm.find('.modal-message').html(message);
    }

    if(cancelString) {
        cancelButton.html(cancelString);
    }
    cancelButton.html(cancelString).off('click').click(function (event) {
        event.preventDefault();
        event.stopPropagation();
        confirm.modal('hide');
        if (callback) callback(false);
        if (isConfirmation) {
            deferred.reject();
        } else {
            deferred.resolve();
        }
    });

    if (isConfirmation) {

        confirmButton.show();
        cancelButton.removeClass(alternativeClassCancel);
        cancelButton.addClass(defaultClassCancel);
        if(confirmString){
            confirmButton.html(confirmString);
        }

        confirmButton.off('click').click(function (event) {
            event.preventDefault();
            event.stopPropagation();
            confirm.modal('hide');
            if (callback) callback(true);
            deferred.resolve();
        });

    } else {

        confirmButton.hide();
        cancelButton.removeClass(defaultClassCancel);
        cancelButton.addClass(alternativeClassCancel);

    }

    return deferred.promise();

}

function createConfirmAsyncDialog(modalId, title, message, cancelString, confirmString, isConfirmation, alertId, callback) {

    var confirm = $('#' + modalId);
    confirm.modal('show');

    var confirmButton = confirm.find('#btn-submit');
    var cancelButton = confirm.find('#btn-return');
    var errorMessage = confirm.find('#' + alertId);

    $('#' + modalId).on('hidden.bs.modal', function () {
        $('#' + modalId).modal('hide');
        if (callback) callback(false);
    });
    
    $('#' + modalId).on('shown.bs.modal', function() {
        confirmButton.focus();
    });

    if (title) {
        confirm.find('.modal-title').html(title);
    }

    if (message) {
        confirm.find('.modal-message').html(message);
    }

    cancelButton.html(cancelString).off('click').click(function () {
        if (callback) callback(false)
            .then(function () {
                confirm.modal('hide');
            })
            .catch(function () {
                confirm.modal('hide');
            });
    });

    if (isConfirmation) {

        confirmButton.show();
        confirmButton.html(confirmString).off('click').click(function (event) {
            event.preventDefault();
            event.stopPropagation();
            if (callback) {
                callback(true)
                    .then(function () {
                        confirm.modal('hide');
                    })
                    .catch(function (mssg) {
                        errorMessage.attr("hidden", false);
                        errorMessage.html(mssg);
                    });
            }
        });

    } else {

        confirmButton.hide();

    }

}