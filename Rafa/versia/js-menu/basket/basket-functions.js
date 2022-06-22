var timer = null
var array = [];

$(document).ready(function() {

	
	function getRenderedComponent(renderUrl) {
		$.ajax({
			url : renderUrl,
			type : "GET",
			dataType : "html",
			success : function(data) {
				if (!data.includes("loading.gif"))
					clearInterval(timer);
				var dataHtml = $.parseHTML(data)[1];
				$("#basket-table").replaceWith($(dataHtml).find("#basket-table"));
				refreshAddFavouriteButtons();
				checkDelete();
				array = [];
			}
		});
	}
	
	$("#createResource").click(function() {
		
		$.ajax({
			url : actionUrl,
			type : "GET",
			data: {"product_reference":$(productReference).val(), "action":"POST"},
			success : function(data) {
				var dataHtml = $.parseHTML(data)[1];
				$("#basket-table").replaceWith($(dataHtml).find("#basket-table"));
				checkDelete();
				timer = setInterval(function() {
					getRenderedComponent(renderUrl)
				}, 2000);
				checkDelete();

			}
		});
	});

	$("#deleteResource").click(function() {

		if (array.length > 0) {
			$.ajax({
				url : resourceUrl,
				type : "GET",
				data: {"ids":array.join(","), "action":"DELETE"},
				dataType : "html",
				success : function(data) {
					checkDelete();
					array = [];
					getRenderedComponent(renderUrl)

				}
			});
		} else {
			alert("You must select at least one favourite to delete.");
		}
	});

	$("#import").click(function() {

			$.ajax({
				url : resourceUrl,
				type : "POST",
				data: {"action":"IMPORT"},
				dataType : "html",
				success : function(data) {
					checkDelete();
					array = [];
					timer = setInterval(function(){getRenderedComponent(renderUrl)},2000);
				}
			});
	});


	function checkDelete() {

		$('.select-item').change(function() {
			var id = $(this).attr("id");
			if ($(this).is(":checked")) {
				array.push(id);
			} else {
				const index = array.indexOf(id);

				if (index !== -1) {
					array.splice(index, 1);
				}
			}
		});
		
		$("#check-all").click(function () {
		    $(".select-item").prop('checked', $(this).prop('checked')).change();;
		});
	}
	

	
	checkDelete();
	
	/*if(refreshTechnicalInfo=="true"){
		timer = setInterval(function(){getRenderedComponent(renderUrl)},2000);
	}*/
	
	$( "#productReference" ).keypress(function( event ) {
		  if ( event.which == 13 ) {
			  $("#createResource").click();
		  }
			});

		});