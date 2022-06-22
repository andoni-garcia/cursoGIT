var smc = smc || {};

/**
 * Detector for touch devices
 */
smc.isTouchDevice = false;
smc.breadcrumbs = $(".regular-bc");
window.addEventListener('touchstart', function onFirstTouch() {
    smc.isTouchDevice = true;

    // we only need to know once that a human touched the screen, so we can stop listening now
    window.removeEventListener('touchstart', onFirstTouch, false);
}, false);
//Collapsible Breadcrumbs


smc.openCollapsedBreadcrumb = function(event) {
    var $dotsElement = $(event.target);
    var $breadcrumbsContainer = $dotsElement.closest('.breadcrumbs');
    $dotsElement.parent().remove();
    $breadcrumbsContainer.find('li').removeClass('hidden');
};

$('.open-breadcrumbs-link-js').click(smc.openCollapsedBreadcrumb);

/**
 * Handler to avoid clicking on menu items with submenus.
 * Applies only to touch devices.
 *
 * @param e
 */
smc.mainMenuClickHandler = function (e) {
    var $a = $(this);
    var hasSiblings = $a.siblings().length > 0;
    if (smc.isTouchDevice && hasSiblings) {
        e.preventDefault();

    }
};

/**
* Small click event for subsidiaries page
 */
smc.toggleSubsidiary = function (e) {
    $(this).find(".subsidiary-info").collapse("toggle");

};

$(function () {

    // Main menu link click handler
    $('.parent-item').on('click', smc.mainMenuClickHandler);
    $('.container-country').on('click', smc.toggleSubsidiary);

});

var TextCollapse = function () {

    var that = this;

    this.component_description_collapse = function (selectorInit) {
        var $parentElement = $(selectorInit);
        var $image = $parentElement.find('.image');
        var $description = $parentElement.find('.description');
        var $toolbar = $parentElement.find('.product-toolbar-component');
        var imageH = $image.height();
        var descriptionH = $description.height();
        var toolbarH = $toolbar.height();
        var heights = [imageH, descriptionH, toolbarH].sort(function (a, b) {
            return a - b;
        });

        // same height for the 3
        $image.height(heights[1]);
        $description.height(heights[1]);
        $toolbar.height(heights[1]);

        // if description was higher, add class
        console.log(heights[1] < descriptionH);
        console.log(heights[1] + ' < ' + descriptionH);
        if (heights[1] < descriptionH) {
            $description.addClass('component__general-info--collapsed');
            var visibleHeight = that.custom_visible_height_for_collapse($description);
            var output = that.custom_truncate_text_on_collapse($description, visibleHeight);
            $description.html(output);
            $description.find('.collapsed').css('height', visibleHeight);
        }

    };

    this.custom_visible_height_for_collapse = function ($selector) {
        var lineHeight = $selector.css('line-height').replace(/px|pt|em|rem|\%|vw|vh/gi, '');
        var lines = $selector.height() / lineHeight;
        var floor_lines = Math.floor(lines);
        var visibleHeight = floor_lines * (lineHeight * .97);

        return visibleHeight + 'px';
    };

    this.custom_truncate_text_on_collapse = function ($selector, visibleHeight) {
        var initialHtml = $selector.html();
        var output = '<div class="collapsed" data-collapsed="true">' + initialHtml + '</div>';
        output += '<div class="collapse-switch" data-collapsed="true"></div>';

        $selector.on('click', '.collapse-switch', function () {
            var $collapsed = $selector.find('.collapsed');
            if ($collapsed.attr('data-collapsed') === 'true') {
                $collapsed.css('height', 'auto');
                $collapsed.parent().css('height', 'auto');
                $collapsed.attr('data-collapsed', "false");
                $(this).attr('data-collapsed', "false");
            } else {
                $collapsed.css('height', visibleHeight);
                $collapsed.parent().css('height', visibleHeight);
                $collapsed.attr('data-collapsed', 'true');
                $(this).attr('data-collapsed', "true");
            }
        });
        return output;
    }
};

var KEYCLOAK = "login.smc.eu";
var LOGIN_PARAM = "login=true";

$(function () {

    // Adjust
    var textCollapse = new TextCollapse();
    textCollapse.component_description_collapse('.category-component .row');
});

$(document).ready(function(){
    if (smc.isAuthenticated && window.location.href.indexOf("smc.eu") > 0){
        var comesFrom = document.referrer;
        if (comesFrom !== undefined && comesFrom.indexOf(KEYCLOAK) > 0 && comesFrom.indexOf(LOGIN_PARAM) > 0){
            window.dataLayer = window.dataLayer || [];
            dataLayer.push({ 'event': 'login successful' });
        }
    }
});