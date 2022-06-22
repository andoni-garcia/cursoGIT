
$(document).ready(function(){

    var $formErrors = $("#feedbackPanel [data-formcontrol]");

    $formErrors.each(function(){
       var $error = $(this);
       var formControl = $error.data('key');
       console.log(formControl);
       var $control = $("form .form-control[name=" + formControl + "]");
       $control.addClass("is-invalid");
       $control.closest(".form-group__inputWrapper").addClass("is-invalid");

       $control.after($("<div>").addClass('invalid-feedback').html($error.html()));

    });

    $('.smc-date-pick__datepicker').datepicker({
        startDate: '-100y',
        todayHighlight: true
    }).on('show', function(e) {
        $('.smc-date-pick__datepicker').trigger('blur');
    }).on('changeDate', function(e) {
        $(this).datepicker('hide');
        if ($(this).val() !== ""){
            $(this).addClass("is-valid").removeClass("is-invalid");
            $(this).click();
            $(this).trigger("blur");
        }
    });

/*    $("form .form-control").each(function(){
       var $control = $(this);
       $control.removeClass("is-invalid");
    });*/

    //Show attached file/s on the right position of the button
    $('.smc-file-upload input[type="file"]').change(function (e) {
            var files = [];
            for (var i = 0; i < $(this)[0].files.length; i++) {
                files.push($(this)[0].files[i].name);
            }
    		$(this).parent().next().html(files.join(', '))
    });
});