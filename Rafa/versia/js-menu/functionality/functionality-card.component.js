(function (globalConfig) {
    function FunctionalityCardComponent(config) {
        this.config = config;
        this.isProcesing = false;
    }

    FunctionalityCardComponent.prototype.init = init;
    FunctionalityCardComponent.prototype.initializeEvents = initializeEvents;
    FunctionalityCardComponent.prototype._functionality_filter = _functionality_filter;

    function init() {
        console.log("[FunctionalityCardComponent] Init");
        this.$functionality_filter_btn = $('.functionality_filter_btn', this.config.contentContainer);
        this.$collapse = $('.collapse', this.config.contentContainer);
        this.$cardBody = $('.card-body', this.config.contentContainer);

        this.$functionality_modal_confirm_btn = $('#functionality-confirm-btn');
        this.$functionality_modal_cancel_btn = $('#functionality-cancel-btn');

        this.initializeEvents();
        var _self = this;
        if ($('.options-content', this.config.contentContainer).length > 0) {
            setTimeout(function () {
                _self.$collapse.collapse('show').collapse('show')
                // $('#card_' + config.id + ' .fa-plus').click();
            }, 300);
        }
    }

    function initializeEvents() {
        console.log("[FunctionalityCardComponent] initializeEvents");
        var _self = this;
        if (this.$functionality_filter_btn !== undefined) {
            this.$functionality_filter_btn.on('click', _functionality_filter.bind(this));
        }
        this.$functionality_modal_confirm_btn.on('click', _functionality_filter_clean.bind(this));
        this.$functionality_modal_cancel_btn.on('click', _show_last_block.bind(this));
        this.$collapse.on('show.bs.collapse', generate_card_options.bind(this));

    }


    function _functionality_filter(event) {
        console.debug("[FunctionalityCardComponent - functionality_filter]");

        var _self = this;
        if ($(event.target).attr("data-desc") !== "" && $(event.target).attr("data-desc") !== undefined) {
            var url_redirect = $(event.target).attr("data-desc");
            window.open(url_redirect, '_blank').focus();
            return;
        }
        var navigationNodeId = event.target.getAttribute("data-navigation")
        var nodeId = event.target.getAttribute("data-node");
        var nodeName = event.target.getAttribute("data-btn")
        if ($('#card_' + navigationNodeId).next().is('.card') || ($("#container_additionalParameters") && $("#container_additionalParameters").length > 0)) {
            $('input[name="nodeid"]', '#functionality-modal').val(nodeId);
            $('input[name="navigationnode"]', '#functionality-modal').val(navigationNodeId);
            $('input[name="nodename"]', '#functionality-modal').val(nodeName);

            $("#functionality-modal").modal('show');
        } else {

            const newNode = {
                nodeId: _self.config.cardId,
                name: _self.config.cardName,
                selectedId: nodeId,
                selectedName: nodeName
            };

            setURLNodes(newNode);
            _filter_call(navigationNodeId, nodeId, nodeName);
        }
    }

    function _filter_call(navigationNodeId, nodeId, nodeName) {
        var _self = this;
        if (_self.isProcesing) {
            return;
        }
        this.isProcesing = true;
        var $selectedText = $('#selected_' + navigationNodeId);
        $selectedText.html(nodeName);

        var data = {
            filterNodeId: navigationNodeId,
            filterSelectionId: nodeId,
        };
        var url = new URL(document.getElementById('functionalityNavigationLink').href);
        url.searchParams.delete('nodes');
        url.searchParams.delete('searchData');
        url.searchParams.delete('removedFilters');
        $.get(url, data)
            .then(function (response) {
                if (response) {
                    if (response.includes("card-header")) {
                        var alreadyInDom = false;
                        $(".card-header").each(function (index, element) {
                            if (response.indexOf(element.id) > 0) {
                                alreadyInDom = true;
                            }
                        });

                        if (!alreadyInDom) {
                            $("#accordion").append(response);
                        }
                    } else {
                        $("#psfcontainer").append(response);
                    }
                }
                _self.isProcesing = false;
            })
            .catch(function (error) {
                console.debug("Functionality error" + error);
                _self.isProcesing = false;
            });
    }

    function _functionality_filter_clean() {
        let _self = this;

        let navigationNodeId = $('input[name="navigationnode"]', '#functionality-modal').val();
        if (navigationNodeId != _self.config.cardId) {
            return;
        }
        let nodeId = $('input[name="nodeid"]', '#functionality-modal').val();
        let nodeName = $('input[name="nodename"]', '#functionality-modal').val();
        let $card = $('#card_' + navigationNodeId);
        $card.nextAll('div').remove();
        $("#container_additionalParameters_modal_selection").remove();
        $("#container_additionalParameters").remove();
        $("#search_container").remove();
        $("#search-result-container").remove();
        $("#container_bestItems").remove();
        $("#functionality-modal").modal('hide');

        const url = new URL(window.location.href);
        url.searchParams.delete("searchData");
        url.searchParams.delete("removedFilters");
        window.history.replaceState({}, window.document.title, url.toString());

        const newNode = {
            nodeId: _self.config.cardId,
            name: _self.config.cardName,
            selectedId: nodeId,
            selectedName: nodeName
        };

        setURLNodes(newNode, navigationNodeId);
        _filter_call(navigationNodeId, nodeId, nodeName);
    }

    function generate_card_options() {
        const _self = this;
        // if (!_self.$cardBody.is(':empty')) {
        if ($('.options-content', this.config.contentContainer).length > 0) {
            return;
        }
        var url = new URL(document.getElementById('generateCardOptionsLink').href);
        var data = {
            filterNodeId: _self.config.parentNodeId,
            filterSelectionId: _self.config.parentSelectionId
        };
        $.get(url, data)
            .then(function (response) {
                if (response) {
                    _self.$cardBody.html(response);
                }
                _self.isProcesing = false;
            })
            .catch(function (error) {
                console.debug("Functionality error" + error);
                _self.isProcesing = false;
            })
    }

    function _show_last_block() {
        if (!($("#container_additionalParameters") && $("#container_additionalParameters").length > 0)) {
            let $card = $('.card').last();
            $('.fa-plus', $card).click();
        }
        $("#functionality-modal").modal('hide');
    }


    function setURLNodes(newNode, navigationNodeId) {
        const url = new URL(window.location.href);
        const urlNodes = url.searchParams.get("nodes");
        let nodes = [];
        if (urlNodes) {
            // nodes = JSON.parse(decodeURIComponent(urlNodes));
            nodes = JSON.parse(atob(base64DecodeUrl(urlNodes)));
        }

        if (navigationNodeId) {
            let i = 0;
            while (i < nodes.length) {
                if (nodes[i].nodeId === navigationNodeId) {
                    nodes.splice(i);
                } else {
                    ++i;
                }
            }
        }

        nodes.push(newNode);
        let newNodes = base64EncodeUrl(btoa(JSON.stringify(nodes)));
        // let newNodes = JSON.stringify(nodes);
        url.searchParams.set("nodes", newNodes);
        window.history.replaceState({}, window.document.title, url.toString());
    }

    function base64EncodeUrl(str) {
        return str.split('+').join('-').split('/').join('_').split('=').join('.');
    }

    function base64DecodeUrl(str) {
        // str = (str + '===').slice(0, str.length + (str.length % 4));
        return  str.split('-').join('+').split('_').join('/').split('.').join('=');
        // return str.replaceAll('-','+' ).replaceAll('_', '/').replaceAll('.', '=');
    }

    window.smc.FunctionalityCardComponent = FunctionalityCardComponent;
})(window.smc);

var ssi_columns = '';