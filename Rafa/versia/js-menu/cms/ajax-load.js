var osudio = osudio || {};

$(document).ready(function () {

    $('.component-render-placeholder').each(function () {
        osudio.ajax.renderComponentByAjax($(this));
    });

});

osudio.ajax = {

    /**
     * Render the actual HTML by substituting the placeholder
     *
     * @param $cPlaceholder
     * @author RafaCastelblanque
     */
    renderComponentByAjax: function ($cPlaceholder) {
        if ($cPlaceholder.length == 0) {
            return;
        }
        var componentUrl = $cPlaceholder.data('url');
        $.get(componentUrl)
            .done(function (data) {
                var $newNode = $(data);
                $cPlaceholder.replaceWith($newNode);

                var $component = $newNode.find('[data-event]');
                if ($component.length > 0) {
                    var eventName = $component.data('event');
                    $component.removeAttr('data-event');
                    $newNode.trigger(eventName, $component);
                }
            })
            .fail(function(xhr, textStatus, errorThrown ) {
                var $reponseText = $(xhr.responseText);

                var $errorWrap = $('<div>').addClass('component-error container');
                var $errorMessage;
                if ($reponseText.find('.page-error').length > 0) {
                    $errorMessage = $('<div>').html($reponseText.find('.page-error'));
                } else {
                    var $errorTitle = $('<h1>').addClass('heading-02 heading-main').html(xhr.status + " - " + textStatus);
                    $errorMessage = $('<p>').html(errorThrown);
                }
                $errorWrap.append($errorTitle).append($errorMessage);
                $cPlaceholder.replaceWith($errorWrap);
            });
    },

};