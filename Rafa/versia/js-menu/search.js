var SearchModule = (function () {

    var showSearch = function(conf,key) {
        key = key ? key : '';
        $('html').addClass(conf.hasSearchClass);
        $(conf.headerFadeIcon).addClass('fade-icon--on');
        $(conf.headerSearchInput).val(key);
        $(conf.headerSearchInput).focus();

        setTimeout(function() {
            $(conf.headerSearchInput).click();
        },500);
    };

    var hideSearch = function(conf) {
        $('html').removeClass(conf.hasSearchClass);
        $(conf.headerFadeIcon).removeClass('fade-icon--on');
        $(conf.headerSearchText).removeClass(conf.showSuggestsClass);
    };

    return {

        revealSearch: function(conf,key) {
            showSearch(conf,key);
        },

        unRevealSearch: function(conf) {
            hideSearch(conf);
        },

        init: function(conf) {

            $(conf.headerSearchInput).on('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                $(conf.headerSearchInput).focus();
            });


            $('.main-header__search').on('click', function(e) {
                e.preventDefault();
                if(conf.isMenu){
                    NavManager.hideNav();
                }

                if($('html').hasClass(conf.hasSearchClass)) {
                    hideSearch(conf);
                } else {
                    showSearch(conf,false);
                }
            });

            $(conf.input).on('keyup', function() {
                if($(this).val().length === 0) {
                    $(this).parent().removeClass(conf.showSuggestsClass);
                    $(this).parent().removeClass(conf.inpageActiveClass);
                } else {
                    $(this).parent().addClass(conf.showSuggestsClass);
                    $(this).parent().addClass(conf.inpageActiveClass);
                }
            });

            $(conf.inPageButton).on('click', function(e) {
                    if( $(this).parent().hasClass(conf.inpageActiveClass) ) {
                        e.preventDefault();
                        $(conf.searchQuery).val('');
                        $(this).parent().removeClass(conf.showSuggestsClass);
                        $(this).parent().removeClass(conf.inpageActiveClass);
                    }
            });

            $('body').on('click', function(e) {
                if($(e.target).closest(conf.headerWrapper).length  === 0 && $(e.target).closest(conf.headerSearchText).length === 0) {
                    if( $('html').hasClass(conf.hasSearchClass) ) {
                        hideSearch(conf);
                    }
                }
            });

        }

    };
}());