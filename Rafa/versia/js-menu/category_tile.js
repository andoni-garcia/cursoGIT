var CatTile = (function () {

    var _conf = {
        tiles: '.category-tile',
        tile_wrapper: '.category-tile-wrapper',
        tile_text: '.category-tile__text',
        tile_image: '.category-tile__image',
        tile_footer: '.category-tile__footer',
        tileIfExpands: 'category-tile--noExpand',
        tileIfExpandsMobile: 'category-tile--noExpandMobile',
        modal: '.category-tile-more',
        modal_rail: '.category-tile-more__body',
        modal_item: '.category-tile-more__body__item',
        modal_slider_trigger: '.category-tile-more--slideTrigger',
        modal_trigger: '.category-tile__footer span',
        modal_item_visible_class: 'category-tile-more__body__item--visible',
        modal_close: '.category-tile-more__header__close',
        modal_back: '.category-tile-more__header__back',
        modal_visible: 'category-tile--showinfo',
        mobile_quickview_close: '.category-tile-mobile-close',
        // mobile_quickview_class: 'category-tile--mobileQuickView',
        mobile_quickview_trigger: '.category-tile__text__accordion-trigger',
        quickview_class: 'category-tile--active',
        quickview_first_screen_class: 'category-tile-more--is-level1',
        tile_title: '.category-tile__title',
        text_inner_container: '.category-tile__text__inner',
        lg_break: 1024,
        mobile_width: 768
    }

    return {

        init: function() {

            var modal,
                a,
                screen_nr;

            CatTile.initRailsWidths();
            CatTile.resetScreens();
            CatTile.initAdditionalInfo();
            CatTile.initQuickViews();
            CatTile.addExpandButtons();
            CatTile.addMobileEmptyCheck();
            CatTile.adaptHeight();

            $(window).on('resize', function() {
              CatTile.addExpandButtons();
            });
            
        },

        addMobileEmptyCheck: function() {
          var bricks = $(_conf.tiles + ' ' + _conf.text_inner_container);

          if(bricks.length > 0) {
              for(var i=0; i<bricks.length;i++) {
                  if( $(bricks[i]).text().trim().length === 0 ) {
                    $(bricks[i])
                      .closest(_conf.tiles)
                      .addClass(_conf.tileIfExpandsMobile)
                  }
              }
          }

        },

        addExpandButtons: function() {
            
            var bricks = $(_conf.tiles + ' ' + _conf.tile_text);
            $(_conf.tiles).addClass(_conf.tileIfExpands);
            if(bricks.length > 0) {
                for(var i=0; i<bricks.length;i++) {
                    // console.log( $(bricks[i]).innerHeight() );
                    if($(bricks[i]).innerHeight() > 200) {
                        $(bricks[i])
                            .closest(_conf.tiles)
                            .removeClass(_conf.tileIfExpands);
                    }
                }
            }
        },

        initQuickViews: function() {

            // // desktop
            // $('body').on('mouseenter', _conf.tile_text, function(e) {
            //     if(window.innerWidth > _conf.lg_break) {
            //         $(_conf.tile_wrapper).removeClass(_conf.quickview_class);
            //         $(this).closest(_conf.tile_wrapper).addClass(_conf.quickview_class);
            //     }
            // });

            // $('body').on('mouseenter', _conf.tile_image, function(e) {
            //     if(window.innerWidth > _conf.lg_break) {
            //         $(_conf.tile_wrapper).removeClass(_conf.quickview_class);
            //         $(this).closest(_conf.tile_wrapper).addClass(_conf.quickview_class);
            //     }
            // });

            // $('body').on('mouseleave', _conf.tile_wrapper, function(e) {
            //     if(window.innerWidth > _conf.lg_break) {
            //         CatTile.closeAllModals();
            //         $(this).removeClass(_conf.quickview_class);
            //     }
            // });

            // $('body').on('mouseenter', _conf.tile_footer, function(e) {
            //     if(window.innerWidth > _conf.lg_break) {
            //         e.stopPropagation();
            //     }
            // });

            // tablet

            $('body').on('click', _conf.mobile_quickview_trigger, function(e) {
                e.preventDefault();
                //CatTile.closeAllQuickViews();
                var self = this;
                $(self).closest(_conf.tile_wrapper).toggleClass(_conf.quickview_class);

                CatTile.closeAllModals();
            });

            // $('body').on('click', _conf.tile_title, function(e) {
            //     e.preventDefault();
            //     e.stopPropagation();
            //     $(this).closest(_conf.tile_text).find(_conf.mobile_quickview_trigger).click();
            // });

            $('body').on('click', function(e) {

                if($(e.target).closest(_conf.tiles).length  === 0) {
                    CatTile.resetScreens();
                    CatTile.closeAllQuickViews();
                    CatTile.closeAllModals();
                }
            });

        },

        initAdditionalInfo: function() {

            // $('body').on('mouseleave', _conf.modal, function(e) {
            //     if(window.innerWidth > _conf.lg_break) {
            //         CatTile.closeAllModals();
            //     }
            // });

            $('body').on('click', _conf.modal_slider_trigger, function(e) {
                e.preventDefault();
                e.stopPropagation();
                modal = $(this).closest(_conf.modal);
                a = modal.find(_conf.modal_slider_trigger);
                screen_nr = a.index(this)+1;

                $(modal).removeClass(_conf.quickview_first_screen_class);
                CatTile.slideToScreen(modal, screen_nr);
            });

            $('body').on('click', _conf.modal_close, function(e) {
                e.preventDefault();
                e.stopPropagation();
                modal = $(this).closest(_conf.modal);
                CatTile.slideToScreen(modal, 0);
                $(_conf.tiles).removeClass(_conf.modal_visible);
            });

            $('body').on('click', _conf.modal_back, function(e) {
                e.preventDefault();
                e.stopPropagation();
                // modal = $(this).closest(_conf.modal);
                // CatTile.slideToScreen(modal, 0);
                // $(_conf.tiles).removeClass(_conf.modal_visible);
                $(modal).addClass(_conf.quickview_first_screen_class);
                CatTile.slideToScreen(modal, 0);
            });

            $('body').on('click', _conf.modal_trigger, function(e) {
                e.stopPropagation();
                CatTile.closeAllModals();
                $(this).closest(_conf.tiles).addClass(_conf.modal_visible);
            });
        },

        adaptHeight: function() {
            var arrayTiles = [];
            var arrayTilesInActiveTab = [];
            $(_conf.tiles).each(function () {
                if($(this).closest(".smc-tabs__body").length == 0){ //On one side, we store tiles that are not inside a tab
                    arrayTiles.push($(this));
                } else if ($(this).closest(".smc-tabs__body--active").length > 0) { //On the other side, we store the tiles that are inside the active tab (ignore the rest)
                    arrayTilesInActiveTab.push($(this));
                }
            });

            CatTile.adaptHeightForTiles (arrayTiles);
            CatTile.adaptHeightForTiles (arrayTilesInActiveTab);
        },

        adaptHeightForTiles: function (tiles) {
            var highestTile = 0;
            $.each( tiles, function(){
                var currentTileHeight = $(this).find(_conf.tile_text).innerHeight() + $(this).find(_conf.tile_image).innerHeight();
                if($(this).find(_conf.tile_footer).length > 0){ //Adding the height of the footer only for digital catalog tiles
                    currentTileHeight += $(this).find(_conf.tile_footer).innerHeight();
                }
                if(currentTileHeight > highestTile){
                    highestTile = currentTileHeight;
                }
            });

            if (highestTile > 240 && highestTile < 460 && window.innerWidth >= _conf.mobile_width ) {
                $.each(tiles, function () {
                    $(this).css("min-height","auto");
                    if ($(this).closest(".lister-row__item").attr("id") !== undefined){
                        $(this).closest(".lister-row__item").css("min-height","auto");
                    }
                    $(this).height(highestTile);
                });
            }
        },

        resetScreens: function() {
            var i, n, modals;
            modals = $(_conf.modal);
            n = modals.length;
            for(i = 0; i < n; i++) {
                CatTile.slideToScreen(modals[i], 0);
            }
        },

        initRailsWidths: function() {
            var i, n, rails;
            rails = $(_conf.modal_rail);
            n = rails.length;

            for(i = 0; i < n; i++) {
                CatTile.setRailWidth(rails[i]);
            }
        },

        setRailWidth: function(rail) {
            var children = $(rail).children();
            var n = children.length;
            $(rail).css('width', n*100+'%');
        },

        slideToScreen: function(modal, screen_nr) {
            $(modal).find(_conf.modal_item)
                .css('transform', 'translateX(-'+screen_nr*100+'%)')
                .removeClass(_conf.modal_item_visible_class);
            $($(modal).find(_conf.modal_item).get(screen_nr)).addClass(_conf.modal_item_visible_class);
        },

        closeAllModals: function() {
            $(_conf.tiles).removeClass(_conf.modal_visible);
            $(_conf.modal).addClass(_conf.quickview_first_screen_class);
        },
        closeAllQuickViews: function() {
            $(_conf.tile_wrapper).removeClass(_conf.quickview_class);
        }

    };

}());