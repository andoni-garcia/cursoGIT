var array = [];

$(document).ready(function(){

    function getRenderedComponent(renderUrl){
        $.ajax({
			url : renderUrl,
			type : "GET",
			dataType : "html",
			success : function(data) {
				if (!data.includes("loading.gif"))
					clearInterval(timer);
				var dataHtml = $.parseHTML(data)[1];
				$("#ssi-table").replaceWith($(dataHtml).find("#ssi-table"));
				array = [];
			}
		});
    }
});