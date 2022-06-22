
var smc = smc || {};
smc.selector_facets = $(".facet-select");
smc.selector_ordering = $(".ordering-select");
smc.delete_button = $("#delete-button");
smc.confirm_delete_button = $("#modal-confirm-delete .btn-primary");
smc.check_all = $("#approvecheck-all");
smc.approve_stories = $("#approve-stories");
smc.disapprove_stories = $("#disapprove-stories");
smc.export_stories = $(".exportPDF");
smc.redirectList = $(".redirectList");

var REPOSITORY = new SuccessStoriesRepository();

$(document).ready(function () {
    smc.ss.updateSelectorsFacets();
    smc.ss.approveDisapprove();
    smc.ss.exportStories();
    //smc.ss.deleteStory();
    setTimeout(function(){
        $(".temporary").slideUp();
    }, 4000);
});


smc.ss = {
    updateSelectorsFacets: function(){
        //Making the first option ("search by ...") the one that holds the remove facet option, instead of the selected one
        $(".remove-option").each(function() {
            $(this).prev('option.first-option').val($(this).val());
            $(this).val("");
        });
        //Every time the selector changes, we reload the list applying the selected facet values
        smc.selector_facets.on('change', function (e) {
            window.location.href = $(this).find("option:selected").val();
        });

        //Every time the selector changes, we reload the list applying the chosen order
        smc.selector_ordering.on('change', function (e) {
            window.location.href = $(this).find("option:selected").val();
        });

        //Using the link from the last element of the breadcrumb (always the current page without facets) for the reset button
        $("button#reset").on("click", function() {
            window.location.href = smc.breadcrumbs.find("li").last().find("a").attr("href");
        });

        $('a.back').on("click", function() {
            parent.history.back();
            return false;
        });

        smc.delete_button.on("click", function() {
            createSimpleModal('modal-confirm-delete');
        });

        $('.dialog-close').on("click", function() {
            $(this).closest('.dialog').slideUp();
        });

    },

    //Function to approve/disapprove multiple success stories at the same time
    approveDisapprove: function(){
        //Check all the checkboxes of the table
        smc.check_all.on('click', function (e) {
            var check_all_status = this.checked;
            $(".ss-item-checkbox").each(function() {
                if(check_all_status == true){
                    $(this).attr('checked', true);
                    $(this)[0].checked = true;
                }else{
                    $(this).attr('checked', false);
                    $(this)[0].checked = false;
                }
            });
        });

        smc.approve_stories.on('click', function (e) {
            e.preventDefault();
            $("#success-disapprove").css("display", "none");
            $("#success-approve").css("display", "block");
            $('html,body').animate({
                scrollTop: $(".breadcrumbs").offset().top
            }, 'slow');
        });

        smc.disapprove_stories.on('click', function (e) {
            e.preventDefault();
            $("#success-approve").css("display", "none");
            $("#success-disapprove").css("display", "block");
            $('html,body').animate({
                scrollTop: $(".breadcrumbs").offset().top
            }, 'slow');
        });
    },

    //Export Component
    exportStories: function(type){
        smc.export_stories.on('click', function (e) {
            e.preventDefault();
            REPOSITORY.doExportStories(type).then(
                function(res){
                    window.open(res);
                }
            ).catch(function(err){
                console.error(JSON.stringify(err))
                smc.NotifyComponent.error('Cannot export current success story');
            })
        });
    }
}