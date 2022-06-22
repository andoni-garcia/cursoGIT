var smc = smc || {};

smc.dc = {

    handleComponentLoaded: function (e, component) {
        var $component = $(component);

        smc.dc.updatePageTitle($component);
        smc.dc.updateBreadCrumbs($component);
        smc.dc.updateExpandButtons();
    },

    updatePageTitle: function ($component) {

        var pageTitle = $component.data('title');
        if (typeof pageTitle !== 'undefined') {
            var suffix = "";
            if(document.title.split("|")[1] != undefined){
                var suffix = " |" + document.title.split("|")[1];
            }
            document.title = pageTitle + suffix;
        }
    },

    updateBreadCrumbs: function ($component) {
        var regularBreadCrumbs =  smc.breadcrumbs;
        if (typeof regularBreadCrumbs !== 'undefined') {
            regularBreadCrumbs.replaceWith($component.find(".dc-bc"));
            $(".dc-bc").parent().show();
            let $refreshDataBanner = $("#refresh-data-banner");
            if ($refreshDataBanner && $refreshDataBanner.length > 0) {
                $refreshDataBanner.insertBefore($(".dc-bc").parent());
                $refreshDataBanner.addClass("margin-top-menu");
            }
        }

        //Collapsible Breadcrumbs
        $('.open-breadcrumbs-link-js').click(smc.dc.openCollapsedBreadcrumb);
    },

    updateExpandButtons: function (){
        CatTile.addExpandButtons();
        CatTile.addMobileEmptyCheck();
        CatTile.adaptHeight();
    },

    openCollapsedBreadcrumb: function(event) {
        var $dotsElement = $(event.target);
        var $breadcrumbsContainer = $dotsElement.closest('.breadcrumbs');
        $dotsElement.parent().remove();
        $breadcrumbsContainer.find('li').removeClass('hidden');
    }
};

smc.dc.urls = {
    compareProducts: document.getElementById('compareProductsLink') ? document.getElementById('compareProductsLink').href : ""
};

var $body = $('body');
$body.on('dc-component-loaded', smc.dc.handleComponentLoaded);
$body.on('dc-product-component-loaded',  smc.dc.updateExpandButtons); //Do not update title and breadcrumbs for product collection component
$body.on('dc-families-loaded', function(){
    ProductCatalogue.init(); //It will just call the function to readjust all families "boxes" in the families summary view
});