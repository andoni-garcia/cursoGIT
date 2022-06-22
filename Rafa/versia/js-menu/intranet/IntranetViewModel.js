
var smc = smc || {};
smc.selector_facets = $(".facet-select");
smc.selector_ordering = $(".ordering-select");
smc.icon_image = $(".imageIcon");
smc.icon_text = $(".textIcon");
smc.check_all = $("#ci_check-all");
smc.switch_icons = $("a.icons");



$(document).ready(function () {
    smc.intranet.updateSelectorsFacets();
    smc.intranet.addActiveClassToIcon();
    smc.intranet.checkboxesBehaviour();
    smc.intranet.keepFacetsBetweenListViews();
    setTimeout(function(){
        $(".temporary").slideUp();
    }, 4000);
});


smc.intranet = {
    updateSelectorsFacets: function(){
        //Every time the selector changes, we reload the list applying the selected facet values
        smc.selector_facets.on('change', function (e) {
            window.location.href = $(this).find("option:selected").val();
        });

        //Every time the selector changes, we reload the list applying the chosen order
        smc.selector_ordering.on('change', function (e) {
            window.location.href = $(this).find("option:selected").val();
        });

    },

    addActiveClassToIcon: function(){
        //Depending on which page we are (text list | image list), we add a class to an element or another
        if(window.location.href.includes("/images")){
            for (i = 0; i < smc.icon_image.length; i++) {
                $(smc.icon_image[i]).addClass("icons_active");
            }
        }else{
            for (i = 0; i < smc.icon_text.length; i++) {
                $(smc.icon_text[i]).addClass("icons_active");
            }
        }
    },

    checkboxesBehaviour: function(){
        //Check all the checkboxes of the table
        smc.check_all.on('click', function (e) {
            var check_all_status = this.checked;
            $(".ci_checkbox").each(function() {
                if(check_all_status == true){
                    $(this).attr('checked', true);
                    $(this)[0].checked = true;
                }else{
                    $(this).attr('checked', false);
                    $(this)[0].checked = false;
                }
            });
        });
    },

    keepFacetsBetweenListViews: function(){
        //On Communication Images, keep the facets when you swap the listing view

        var searchValue = "/images";
        var href = window.location.href;
        if(href.search(searchValue) == -1){
            searchValue = "images";
        }
        var startingPosition = href.search(searchValue) + searchValue.length;
        var url = href.substring(startingPosition, href.length);
        for (i = 0; i <  smc.switch_icons.length; i++) {
          smc.switch_icons[i].href += url;
        }
    }
}