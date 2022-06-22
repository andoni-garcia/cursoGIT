<@hst.setBundle basename="FixedArea, essentials.global"/>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/fixed-area/fixed-area.css" />"
          type="text/css"/>
</@hst.headContribution>
<div id="wrapper">
    <div class="open-close-block">
        <section class="smc-flyout-active smc-filters">
            <div id="smc-flyout-scrollable-fixed-area" class="smc-flyout-scrollable">
                <div class="filters-wrapper">
                    <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter">
                        <div class="simple-collapse__head show-new-label">
                            <#--                            Technical Station & Inspiration-->
                            <h2 class="heading-04"><@fmt.message key="fixedarea.technicalstationinspiration"/>
                                <span class="icon">
                                    <img src="<@hst.link path="/binaries/content/gallery/smc_global/fixed-area/new-logo.svg"/>"
                                         alt="New icon" height="43px">
                                </span>
                            </h2>
                        </div>
                        <div class="simple-collapse__body">
                            <div class="simple-collapse__bodyInner">
                                <ul class="list-navigation">
                                    <#list node.getRelatedInformation() as relatedInformationNode>
                                        <li class="has-dropdown">
                                            <#if relatedInformationNode.getUrl()??>
                                                <a class="level-option"
                                                   href="${relatedInformationNode.getUrl()!"#"}"><@fmt.message key="${relatedInformationNode.getKey()}"/></a>
                                            <#else>
                                                <div class="level-option"><@fmt.message key="${relatedInformationNode.getKey()}"/></div>
                                            </#if>
                                            <#assign type = "STANDARD">
                                            <#list relatedInformationNode.getRelatedInformation() as relatedInformationNodeB>
                                                <#if relatedInformationNodeB.getType() == "VIDEO">
                                                    <#assign type = "VIDEO">
                                                </#if>
                                            </#list>

                                            <#if type != "VIDEO">
                                                <ul>
                                                    <#list relatedInformationNode.getRelatedInformation() as relatedInformationNodeB>
                                                        <#if relatedInformationNodeB.getRelatedInformation()?? && relatedInformationNodeB.getRelatedInformation()?size gt 0>
                                                            <li class="has-dropdown">
                                                                <a><@fmt.message key="${relatedInformationNodeB.getKey()}"/></a>
                                                                <ul>
                                                                    <#list relatedInformationNodeB.getRelatedInformation() as relatedInformationNodeC>
                                                                        <li class="${(relatedInformationNodeC.getType() == "DOWNLOAD")?then("download-list","")}">
                                                                            <#if relatedInformationNodeC.getKey()??>
                                                                                <a href="${relatedInformationNodeC.getUrl()!""}"
                                                                                   target="_blank"><@fmt.message key="${relatedInformationNodeC.getKey()}"/></a>
                                                                            <#else>
                                                                                <a href="${relatedInformationNodeC.getUrl()!"#"}"
                                                                                   target="_blank">${relatedInformationNodeC.getName()}</a>
                                                                            </#if>
                                                                        </li>
                                                                    </#list>
                                                                </ul>
                                                            </li>
                                                        <#elseif relatedInformationNodeB.getKey()??>
                                                            <li class="${(relatedInformationNodeB.getType() == "DOWNLOAD")?then("download-list","")}">
                                                                <a href="${relatedInformationNodeB.getUrl()!"#"}"
                                                                   target="_blank"><@fmt.message key="${relatedInformationNodeB.getKey()}"/></a>
                                                            </li>
                                                        <#else>
                                                            <li class="${(relatedInformationNodeB.getType() == "DOWNLOAD")?then("download-list","")}">
                                                                <a href="${relatedInformationNodeB.getUrl()!"#"}"
                                                                   target="_blank">${relatedInformationNodeB.getName()}</a>
                                                            </li>
                                                        </#if>
                                                    </#list>
                                                    <#if relatedInformationNode.getKey()?? && relatedInformationNode.getKey() == "fixedarea.someinspiration">
                                                        <li class="icon"><img
                                                                    src="<@hst.link path="/binaries/content/gallery/smc_global/fixed-area/icon-01.svg"/>"
                                                                    alt="Area icon"></li>
                                                    <#elseif relatedInformationNode.getKey()?? && relatedInformationNode.getKey() == "fixedarea.libraries">
                                                        <li class="icon"><img
                                                                    src="<@hst.link path="/binaries/content/gallery/smc_global/fixed-area/icon-02.svg"/>"
                                                                    alt="Area icon"></li>
                                                    <#elseif relatedInformationNode.getKey()?? && relatedInformationNode.getKey() == "fixedarea.engineering">
                                                        <li class="icon"><img
                                                                    src="<@hst.link path="/binaries/content/gallery/smc_global/fixed-area/icon-03.svg"/>"
                                                                    alt="Area icon"></li>
                                                    <#elseif relatedInformationNode.getKey()?? && relatedInformationNode.getKey() == "fixedarea.aboutproducts">
                                                        <li class="icon"><img
                                                                    src="<@hst.link path="/binaries/content/gallery/smc_global/fixed-area/icon-04.svg"/>"
                                                                    alt="Area icon"></li>
                                                    </#if>
                                                </ul>
                                            <#else>
                                                <div class="carousel-block">
                                                    <div id="video-carousel" class="carousel slide"
                                                         data-bs-ride="carousel">
                                                        <div class="carousel-inner">
                                                            <#assign videoDescriptionList = [] />
                                                            <#list relatedInformationNode.getRelatedInformation() as relatedInformationNodeB>
                                                                <div class="carousel-item">
                                                                    <iframe class="lg" width="355" height="200"
                                                                            src="${relatedInformationNodeB.getUrl()?replace("watch?v=", "embed/")}?enablejsapi=1"
                                                                            title="${relatedInformationNodeB.getName()}"
                                                                            frameborder="0"
                                                                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                                            allowfullscreen></iframe>
                                                                    <iframe class="sm" width="266" height="150"
                                                                            src="${relatedInformationNodeB.getUrl()?replace("watch?v=", "embed/")}?enablejsapi=1"
                                                                            title="${relatedInformationNodeB.getName()}"
                                                                            frameborder="0"
                                                                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                                            allowfullscreen></iframe>
                                                                </div>
                                                                <#assign videoDescriptionList += ['${(relatedInformationNodeB.getName())!""}']/>
                                                            </#list>
                                                        </div>
                                                    </div>
                                                    <div class="text-holder">
                                                        <div id="video-description-carousel"
                                                             data-bs-ride="video-description-carousel">
                                                            <#--                                                             <#list relatedInformationNode.getRelatedInformation() as relatedInformationNodeB>-->
                                                            <#--                                                                 <p style="display: none" id="video-description-${relatedInformationNodeB?index}">desc${relatedInformationNodeB?index}-->
                                                            <#--                                                                <#if relatedInformationNodeB.getDescription()??>-->
                                                            <#--                                                                     ${relatedInformationNodeB.getDescription()}-->
                                                            <#--                                                                </#if>-->
                                                            <#--                                                                 </p>-->
                                                            <#--                                                            </#list>-->
                                                            <#list videoDescriptionList as videoDescription>
                                                                <p style="display: none"
                                                                   id="video-description-${videoDescription?index}">${videoDescription}</p>
                                                            </#list>

                                                        </div>
                                                        <#--                                                        View more-->
                                                        <p class="view-more-option"><a href="#"
                                                                                       onclick="showVideoModal();"><@fmt.message key="fixedarea.viewmore"/></a>
                                                        </p>
                                                    </div>
                                                </div>
                                            </#if>

                                        </li>
                                    </#list>

                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <#--MODALVIDEOS-->
    <#assign thumbnailUrl = "https://img.youtube.com/vi/--video-key--/mqdefault.jpg">

    <#list node.getRelatedInformation() as relatedInformationNode>
        <#assign type = "STANDARD">
        <#list relatedInformationNode.getRelatedInformation() as relatedInformationNodeB>
            <#if relatedInformationNodeB.getType() == "VIDEO">
                <#assign type = "VIDEO">
            </#if>
        </#list>

        <#if type == "VIDEO">
            <div class="modal fade video-modal" id="modal" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <#--                            See it in motion-->
                            <h5 class="modal-title"
                                id="exampleModalLabel"><@fmt.message key="fixedarea.seeitinmotion"/></h5>
                            <#--                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="video-carousel">
                                <div class="carousel-holder">
                                    <div class="slick-track" id="carousel-holder" data-bs-ride="carousel-holder"
                                         style="visibility: hidden">
                                        <#list relatedInformationNode.getRelatedInformation() as relatedInformationNodeB>
                                            <div class="slide">
                                                <p align="center">
                                                    <iframe class="lg" width="640" height="480"
                                                            src="${relatedInformationNodeB.getUrl()?replace("watch?v=", "embed/")}?enablejsapi=1"
                                                            title="${relatedInformationNodeB.getName()}" frameborder="0"
                                                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                            allowfullscreen></iframe>
                                                    <iframe class="sm" width="427" height="320"
                                                            src="${relatedInformationNodeB.getUrl()?replace("watch?v=", "embed/")}?enablejsapi=1"
                                                            title="${relatedInformationNodeB.getName()}" frameborder="0"
                                                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                            allowfullscreen></iframe>
                                                </p>
                                                <p align="center">
                                                    <#if relatedInformationNodeB.getName()??>
                                                        ${relatedInformationNodeB.getName()}
                                                    </#if>
                                                </p>
                                            </div>
                                        </#list>

                                    </div>
                                </div>
                                <div class="slider-navigation">
                                    <div class="slick-track" id="slider-navigation" data-bs-ride="slider-navigation">
                                        <#list relatedInformationNode.getRelatedInformation() as relatedInformationNodeB>

                                            <div class="holder">
                                                <#if relatedInformationNodeB.getThumbnail()??>
                                                    <img src="${relatedInformationNodeB.getThumbnail()}"
                                                         alt="${relatedInformationNodeB.getName()}"/>
                                                <#else>
                                                    <img src="${thumbnailUrl?replace("--video-key--", relatedInformationNodeB.getUrl()?replace("https://www.youtube.com/watch?v=", "") )}"
                                                         alt="${relatedInformationNodeB.getName()}"/>
                                                </#if>
                                                <p>
                                                    <#if relatedInformationNodeB.getName()??>
                                                        ${relatedInformationNodeB.getName()}
                                                    </#if>
                                                </p>
                                            </div>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </#if>

    </#list>

    <script>
        $(function () {
            // const divs = document.querySelectorAll('.has-dropdown');
            // divs.forEach(function (el) {
            // el.addEventListener('click', function (event) {
            //     if (window.location.href.includes(event.target.href)) {
            //         event.preventDefault();
            //     }
            //     divs.forEach(function (el) {
            //         $(el).removeClass('active');
            //     });
            //     $(event.target.closest('li')).addClass('active');
            // })
            // });

            let $carouselInner = $('.carousel-inner');
            let $sliderNavigationSlickSlide = $('#slider-navigation .slick-slide');
            let $carouselHolder = $('#carousel-holder');


            $carouselInner.slick({
                fade: true,
                cssEase: 'linear',
                infinite: true,
                autoplay: false,
                // asNavFor: '#video-description-carousel',
                arrows: true,
                dots: true,
                // customPaging : function(slider, i) {
                //     return '<span></span>';
                // },
                nextArrow: '<button class="carousel-control-next" type="button"\n' +
                    '                                                                    data-bs-target="#carousel-holder" data-bs-slide="next">\n' +
                    '                                                                <span class="carousel-control-next-icon"\n' +
                    '                                                                      aria-hidden="true"></span>\n' +
                    '                                                                <span class="visually-hidden">Next</span>\n' +
                    '                                                            </button>',
                prevArrow: '<button class="carousel-control-prev" type="button"\n' +
                    '                                                                    data-bs-target="#video-carousel" data-bs-slide="prev">\n' +
                    '                                                                <span class="carousel-control-prev-icon"\n' +
                    '                                                                      aria-hidden="true"></span>\n' +
                    '                                                                <span class="visually-hidden">Previous</span>\n' +
                    '                                                            </button>'
            });

            // $('#video-description-carousel').slick({
            //     autoplay: false,
            //     initialSlide: 1,
            //     slidesToShow: 1,
            //     slidesToScroll: 1,
            //     asNavFor: '#carousel-inner',
            //     arrows: true,
            //     dots: true,
            //     focusOnSelect: false,
            //     variableWidth: true,
            //     centerMode: true
            // });

            $carouselHolder.slick({
                autoplay: false,
                // cssEase: 'linear',
                slidesToScroll: 1,
                slidesToShow: 1,
                arrows: true,
                dots: false,
                asNavFor: '#slider-navigation',
                nextArrow: '<a class="btn-arrow arrow-next arrow-big" type="button"></a>',
                prevArrow: '<a class="btn-arrow arrow-prev arrow-big" type="button"></a>'
            });

            $('#slider-navigation').slick({
                autoplay: false,
                slidesToShow: 2,
                slidesToScroll: 1,
                asNavFor: '#carousel-holder',
                arrows: true,
                // dots: true,
                focusOnSelect: true,
                variableWidth: true,
                // nextArrow: '<a class="btn-arrow arrow-next" type="button"></a>',
                // prevArrow: '<a class="btn-arrow arrow-prev" type="button"></a>'
                // responsive: [
                //     {
                //         breakpoint: 1024,
                //         settings: {
                //             slidesToShow: 2,
                //             slidesToScroll: 1,
                //             infinite: true,
                //             dots: true
                //         }
                //     },
                //     {
                //         breakpoint: 600,
                //         settings: {
                //             slidesToShow: 2,
                //             slidesToScroll: 1
                //         }
                //     },
                //     {
                //         breakpoint: 480,
                //         settings: {
                //             slidesToShow: 2,
                //             slidesToScroll: 1
                //         }
                //     }
                //     // You can unslick at a given breakpoint now by adding:
                //     // settings: "unslick"
                //     // instead of a settings object
                // ]
            });

            // Remove active class from all thumbnail slides
            $sliderNavigationSlickSlide.removeClass('slick-active');

            // Set active class to first thumbnail slides
            $sliderNavigationSlickSlide.eq(0).addClass('slick-active');

            // On before slide change match active thumbnail to current slide
            $carouselHolder.on('beforeChange', function (event, slick, currentSlide, nextSlide) {
                var mySlideNumber = nextSlide;
                stopActiveVideo();
                $sliderNavigationSlickSlide.removeClass('slick-active');
                $sliderNavigationSlickSlide.eq(mySlideNumber).addClass('slick-active');
            });

            //Handling video descriptions outside of modal
            $('#video-description-0').show();
            $carouselInner.on('beforeChange', function (event, slick, currentSlide, nextSlide) {
                $('#video-description-' + currentSlide).hide();
                $('#video-description-' + nextSlide).show();
            });

            menu();
            // $('.carousel-inner').slick('setPosition');

            $('.carousel-block').closest(".has-dropdown").mouseleave(function () {
                stopActiveVideo();
            });

            $(document).on('hidden.bs.modal', '.modal', function (e) {
                stopModalActiveVideo();
            })

            $('.carousel-inner .slick-arrow').on('click', stopActiveVideo);

            $('.btn-arrow.arrow-big.slick-arrow').on('click', stopModalActiveVideo);

        });

        function stopActiveVideo() {
            let videoiFrame = $('iframe', '#video-carousel');
            videoiFrame.each(function () {
                $(this)[0].contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
            });
        }

        function stopModalActiveVideo() {
            let videoModalIFrames = $('.modal-body .slick-slide iframe');
            videoModalIFrames.each(function () {
                $(this)[0].contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
            });
        }

        function showVideoModal() {
            $(".video-modal").modal();
            $(".slick-slide.slick-current.slick-active", "#slider-navigation").click()
        }

        $(".video-modal").on('shown.bs.modal', function (e) {
            $("#carousel-holder").css("visibility", "visible");
        })


        function menu() {
            var win = $(window);
            $('.open-close-block .simple-collapse__bodyInner').each(function () {
                var holder = $(this);
                var list = holder.find('.list-navigation');
                var mainItems = list.find('li');
                var drops = holder.find('.has-dropdown > ul, .carousel-block')
                var setMinHeight = function (val, el) {
                    el = el !== undefined ? el : drops;
                    el.css({
                        'min-height': val
                    });
                }

                var resizeHandler = function () {
                    setMinHeight(holder.outerHeight())
                }

                var enterHandler = function (e) {
                    var item = $(e.target);
                    item = item.hasClass('has-dropdown') ? item : item.closest('li');
                    var dropUp = item.closest('ul');
                    setMinHeight(dropUp.outerHeight(), holder);
                    if (item.hasClass('has-dropdown')) {
                        var drop = item.find('> ul, .carousel-block');
                        setMinHeight(Math.max(holder.outerHeight(), drop.outerHeight()), holder);
                    }
                }

                var leaveHandler = function () {
                    setMinHeight('', holder);
                }

                ResponsiveHelper.addRange({
                    '768..': {
                        on: function () {
                            setMinHeight(holder.outerHeight())
                            win.on('resize orientationchange', resizeHandler);
                            mainItems
                                .on('mouseenter', enterHandler)
                                // .on('mouseleave', leaveHandler);
                        }
                    },
                    '..767': {
                        on: function () {
                            win.off('resize orientationchange', resizeHandler);
                            mainItems
                                .off('mouseenter', enterHandler)
                                // .off('mouseleave', leaveHandler);
                            setTimeout(function () {
                                setMinHeight('');
                            }, 100)
                        }
                    }
                });
            })
        }

        /*
         * Responsive Layout helper
         */
        window.ResponsiveHelper = (function ($) {
            // init variables
            var handlers = [],
                prevWinWidth,
                win = $(window),
                nativeMatchMedia = false;

            // detect match media support
            if (window.matchMedia) {
                if (window.Window && window.matchMedia === Window.prototype.matchMedia) {
                    nativeMatchMedia = true;
                } else if (window.matchMedia.toString().indexOf('native') > -1) {
                    nativeMatchMedia = true;
                }
            }

            // prepare resize handler
            function resizeHandler() {
                var winWidth = win.width();
                if (winWidth !== prevWinWidth) {
                    prevWinWidth = winWidth;

                    // loop through range groups
                    $.each(handlers, function (index, rangeObject) {
                        // disable current active area if needed
                        $.each(rangeObject.data, function (property, item) {
                            if (item.currentActive && !matchRange(item.range[0], item.range[1])) {
                                item.currentActive = false;
                                if (typeof item.disableCallback === 'function') {
                                    item.disableCallback();
                                }
                            }
                        });

                        // enable areas that match current width
                        $.each(rangeObject.data, function (property, item) {
                            if (!item.currentActive && matchRange(item.range[0], item.range[1])) {
                                // make callback
                                item.currentActive = true;
                                if (typeof item.enableCallback === 'function') {
                                    item.enableCallback();
                                }
                            }
                        });
                    });
                }
            }

            win.bind('load resize orientationchange', resizeHandler);

            // test range
            function matchRange(r1, r2) {
                var mediaQueryString = '';
                if (r1 > 0) {
                    mediaQueryString += '(min-width: ' + r1 + 'px)';
                }
                if (r2 < Infinity) {
                    mediaQueryString += (mediaQueryString ? ' and ' : '') + '(max-width: ' + r2 + 'px)';
                }
                return matchQuery(mediaQueryString, r1, r2);
            }

            // media query function
            function matchQuery(query, r1, r2) {
                if (window.matchMedia && nativeMatchMedia) {
                    return matchMedia(query).matches;
                } else if (window.styleMedia) {
                    return styleMedia.matchMedium(query);
                } else if (window.media) {
                    return media.matchMedium(query);
                } else {
                    return prevWinWidth >= r1 && prevWinWidth <= r2;
                }
            }

            // range parser
            function parseRange(rangeStr) {
                var rangeData = rangeStr.split('..');
                var x1 = parseInt(rangeData[0], 10) || -Infinity;
                var x2 = parseInt(rangeData[1], 10) || Infinity;
                return [x1, x2].sort(function (a, b) {
                    return a - b;
                });
            }

            // export public functions
            return {
                addRange: function (ranges) {
                    // parse data and add items to collection
                    var result = {data: {}};
                    $.each(ranges, function (property, data) {
                        result.data[property] = {
                            range: parseRange(property),
                            enableCallback: data.on,
                            disableCallback: data.off
                        };
                    });
                    handlers.push(result);

                    // call resizeHandler to recalculate all events
                    prevWinWidth = null;
                    resizeHandler();
                }
            };
        }(jQuery));

    </script>