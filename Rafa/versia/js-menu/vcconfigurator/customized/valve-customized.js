function ManifoldCustomizer() {

    let self = this;

    const changeCustomized = function(isCustomized) {
        if(isCustomized) {

            // Enable '3D preview' -if not custom items in configuration-
            if( $(".show-3d-preview").length > 0){
                $(".show-3d-preview")[0].classList.remove("customManifold");
                // Check if custom items in configuration to enable '3D preview'
                if( !$(".show-3d-preview").hasClass( "customConf" ) ){
                    $(".show-3d-preview").removeAttr('disabled');
                }
            }

            // Enable 'Download CAD' -if not custom items in configuration-
            if( $(".show-cad-download").length > 0){
                $(".show-cad-download")[0].classList.remove("customManifold");
                // Check if custom items in configuration to enable 'Download CAD'
                if( !$(".show-cad-download").hasClass( "customConf" ) ){
                    $(".show-cad-download").removeAttr('disabled');
                }
            }

            $("#customizedManifold").css("display", "none");
            $("#standardManifold").css("display", "block");
            $('#cell_characteristic input').removeAttr('disabled');
            $('#cell_characteristic select').removeAttr('disabled');
        } else {

            // Disable '3D preview' any time we press 'Customized Manifold blue bar'
            if( $(".show-3d-preview").length > 0){
                $(".show-3d-preview")[0].classList.add("customManifold");
                $('.show-3d-preview').attr('disabled', 'disabled');
            }

            // Disable 'Download CAD' any time we press 'Customized Manifold blue bar'
            if( $(".show-cad-download").length > 0){
                $(".show-cad-download")[0].classList.add("customManifold");
                $('.show-cad-download').attr('disabled', 'disabled');
            }

            $("#standardManifold").css("display", "none");
            $("#customizedManifold").css("display", "block");
            $('#cell_characteristic input').attr('disabled', 'disabled');
            $('#cell_characteristic select').attr('disabled', 'disabled');
        }
    }

    self.doCustomizeManifold = function (id, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: customizeManifoldUrl,
            dataType: 'json',
            async: true,
        }, callback));
    }

    self.customizeManifoldHandler = function() {
        $(document).on('click', '#customizeManifold', function() {
            console.log("Customize manifold");
            self.doCustomizeManifold().then(function(res) {
                $("#manifoldSpecialContainer").html(res);
                changeCustomized(res==='');
                stateMachine.controllers["graphical_editor"].refreshGraphicalEditor();
            }, function(err){
                // Error message to show
            });
        });
    }

}

let manifoldCustomizer = new ManifoldCustomizer();
manifoldCustomizer.customizeManifoldHandler();
