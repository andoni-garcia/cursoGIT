
var smc = smc || {};
smc.upload_button = $(".browse-btn");
smc.file_info = $(".file-info");
smc.real_input = $("#file_input");
smc.file_name = $(".ss-attachment-title");
smc.discardChanges =$(".discardChanges");
smc.confirm_quit_button = $("#modal-confirm-quit .btn-primary");
smc.redirectList = $(".redirectList");
smc.confirm_quit_button_new = $("#modal-confirm-quit-new .btn-primary");
smc.modal = false;

$(document).ready(function () {
    $("#date").datepicker({dateFormat: "dd/mm/yy",altFormat : 'yy-mm-dd'});
    smc.form.uploadFiles();
    smc.form.discardChanges();
    setTimeout(function(){
        $(".temporary").slideUp();
    }, 4000);

    $("input, textarea, select").change(function () {
        smc.modal = true;
    });

});


smc.form = {
    uploadFiles: function(){

        smc.upload_button.on("click", function() {
            smc.real_input.click();
        });

        smc.real_input.on('change', function (e) {
            if ($(this).prop('files').length > 0) {
                var file = e.target.files[0];
                smc.file_name.html(file.name);
            }
        });
    },

    //Redirect to the last search made in success stories list stored in the cookie
    discardChanges: function () {

        smc.discardChanges.on('click', function (e) {
            if(smc.modal == true) {
                createSimpleModal('modal-confirm-quit');
            }else{
                window.history.back();
            }
        });

    }
}