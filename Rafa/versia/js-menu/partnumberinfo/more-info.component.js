/**
 * MoreInfo component to create product toolbar layers through an ajax request to the server.
 *
 *
 *
 * TODO: Create a tooltip cache to avoid multiple http requests for the same part number.
 * TODO: Update tooltips on window resize.
 */

function MoreInfoComponent(opts) {
    var self = this;


    //Consts
    const DESKTOP = 0;
    const MOBILE = 1;
    const defaultOpts = {
        onResize: false,
        desktopDivId: "#moreInfo",
        mobileDivId: "#moreInfoMobile",
        textId: "#moreInfoText",
    };

    /* Media queries */
    const DESKTOP_MQ = window.matchMedia('(min-width: 992px)');
    let openedTooltip = {};
    let currentMedia = -1;

    opts = $.extend(opts, defaultOpts);

    //Enable on resize
    if (opts.onResize) {
        window.onresize = updateOnResize();
    }


    self.getValveInfo = function (partNumber, boxId, data) {
        if (!partNumber) {
            console.error("Partnumber required");
            return smc.NotifyComponent.error(moreInfoNotAvailableMssg);
        }

        doGetTemplate(partNumber)
            .then(function (res) {
                return isValidResponse(res);
            })
            .then(function (res) {
                return completeValveInfo(res, boxId, data);
            })
            .catch(function (err) {
                return smc.NotifyComponent.error(moreInfoNotAvailableMssg);
            });

    }


    const completeValveInfo = function (template, boxId, data) {
        const listItems = ['<li><span><a href="#!" id="saveConfiguration" class="iconed-text"><@fmt.message key="saveConfiguration"/><i class="fas fa-save"></i></a></span> </li>']; //Build them with data attributes

        let container = $('#' + boxId);
        $(container).html(template);
        let title = $(container).find("h2.heading>span");
        let listContainer = $(container).find("ul");

        title.text('Aqui tu titulo');
        _.each(listItems, function (item) {
            let li = document.createElement('li');
            li.append(item);
            $(listContainer).append(item);
        });
    }



    self.getTooltip = function (partNumber, index, source, type, description) {
        if (!partNumber || index === null || typeof index === 'undefined') {
            console.error("Partnumber and index required");
            return smc.NotifyComponent.error(moreInfoNotAvailableMssg);
        }

        if (!isOpened(index)) {
            startLoading(index);
            closeTooltip(openedTooltip.index); //Close opened tooltip different from current

            openedTooltip = { //Set as new opened tooltip
                index: index,
                media: DESKTOP_MQ.matches ? DESKTOP : MOBILE
            };

            doGetTemplate(partNumber, source, type, description)
                .then(function (res) {
                    return isValidResponse(res);
                })
                .then(function (res) {
                    return DESKTOP_MQ.matches ? setDesktopTooltip(res, index) : setMobileTooltip(res, index);
                })
                .catch(function (err) {
                    return smc.NotifyComponent.error(moreInfoNotAvailableMssg);
                })
                .then(function () {
                    return endLoading(index);
                });
        }
    }


    self.getIconTooltip = function (partNumber, source, type, description) {
        if (!partNumber) {
            console.error("Partnumber required");
            return smc.NotifyComponent.error(moreInfoNotAvailableMssg);
        }

        doGetTemplate(partNumber, source, type, description)
            .then(function (res) {
                return isValidResponse(res);
            })
            .then(function (res) {
                return setIconTooltip(res, partNumber);
            })
            .catch(function (err) {
                return smc.NotifyComponent.error(moreInfoNotAvailableMssg);
            });

    }


    const setDesktopTooltip = function (template, index) {
        let text = $(opts.textId + index);
        let desktopDiv = $(opts.desktopDivId + index);

        //<div class="more-info-container">
        //<i class="fa fa-times more-info-close pointer text-danger" onClick="toggleMoreInfoBox(this);"/>
        const container = document.createElement('div');

        const i = document.createElement('i');
        i.addEventListener('click', toggleMoreInfoBox);
        i.classList = 'fa fa-times more-info-close pointer';
        $(container).append(i);
        $(container).append(template);
        $(desktopDiv).append(container);
        $(text).addClass("more-info-selected");
    }


    const setMobileTooltip = function (template, index) {

        let text = $(opts.textId + index);
        let mobileDiv = $(opts.mobileDivId + index);

        $(mobileDiv).html(template);
        $(mobileDiv).addClass("show");
        $(text).addClass("more-info-selected");
    };

    const setIconTooltip = function (template, partNumber) {
        let container = $('#iconMoreInfoModal');
        $(container).html(template);
        let title = $(container).find("h2.heading>span");

        title.append('[' + partNumber + ']');

        $(container).find("h2.heading").addClass('more-info-icon--title');
        $(container).find("h2.heading").append('<div class="smc-close-button more-info-icon--close" id="iconMoreInfoModalClose">×</div>');

        $(container).removeClass('hide');
        $(container).on('click', function (e) {
            e.preventDefault();
            e.stopPropagation();
            if($(e.target).parent('a').length) {
                let src = $(e.target).parent('a')[0].href;
                if(src !== undefined && src !== '' && src !== 'javascript:void(0);') {
                    window.open(src,'_blank');
                }
            }
            if (e.target !== this) return;
            hideIconTooltipEvent(e, container);
        });

        $("#iconMoreInfoModalClose").on('click', function (e) {
            e.preventDefault();
            e.stopPropagation();

            hideIconTooltipEvent({ target : container }, container);
        });
    }

    const hideIconTooltipEvent = function (e, target) {
        if (e.target !== $(target)) {// Clicking outside of component => Close
            $(target).addClass('hide');
            $(target).empty();
            $('#iconMoreInfoModal').off('click');
        }
    }

    const isOpened = function (index) {
        if (index === openedTooltip.index) {
            openedTooltip = {
                index: -1, //Reset current opened tooltip
                media: DESKTOP_MQ.matches ? DESKTOP : MOBILE
            };
            closeTooltip(index);
            return true;
        };
        return false;
    };

    const isValidResponse = function (response) {
        let deferred = $.Deferred();

        if (!response || response.trim().length === 0) {
            return deferred.reject("This product has not more info");
        }
        return deferred.resolve(response);
    };

    const startLoading = function (index) {
        let spinner = $("#spinner" + index);
        let text = $(opts.textId + index);

        $(spinner).addClass('show').removeClass("ko-hide");
        $(text).addClass('ko-hide');
    };

    const endLoading = function (index) {
        let spinner = $("#spinner" + index);
        let text = $(opts.textId + index);

        $(spinner).removeClass('show').addClass("ko-hide");
        $(text).removeClass('ko-hide');
    };

    /**
     * Returns a promise with the toolbar html
     */
    const doGetTemplate = function (partnumber, source, type, description) {
        let deferred = $.Deferred();
        let typeQueryParam = type && type.length ? '&type=' + type : '';
        let descriptionQueryParam = description && description.length ? '&description=' + encodeURIComponent(description) : ''; 
        $.ajaxHippo({
            type: 'POST',
            url: moreInfoDetailsUrl + '&partNumber=' + partnumber + '&source=' + source + typeQueryParam + descriptionQueryParam,
            async: true,
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
        return deferred;
    };

    /**
     * Close opened tooltip
     */
    const closeTooltip = function (closeIndex) {

        let tooltip;
        let text;

        let tooltipDivId = openedTooltip.media === DESKTOP ? opts.desktopDivId : opts.mobileDivId;
        let index = isValidIndex(closeIndex) ? closeIndex : openedTooltip.index;
        tooltip = $(tooltipDivId + index);

        if (isValidIndex(closeIndex) && openedTooltip.media !== MOBILE) { //Close opened tooltip
            text = $(opts.textId + index);
            $(text).removeClass("more-info-selected");
            $(tooltip).removeClass("show");
        } else if (isValidIndex(openedTooltip.index)) {
            text = $(opts.textId + index);
            $(text).removeClass("more-info-selected");
        }
        checkChildrenNumber(index);
    };




    /**
     * Moves component if viewport changes
     */
    const updateOnResize = function () {

    }


    const isValidIndex = function (index) {
        return index || index === 0;
    }

    const toggleMoreInfoBox = function toggleMoreInfoBox(e){
       if(openedTooltip && openedTooltip.index !== undefined) {
            isOpened(openedTooltip.index);
           let desktopDiv = $(opts.desktopDivId + openedTooltip.index);
            $(desktopDiv).collapse('hide');
       }
    
    }
    
    const checkChildrenNumber = function(index){
        $(".more-info-tab-item").each(function(){
            // $(this).empty();
            if (this.id.indexOf("spinner") < 0){
                $(this).empty();
            }
        });
    }


}
