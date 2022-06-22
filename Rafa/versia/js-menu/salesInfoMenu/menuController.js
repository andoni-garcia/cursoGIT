
$(document).ready(function(){

    var $container = $("#product-sales-information__sticky-links");
    var $fatherList = $(".psi-sticky__mainList").children();
    var $childrenList = $(".psi-sticky__childrenList");

    $fatherList.each(function(){
    	var father = $(this);
    	father.hover(function(){
    		var index = father.data("index");

    		$childrenList.each(function(childIndex){
    			var children = $(this);

    			if(index == childIndex){
    				children.show();
    			}else{
    				children.hide();
    			}
    		})
    	})
    });

    $container.mouseleave(function(){
        $childrenList.hide();
    });
});