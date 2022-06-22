var numImage = {}; //RACA-0
var images = $('.image-set li');

var NavManager = (function () {

	var _conf = {
		'htmlClass': 'has-menu',
		'mobileFadeIcon': '.main-header__nav-trigger',
		'nav': '.main-navigation',
		'lev0li': '.main-navigation > ul > li',
		'lev0lia': '.main-navigation > ul > li > a',
		'lev1li': '.main-navigation__mega__level2 > li',
		'lev1lichild': '.main-navigation__mega__level2 li:first-child',
        'closeMenuBtn': '.main-navigation__mega .close-menu-btn-js'
	};

	var menuTimeout = null;

	return {

		showNav: function() {
			$('html').addClass(_conf.htmlClass);
			$(_conf.mobileFadeIcon).addClass('fade-icon--on');
		},

		hideNav: function() {
			$('html').removeClass(_conf.htmlClass);
			$(_conf.mobileFadeIcon).removeClass('fade-icon--on');
		},

		initNav: function() {

			var _self = this;
			var mobileWidth = 991;

			$(_conf.mobileFadeIcon).on('click', function(e) {
				e.preventDefault();
				//hideSearch();
				if($(this).is('.fade-icon--on')) {
					_self.hideNav();
				} else {
					_self.showNav();
				}
			});

			$(_conf.lev0li).on('mouseenter', function(e) {
					var images = $('.image-set li');
					$(images).css('display', 'none');
					$(images[0]).css('display', 'block');
					$('body').css({'overflow': 'hidden'});
				if(window.innerWidth>mobileWidth) {
					clearTimeout(menuTimeout);
					$(_conf.lev0li).removeClass('active');
					if($(this).attr('class')!== "main-navigation-secondary"){
						$(this).addClass('active');
						$(_conf.lev1li).removeClass('active');
						$(_conf.lev1li).first().addClass('active');
					}
				}
				/*console.log(_conf.lev1lichild)
			 	$(_conf.lev1lichild).addClass('active');*/
			});

			/* Modificado 18/01/22 navegador fijo
			$(_conf.lev0li).on('mouseleave', function(e) {
				if(window.innerWidth>mobileWidth) {
					menuTimeout = setTimeout(function() {
						$(_conf.lev0li).removeClass('active');
					}, 20000);
				}
			});
			*/
			

			$(_conf.lev1li).on('mouseenter', function(e) {
				if(window.innerWidth>mobileWidth) {
					var currentLi1 = this;
					var currentIndex = $(this).index() - 1;
					var nameMenu = $(this).children("a").text(); //RACA-0
					var url;
					var newProds;
					var count = $('.explore-more-content li').length;
					setTimeout(function() {
						if ($(currentLi1).is(":hover")) {
							$(_conf.lev1li).removeClass('active');
							$(currentLi1).addClass('active');
							$(images).css('display', 'none'); //RACA-0
							$(images[parseInt(numImage[nameMenu])-1]).css('display', 'block'); //RACA-0
							for (var i=0; i<count; i++) {
								url = $('.expmore'+i).attr('data-link');
								if(url.indexOf("&")!="-1"){
									newProds = url + nameMenu;
								}else{
									newProds = url;
								}
								$('.expmore'+i).attr('href', newProds);
							}
						}
					},300);	
						
				}
			});


			

			// mobile events

			$(_conf.lev0lia).on('click', function(e) {
				e.stopPropagation();
				//e.preventDefault();
				if(window.innerWidth<=mobileWidth) {
					if( $(this).parent().is('.active') )
					{
						setTimeout(function() {
							$(_conf.lev1li).removeClass('active');
						}, 400);
					} else {
						$(_conf.lev0li).removeClass('active');
						$(this).parent().addClass('active');
					}
				}
			});

			$(_conf.lev1li).on('click', function(e) {
				e.stopPropagation();
				//e.preventDefault();
				if(window.innerWidth<=mobileWidth) {
					if( $(this).is('.active') )
					{
						setTimeout(function() {
							$(_conf.lev1li).removeClass('active');
						}, 400);
					} else {
						$(_conf.lev1li).removeClass('active');
						$(this).addClass('active');
					}
				}
			});

			// add class to remove arrow when there are no sublevel items
			var noSubItems = $(_conf.lev1li).filter(function(){return $(this).children().length == 1; });
			$.each( noSubItems, function() {
				$(this).find('a').addClass('no-sub-items');
			})

			$(_conf.closeMenuBtn).on('click', function (event) {
				if (event) event.preventDefault(); event.stopPropagation();

				if ($(_conf.lev0li).is('.active')) {
					$(_conf.lev0li).removeClass('active');
				} else {
					$(_conf.lev0li).removeClass('active');
					$(this).addClass('active');
				}
            });
		}

	};

}());

/*
$('.main-navigation__mega__level2 > li').on('mouseenter', function(){
	if (window.matchMedia("(min-width:992px)").matches){
		var $megaLeft = $(this).parent().prev('.main-navigation__mega__left');
		var paddingBottomMegaLeft = $megaLeft.css('padding-bottom');
		var addPadding = paddingBottomMegaLeft.replace('px', '');
		$(this).find('.main-navigation__mega__level3 li').each(function(_key, element){
			var heightCurrent = $(this).outerHeight(true);
			addPadding = parseInt(addPadding)+parseInt(heightCurrent);
		});
		$megaLeft.css('padding-bottom', (addPadding-$megaLeft.outerHeight())+'px');
	}
}).on('mouseleave', function(){
	if(window.matchMedia("(min-width:991px)").matches){
		if( ! $('.main-navigation-list > li:first-child').hasClass('active') ){
			var $megaLeft = $(this).parent().prev('.main-navigation__mega__left');
			$megaLeft.css('padding-bottom', '0px');
		}
	}
});
*/
/* commenting this the scroll does not close the menu
const body = $('body');
const scrollUp = "scroll-up";
const scrollDown = "scroll-down";
let lastScroll = 0;

window.addEventListener("scroll", function() {
	const currentScroll = window.pageYOffset;
	
	if (currentScroll == 0) {
		//body.removeClass(scrollUp);
		return;
	}

	if ( currentScroll > lastScroll && !body.hasClass(scrollDown)) {
		// down
		body.removeClass(scrollUp);
		body.addClass(scrollDown);
	} else if (currentScroll < lastScroll && body.hasClass(scrollDown)) {
		// up
		body.removeClass(scrollDown);
		body.addClass(scrollUp);
	}
	lastScroll = currentScroll;
	$('.main-navigation .active').removeClass('active');
}); */

//Adding this function clicking outside the nav returns the document to the main
$(document).on("click", function() {
   $('.main-navigation .active').removeClass('active');
   $('body').css({'overflow': 'auto'});
}); 


// Products image setting
$( document ).ready(function() {

	
	$('.main-navigation__mega__level3 li a').on('mouseenter', function() {
		var currentLi3 = this;
		var currentIndexProds = $(this).attr('data-index') - 1;

		for(var i=0; i< images.length; i++){
			if(i === currentIndexProds){
					$(images[i]).css('display', 'block');
			} else{
				$(images[i]).css('display', 'none');
			}
		}
	});

	//START RACA-0
	$(".main-navigation__mega__level2.scrollable > li").each(function(index){
		var nameMenu = $(this).children("a").text();
		if ($(this).find("a.links-level3").eq(0).length > 0){
			numImage[nameMenu] = $(this).find("a.links-level3").eq(0).attr('data-index');
		}
	});
	//END RACA-0

	/* $('.main-navigation__mega__level3 li a').on('mouseenter', function() {
		var currentLi3 = this;
		var currentIndexProds = $(this).attr('data-index') - 1;

		for(var i=0; i< images.length; i++){
			if(i === currentIndexProds){
					$(images[i]).css('display', 'block');
			} else{
				$(images[i]).css('display', 'none');
			}
		}
	}); */
});