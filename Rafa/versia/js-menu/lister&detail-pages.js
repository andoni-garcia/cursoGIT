
var smc = smc || {};

smc.news_details = $("#news-detail");
smc.news_facets = $("#news-facets");
smc.selector_facets = $(".facet-select");

$(document).ready(function () {

    smc.news.updatePageTitle(smc.news_details);
    smc.news.updateBreadCrumbs();
    smc.news.updateSelectorsFacets();


});


smc.news = {
    //Duplicated from the updatePageTitle form the digital catalog js, but it can be different depending on business requirements
    updatePageTitle: function ($component) {
        var pageTitle = $component.data('title');
        if (typeof pageTitle !== 'undefined') {
            var suffix = "";
            if(document.title.split("|")[1] != undefined){
                suffix = " |" + document.title.split("|")[1];
            }
            document.title = pageTitle + suffix;
        }
    },

    // Updating breadcrumbs depending on the page:
    // - For Detail Page: Replace Title Page from the sitemap with the actual title of the document
    // - For the lister pages with faceting, remove the additional elements of the breadcrumbs generated automatically
    updateBreadCrumbs: function () {
        if(smc.news_details.length){
            var pageTitle = smc.news_details.data('title');
            if (typeof pageTitle !== 'undefined') {
                smc.breadcrumbs.find("li:last-child").text(pageTitle);
            }
        } else if (smc.news_facets.length){
            smc.breadcrumbs.find("li").slice(2).remove();
        }
    },

    updateSelectorsFacets: function(){
        //Making the first option ("search by ...") the one that holds the remove facet option, instead of the selected one
        $(".remove-option").each(function() {
            $(this).prev('option.first-option').val($(this).val());
            $(this).val("");
        });
        //Every time the selector changes, we reload the lister with the selected facet
        smc.selector_facets.on('change', function (e) {
            window.location.href = $(this).find("option:selected").val();
        });
        //If there's at least one option selected, we show the button
        smc.selector_facets.find("option").each(function() {
            $(this).attr("selected") != undefined ?  $("button#reset").parent().show() : "";
        });

        //Using the link from the last element of the breadcrumb (always the current page without facets) for the reset button
        $("button#reset").on("click", function() {
            window.location.href = smc.breadcrumbs.find("li").last().find("a").attr("href");
        })
    }
}