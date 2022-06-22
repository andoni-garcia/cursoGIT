var PlpModule = (function () {

    var _conf = {
        showSeriesButton: '.js__plp-show-series',
        closeSeriesButton: '.plp-series__close',
        seriesActiveClass: 'has-plp-series'
    }

    return {

        init: function() {
            PlpModule.manageSeries();
            PlpModule.manageSliders();
        },

        manageSeries: function() {


            $(_conf.showSeriesButton).on('click', function(e) {
                $('html').toggleClass(_conf.seriesActiveClass);
                // if(window.innerWidth > 991) {
                //     $('html')
                //         .removeClass(_conf.seriesActiveClass)
                //         .addClass(_conf.seriesActiveClass);
                // } else {
                //     $('html').toggleClass(_conf.seriesActiveClass);
                // }
            });

            $(_conf.closeSeriesButton).on('click', function(e) {
                $('html')
                    .removeClass(_conf.seriesActiveClass);
            });
        },

        manageSliders: function() {

            var i,
                slider,
                n;

            slider = document.getElementsByClassName('filters-slider');
            n = slider.length;

            for(i=0; i<n; i++) {
                noUiSlider.create(slider[i], {
                    start: [16, 60],
                    connect: true,
                    range: {
                        'min': 16,
                        'max': 80
                    }
                });
            }
        }

    };

}());