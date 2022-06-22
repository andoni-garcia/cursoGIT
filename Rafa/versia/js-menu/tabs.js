
function switchTab(e) {

    var $allTabLinks = $(".tab-link");
    $allTabLinks.removeClass("active")

    var $tabLink = $(this);
    var tabId = $tabLink.data('tab');
    $tabLink.addClass("active")

    $(".tab-content").removeClass("active");
    $("#" + tabId).addClass("active");

}

$(function() {
    $("#tab-links .tab-link").on("click", switchTab);
});