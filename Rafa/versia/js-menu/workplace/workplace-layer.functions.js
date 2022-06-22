(function(){

    $(document).ready(function(){
        const amountSpan = document.getElementById('workspaceAppsAmount');

        console.log("window.smc.workplace.activeApplications");
        console.log(window.smc.workplace.activeApplications);
        if(amountSpan && window.smc.workplace.activeApplications && window.smc.workplace.activeApplications.length > 0) {
            amountSpan.innerText = window.smc.workplace.activeApplications.length;
            $("#basketCart").remove();
        } else {
            $("#workspaceApps").remove();
        }
    });

    // Show Workplace layer on click
    $('.main-header_workspace-apps').on('click', function(e) {
		e.preventDefault();
		e.stopPropagation();
        $('html').addClass('has-workspace-apps-select');
        $('html').removeClass('has-eshop-apps-select');
		$('html').removeClass('has-cart-select');
        $('html').removeClass('has-language-select');
	});

	$('body').on('click', '.workspace-apps-selector .smc-close-button', function(e) {
		e.preventDefault();
		e.stopPropagation();
		$('html').removeClass('has-workspace-apps-select');
    });

    $('body').on('click', function(e) {
		if ($(e.target).closest('.workspace-apps-selector').length === 0) {
			$('html').removeClass('has-workspace-apps-select');
		}
	});

})();
