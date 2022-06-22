$(function() {

    objectFitImages();

    $('.banner-carousel').slick({
        fade: true,
        cssEase: 'linear',
        infinite: true,
        autoplay: true,
        autoplaySpeed: 6000,
        arrows: true,
        dots: true,
        customPaging : function(slider, i) {
            return '<span></span>';
        },
        nextArrow: '<span class="slick-arrow-right"><i class="slick-arrow__icon icon-thin-arrow-left"></i></span>',
        prevArrow: '<span class="slick-arrow-left"><i class="slick-arrow__icon icon-thin-arrow-left"></i></span>'
    });

    $('body').on('click', '.simple-collapse__head', function (e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).closest('.simple-collapse').toggleClass('active');
    });

    NavManager.initNav();

    // init category tiles
    CatTile.init();

    // flyout Start
    var _st;

    $('.js__smc-flyout-trigger').on('click', function (e) {
        _st = $('html body').scrollTop();
        $('html').removeClass('has-flyout').addClass('has-flyout');
        $($(this).data('flyout')).addClass('smc-flyout--active');
    });

    $('.js__smc-flyout-close').on('click', function (e) {
        $('html').removeClass('has-flyout');
        $('html body').scrollTop(_st);
        $(this).closest('.smc-flyout').removeClass('smc-flyout--active');
    });


    PlpModule.init();
    FormValidator.init();

    // search tabs

    var previousSelectedTab = -1;
    $('.smc-tabs__head').on('click', 'a', function(e) {
        e.preventDefault();

        var id = $(this).closest('li').index();

        var containsClass = $(this).hasClass('disabled');
        if(containsClass) {
            return;
        }

        var heads = $(this).closest('.smc-tabs__head').find('li');
        $(heads).removeClass('smc-tabs__head--active');
        $(heads[id]).addClass('smc-tabs__head--active');

        var bodies = $(this).closest('.smc-tabs').find('.smc-tabs__body');
        $(bodies).removeClass('smc-tabs__body--active');
        $(bodies[id]).addClass('smc-tabs__body--active');

        //Additional actions when browsing between tabs
        resizeVids();
        CatTile.addExpandButtons();
        CatTile.adaptHeight();

        //If selected item is summary id = 1
        if(id == 1) {
            $(heads[id]).trigger('vc-disable-pannel');
        }
        if(previousSelectedTab == 1) {
            $(heads[id]).trigger('vc-enable-pannel');
        }

        previousSelectedTab = id;

    });



    // language

    $('.main-header__meta__language').on('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $('html').addClass('has-language-select');
    });

    $('body').on('click', '.language-selector .smc-close-button', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $('html').removeClass('has-language-select');
    });

    $('body').on('click', function(e) {
        if( $(e.target).closest('.language-selector').length === 0 ) {
            $('html').removeClass('has-language-select');
        }
    });

    $('.back-to-top__button').on('click', function(e) {
        e.preventDefault();
        e.stopPropagation();

        if($('html').is('.has-backToTop')) {
            $("html, body").animate({
                scrollTop: 0
            }, 1000);
        }

    });



    //-------------------------------------


    var _scroll = {};

    var getScroll = function() {
        return {
            oldScroll: $(window).scrollTop(),
            nweScroll: null
        }

    };

    _scroll = getScroll();

    var backToTopTimeout = null;

    var setBackToTopTimeout = function() {
        backToTopTimeout = setTimeout(function() {
            $('html').removeClass('has-backToTop');
            // $('html').addClass('has-header');
        }, 3000);
    };

    $('.back-to-top').on('mouseenter', function(e) {
        clearTimeout(backToTopTimeout);
    });

    $('.back-to-top').on('mouseleave', function(e) {
        setBackToTopTimeout();
    });
    var confSearchMenu = {
        input: '.search-query',
        inPageButton: '.search-inpage__submit',
        showSuggestsClass: 'has-suggest',
        inpageActiveClass: 'active',
        hasSearchClass: 'has-search',
        headerFadeIcon: '.main-header__search .fade-icon',
        headerSearchInput: '.main-header__searchtext input[type="text"]',
        isMenu:true,
        headerWrapper:'.main-header__search',
        headerSearchText: '.main-header__searchtext',
        searchQuery: '.search-query'
    };
    $(window).on('scroll', function() {
        clearTimeout(backToTopTimeout);
        _scroll.newScroll = $(window).scrollTop();



        if (_scroll.newScroll > _scroll.oldScroll ) {
            $('html').addClass('has-backToTop');
            //$('html').removeClass('has-header');

            SearchModule.unRevealSearch(confSearchMenu);
        } else {
            $('html').removeClass('has-backToTop');

            // if( $('.main-navigation > ul > li.active').length === 0 ) {
            //     $('html').addClass('has-header');
            // }
        }


        // if( _scroll.newScroll < 120 ) {
        //     $('html').addClass('has-header');
        // }

        _scroll.oldScroll = _scroll.newScroll;
        setBackToTopTimeout();
    });

    //-------------------------------------


    var vids = $('.video-component iframe');

    vids.each(function() {
        $(this)
        .attr('data-aspectRatio', this.height / this.width)
        .removeAttr('height')
        .removeAttr('width');
    });

    var resizeVids = function() {
      //var newWidth = $fluidEl.width();

      // Resize all videos according to their own aspect ratio
      vids.each(function() {
        var w = $(this).closest('.video-component').width();
        var r = $(this).attr('data-aspectRatio');
        $(this)
          .attr('width', w)
          .attr('height', w*r);
      });
    };

    // When the window is resized
    $(window).on('resize', function() {
      resizeVids();
    }).resize();

    // var waypoints = $('.js--LazyImageContainer').waypoint({
    //     handler: function(direction) {
    //         console.log(this.element.id + ' hit');
    //     }
    // });

    var initLazyImages = function() {
        var screenHeight = window.outerHeight;
        //console.log(screenHeight);
        var lazies = $('.js--LazyImageContainer');
        var i, n;
        n = lazies.length;
        for(i=0; i<n; i++) {
            if ( $(lazies[i]).offset().top > screenHeight ) {
                //console.log( $(lazies[i]).offset().top );
                $(lazies[i]).removeClass('image-shown');
            }
        }
    };

    initLazyImages();

    var waypoints = $('.js--LazyImageContainer').waypoint({
        handler: function() {
            $(this.element).addClass('image-shown');
        },
        offset: '90%'
    });

    ProductCatalogue.init();

    $('body').on('mouseover', '.content-lister__resultsTable--modalTrigger', function() {
        $(this).addClass('content-lister__resultsTable--modalTrigger--active');
      });

      $('body').on('mouseleave', '.content-lister__resultsTable--modalTrigger', function() {
        $(this).removeClass('content-lister__resultsTable--modalTrigger--active');
      });

 // eshop LKS
	$('.main-header_eshop-apps').on('click', function(e) {
		e.preventDefault();
		e.stopPropagation();
        $('html').addClass('has-eshop-apps-select');
        $('html').removeClass('has-workspace-apps-select');
		$('html').removeClass('has-cart-select');
		$('html').removeClass('has-language-select');
	});

	$('body').on('click', '.eshop-apps-selector .smc-close-button', function(e) {
		e.preventDefault();
		e.stopPropagation();
		$('html').removeClass('has-eshop-apps-select');
	});

	$('body').on('click', function(e) {
		if ($(e.target).closest('.eshop-apps-selector').length === 0) {
			$('html').removeClass('has-eshop-apps-select');
		}
	});


     // workspace LKS
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


	// -------------------------------------

	// basket/cart LKS
	$('.main-header__cart').on('click', function(e) {
		e.preventDefault();
		e.stopPropagation();
		$('html').removeClass('has-language-select');
        $('html').removeClass('has-eshop-apps-select');
        $('html').removeClass('has-workspace-apps-select');
        $('html').addClass('has-cart-select');
        if ($(window).width() < 992){
            window.location = basketLink;
        }
	});

	$('body').on('click', '.cart-selector .smc-close-button', function(e) {
		e.preventDefault();
		e.stopPropagation();
		$('html').removeClass('has-cart-select');
	});

	$('body').on('click', function(e) {
		if ($(e.target).closest('.cart-selector').length === 0) {
			$('html').removeClass('has-cart-select');
		}
	});
	// -------------------------------------


    $('.openModalBtn').on('click', function(e) {
        e.preventDefault();
        var url = $(this).attr('href');

        var current = window.location.href;
        if (current.indexOf("https:") >= 0 ){
            if (url.toString().indexOf("http:") >= 0){
                url = url.replace("http:","https:");
                $(this).attr("href",url);
            }
        }
        $("#askSistemaLoadingContainer").removeClass("hidden");
        $.get(url)
            .then(function (response) {
                var $html = $(response);
                //Remove old modal before creating a new one
                $('.ask-sistema-modal').remove();
                $html.modal('show');
                $('.ask-sistema-modal').modal("show");
                $("#askSistemaLoadingContainer").addClass("hidden");

                //Solutions Ask our experts form
                var experts_form = $('form[name="ask_experts"]');
                if ( experts_form.length ) {
                    $( "#_askSistemaModalTitle" ).text($('.openModalBtn').text());
                    var url = $(location).attr('href'),
                        parts = url.split("/"),
                        last_part = parts[parts.length-1];
                    $('<input>').attr('type','hidden').val(last_part).addClass('solution_name').attr('name','solution_name').appendTo(experts_form);
                }
            })
            .catch(function () {
                // _self.endLoading(_self.links.showAskSmc);
            });
    });

});
