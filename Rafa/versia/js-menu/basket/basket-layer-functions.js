$(document).ready(

function() {

	$(".add-basket-product").click(function() {
		var partnumber = $(this).attr("data-partnumber");
		var dataId = $(this).attr("data-id");
		var quantity = $("input[data-id='" + dataId + "']").val()

		addProductToBasket(partnumber, quantity)
	});
	$(".add-to-favourites").click(function() {
		var partnumber = $(this).attr("data-partnumber");
		addProductToFavourite(partnumber)
	});

	function getPartnumberAndQuantityToAdd() {
		console.log("aaaaa")
		var partnumber = $("#add-to-cart-partnumber").val()
		var quantity = $("#add-to-cart-quantity").val()

		addProductToBasket(partnumber, quantity)
	}
	$("#add-to-cart-button").click(function() {
		getPartnumberAndQuantityToAdd();
	});

	if (typeof basketAmount !== 'undefined') {
		$(".main-header__cart__amount").text(basketAmount);
	}

	$("#add-to-cart-partnumber").on('keyup', function(e) {
		if (e.keyCode == 13) {
			getPartnumberAndQuantityToAdd();
		}
	});

});

function deleteProductFromBasket(basketProductId) {
	$
			.ajax({
				url : deleteBasketProductUrl + "&basketProductId="
						+ basketProductId,
				type : "DELETE",
				beforeSend : function(xhr) {
					xhr.setRequestHeader('X-CSRF-Token', csrfToken)
				},
				success : function(data) {
					$('#item-' + basketProductId).remove();
					var currentAmount = parseInt($(".main-header__cart__amount")
							.text());
					currentAmount--;
					$(".main-header__cart__amount").text(currentAmount);
				}

			});
}

function addProductToBasket(partnumber, quantity) {
	var array = [];
		array.push({partnumbercode: partnumber, quantity: quantity});
		var urlWithParams = addBasketProductUrl + '&jsondata=' + encodeURIComponent(JSON.stringify(array));
	$
			.ajax({
				url : urlWithParams,
				type : "POST",
				beforeSend : function(xhr) {
					xhr.setRequestHeader('X-CSRF-Token', csrfToken)
				},
				data : {
					"partnumber" : partnumber,
					"quantity" : quantity
				},
				dataType : "html",
				success : function(data) {
					/*var currentAmount = parseInt($(".main-header__cart__amount")
							.text());
					currentAmount++;
					$(".main-header__cart__amount").text(currentAmount);
					$("#basket-product-list").append(data);
					$("#add-to-cart-partnumber").val("");
					$("#add-to-cart-quantity").val(1);*/
					location.reload();

				}
			});
}

function refreshAddFavouriteButtons() {
	$(".add-to-favourites").click(function() {
		var partnumber = $(this).attr("data-partnumber");
		addProductToFavourite(partnumber)
	});
}


function addProductToFavourite(partnumber) {
	$.ajax({
		url : addFavourite,
		type : "POST",
		beforeSend : function(xhr) {
			xhr.setRequestHeader('X-CSRF-Token', csrfToken)
		},
		data : {
			"partnumber" : partnumber
		},
		dataType : "html",
		success : function(data) {
			alert("Favourite added succesfully");
		}
	});
}