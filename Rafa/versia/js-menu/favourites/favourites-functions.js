var timer = null
var idArray = [];

function deleteFavourites() {

	if (idArray.length > 0) {
		$.ajax({
			url : resourceUrl,
			type : "GET",
			data : {
				"ids" : idArray.join(","),
				"action" : "DELETE"
			},
			dataType : "html",
			success : function(data) {
				var deletedIds = $.parseJSON(data);
				for( var i in deletedIds){
					$('#container-'+deletedIds[i]).remove();
				}
				if ($("#check-all").is(":checked")){
					$("#check-all").prop("checked",false);
				}	
					
			}
		});
	} else {
		alert("You must select at least one favourite to delete.");
	}
}

$(document).ready(
		
		function() {

			function getRenderedComponent(renderUrl) {
				$.ajax({
					url : renderUrl,
					type : "GET",
					dataType : "html",
					success : function(data) {
						if (!data.includes("loading.gif"))
							clearInterval(timer); 
						var dataHtml = $.parseHTML(data)[1];
						$("#favourites-table").replaceWith($(dataHtml).find("#favourites-table"));
						checkDelete();
						idArray = [];

					}
				});
			}

			$("#createResource").click(function() { 
				$.ajax({
					url : resourceUrl,
					type : "GET",
					data : {
						"product_reference" : $("#productReference").val(),
						"folder_id": $("#folderId").val(),
						"action" : "ADD"
					},
					dataType:"json"					,
					success : function(data) {
						var favourite = data[0];
						var tableLastRow = $("#favourites-table > tbody:last-child");
						
						if(favourite.partnumber.status=="UPDATED"){
							var images = favourite.partnumber.node.images;
							var image = $.grep(images, function(n,i){return n["type"]=="SMALL";})[0];
							
							tableLastRow.append("<tr><td>"+favourite.partnumber.code+"</td><td>"+favourite.folder.name+"</td>" +
									"<td>"+favourite.partnumber.details+"</td><td>"+favourite.partnumber.description+"</td><td><img src='"+image.url+"'/></td>" +
									"<td><input type='checkbox' class='select-item checkbox' id='"+favourite.favouriteId+"'/></td></tr>");
						}else if(favourite.partnumber.status=="UPDATING"){
							var loadingGif = "/site/webfiles/1528969721852/images/loading.gif";
							tableLastRow.append("<tr><td>"+favourite.partnumber.code+"</td><td>"+favourite.folder.name+"</td>"+
				    	"<td><img src='"+loadingGif+"' alt='loading'/></td><td><img src='"+loadingGif+"' alt='loading' /></td>"+
				    	"<td><img src='"+loadingGif+"' alt='loading' /></td><td><input type='checkbox' class='select-item checkbox' id='"+favourite.favouriteId+"'/></td></tr>");
						}
						
						if(favourite.partnumber.status=="UPDATING"/*||favourite.partnumber.status=="ERROR"*/){
							timer = setInterval(function() {
								getRenderedComponent(renderUrl)
							}, 2000);
						}
						checkDelete();

					}
				});
			});

			

			function checkDelete() {

				$('.select-favourite').change(function() {
					var id = $(this).attr("id");
					if ($(this).is(":checked")) {
						idArray.push(id);
					} else {
						const index = idArray.indexOf(id);

						if (index !== -1) {
							idArray.splice(index, 1);
						}
					}
				});

				$("#check-all").click(
						function() {
							$(".select-favourite").prop('checked',
									$(this).prop('checked')).change();
						});
			}

			checkDelete();

			if (refreshTechnicalInfo == "true") {
				timer = setInterval(function() {
					getRenderedComponent(renderUrl)
				}, 2000);
			}
			
			$( "#productReference" ).keypress(function( event ) {
				  if ( event.which == 13 ) {
					  $("#createResource").click();
				  }
			});

		});