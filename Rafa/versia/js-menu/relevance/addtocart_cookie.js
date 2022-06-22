function addToCartCookie(type){

    if($.cookie("cookieconsent_status") != "dismiss"){
        return;
    }

    var productsAdded = $.cookie("productsAddedCookie-" + type);
    if(productsAdded == null){
        productsAdded = 0;
    }

    productsAdded = parseInt(productsAdded) + 1;

    $.cookie("productsAddedCookie-" + type, !isNaN(productsAdded) ? productsAdded : 0, { path: '' });

}
