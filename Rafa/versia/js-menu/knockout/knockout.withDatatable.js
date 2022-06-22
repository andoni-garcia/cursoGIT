(function (ko) {
    var log = function () {

        if ('PROD' === 'EDIT') {
            var args = Array.prototype.slice.call(arguments);
            console.log(args);
        }
    };
    if (!ko.iketek) ko.iketek = {};
    ko.iketek.datatable_defaults = {
        inPlaceSorting: false,
        inPlacePaging: false,
        refreshOnFilterUpdate: true
    };
    ko.iketek.withDatatable = function (viewModel, _opts) {
        var initialized = false;
        var opts = $.extend(ko.iketek.datatable_defaults, _opts);
        var getPersitentObject = function () {
            var formatted = opts.container.replace(/([A-Z])/g, "_$1").toLowerCase();
            if (window["ko_persist_" + opts.container]) return window["ko_persist_" + opts.container];
            if (window["ko_persist_" + formatted]) return window["ko_persist_" + formatted];
            return {};
        };
        var RPPObj = function (val) {
            if (typeof val == "string") {
                this.text = val;
            } else {
                this.text = opts.recordsPerPage.replace(/_RECORDS_/g, val);
            }
            this.value = val;
        };
        RPPObj.prototype.toString = function () { return this.text; };
        var persObj = opts.persistentObject ? opts.persistentObject : getPersitentObject();
        viewModel.datatable = {};
        viewModel.datatable.initializating = ko.observable(true);
        viewModel.datatable.loading = ko.observable(false);
        viewModel.datatable.noElementsMsg = opts.noElementsMsg;
        viewModel[opts.data] = ko.observableArray([]);
        viewModel.datatable.infoMessage = ko.observable(opts.info);
        viewModel.datatable.container = opts.container;
        viewModel.datatable.lastCaller = ko.observable(null);

        /*
         * Filtering functionality
         */
        viewModel.datatable.filter = { __names__: [] };
        if ($.isArray(opts.filters)) {
            for (var i = 0; i < opts.filters.length; i++) {
                var fname = opts.filters[i];
                var defaultVal = "", extend, prot = false;
                if ($.isPlainObject(fname)) {
                    defaultVal = fname["defaultValue"];
                    extend = fname["extend"];
                    prot = fname["protected"];
                    fname = fname["name"];
                }
                viewModel.datatable.filter.__names__.push(fname);
                if (prot)
                    viewModel.datatable.filter[fname] = ko.protectedObservable(persObj[fname] ? persObj[fname] : defaultVal);
                else
                    viewModel.datatable.filter[fname] = ko.observable(persObj[fname] ? persObj[fname] : defaultVal);
                if ($.isPlainObject(extend))
                    viewModel.datatable.filter[fname] = viewModel.datatable.filter[fname].extend(extend);
            }
        }
        viewModel.datatable.resetFilters = function () {
            if ($.isArray(opts.filters)) {
                for (var i = 0; i < opts.filters.length; i++) {
                    var fname = opts.filters[i];
                    var defaultVal = "";
                    if ($.isPlainObject(fname)) {
                        defaultVal = fname["defaultValue"];
                        fname = fname["name"];
                    }
                    viewModel.datatable.filter[fname](defaultVal);
                }
            }
        };

        /*
         * Sorting functionality
         */
        viewModel.datatable.sorting = {
            iSortCol: ko.observable(),
            SortableColumn: function (index, text, selecText, singleDir) {
                this.index = index;
                this.text = text;
                this.selectedText = selecText;
                this.singleDir = singleDir || false;
                this.className = ko.observable("");
                var that = this;
                this.displayText = ko.pureComputed(function () {
                    if (viewModel.datatable.sorting.iSortCol() == that) {
                        return ko.iketek.decodeHTML(that.selectedText);
                    } else {
                        return ko.iketek.decodeHTML(that.text);
                    }
                });
            },
            sortColumns: ko.observableArray([])
        };
        if ($.isArray(opts["orderColumns"])) {
            for (var i = 0; i < opts["orderColumns"].length; i++) {
                var cinfo = opts["orderColumns"][i];
                var sc = new viewModel.datatable.sorting.SortableColumn(cinfo["id"], cinfo["text"], cinfo["selectedText"], cinfo["singleDir"]);
                viewModel.datatable.sorting.sortColumns.push(sc);
            }
        }
        var persistSet = (typeof persObj.iSortCol_0 !== 'undefined') && persObj.iSortCol_0 != 'NaN'
            && persObj.iSortCol_0 != 'null' && persObj.iSortCol_0 != 'undefined';
        var isc = (persistSet) ? parseInt(persObj.iSortCol_0) : 0;
        log("Persisted sorting column: " + persObj.iSortCol_0 + " (" + persistSet + ")");
        if (!persistSet) {
            var dt = typeof opts["detaultOrderColumn"] == 'number';
            var df = typeof opts["defaultOrderColumn"] == 'number';
            if (!dt && !df) isc = 0;
            else if (dt) isc = opts["detaultOrderColumn"];
            else isc = opts["defaultOrderColumn"];
            log("Default order column is " + isc);
        }
        //var selSC = viewModel.datatable.sorting.sortColumns().length > isc ? viewModel.datatable.sorting.sortColumns()[isc] :
        //																	 new viewModel.datatable.sorting.SortableColumn(isc);
        // Get current sorting column by index attribute
        var selSC = viewModel.datatable.sorting.sortColumns().filter(function (x) { return x.index == isc; });
        log(selSC);
        if (selSC.length == 1) selSC = selSC[0];
        else selSC = viewModel.datatable.sorting.SortableColumn(isc);
        viewModel.datatable.sorting.iSortCol(selSC);
        viewModel.datatable.sorting.sSortDir = ko.observable(persObj.sSortDir_0 ? persObj.sSortDir_0 : "asc");

        /*
         * Paging functionality
         */
        viewModel.datatable.iDisplayStart = ko.observable(persObj.iDisplayStart ? parseInt(persObj.iDisplayStart) : 0);
        viewModel.datatable.iDisplayLength = ko.observable(new RPPObj(persObj.iDisplayLength ? parseInt(persObj.iDisplayLength) : 10));
        log(viewModel.datatable.iDisplayStart() + "/" + viewModel.datatable.iDisplayLength());
        viewModel.datatable.sEcho = 1;
        viewModel.datatable.pages = ko.observable(1);
        viewModel.datatable.page = ko.observable(viewModel.datatable.iDisplayStart() / viewModel.datatable.iDisplayLength().value + 1);
        viewModel.datatable.orderType = ko.observable('');
        viewModel.datatable.customFilters = ko.observable({});
        viewModel.datatable.visiblePages = ko.computed(function () {
            // DONE: Fix pager for when in place paging is selected
            var totalPages = viewModel.datatable.pages();
            var currentPage = viewModel.datatable.page();
            var pages = [];

            var disableFirst = false;
            if (currentPage == 1) disableFirst = true;
            var disableLast = false;
            if (currentPage == totalPages) disableLast = true;

            pages.push({ text: '&laquo;', page: 1, prevNext: 'fa-angle-double-left', disabled: disableFirst });
            pages.push({ text: '&lsaquo;', page: Math.max(currentPage - 1, 1), prevNext: 'fa-angle-left', disabled: disableFirst });
            var temp = [];
            for (var i = currentPage - 4; i <= currentPage + 4; i++) if (i > 0 && i <= totalPages) temp.push(i);
            var mid = Math.floor(temp.length / 2) - 1;
            if (temp.length > 1 && temp[mid + 1] == currentPage) mid++;
            else if (totalPages - currentPage <= 2) mid = temp.length - 3;
            for (var i = Math.max(0, mid - 2); i <= Math.min(mid + 2, temp.length - 1); i++) pages.push({ text: temp[i], page: temp[i], prevNext: null, disabled: false });
            pages.push({ text: '&rsaquo;', page: Math.min(currentPage + 1, totalPages), prevNext: 'fa-angle-right', disabled: disableLast });
            pages.push({ text: '&raquo;', page: totalPages, prevNext: 'fa-angle-double-right', disabled: disableLast });
            return pages;
        });
        viewModel.datatable.recordsPerPage = ko.observableArray(opts.recordsSelector);
        var currentVal = viewModel.datatable.iDisplayLength().value;
        viewModel.datatable.recordsPerPageSelector = ko.computed(function () {
            var rppArr = viewModel.datatable.recordsPerPage();
            var result = [];
            var found = false;
            for (var i = 0; i < rppArr.length; i++) {
                var obj = new RPPObj(rppArr[i]);

                if (typeof (obj.value) == "string") {
                    obj.value = 1000;
                }

                result.push(obj);

                if (!found) {
                    viewModel.datatable.iDisplayLength(obj);
                }
                if (rppArr[i] == currentVal) {
                    found = true;
                }
            }
            return result;
        });
        viewModel[opts.data].paginated = ko.pureComputed(function () {
            var elems = viewModel[opts.data](), start = viewModel.datatable.iDisplayStart(), length = viewModel.datatable.iDisplayLength().value;
            var iS = Math.min(start, elems.length);
            var iE = Math.min(iS + length, elems.length);
            return elems.slice(iS, iE);
        });
        var updatePagerText = function () {
            // DOING: Persist changes in session
            var elems = viewModel[opts.data](), start = viewModel.datatable.iDisplayStart(), length = viewModel.datatable.iDisplayLength().value;
            var iS = Math.min(start, elems.length);
            var iE = Math.min(iS + length, elems.length);
            var msg = opts.info.replace(/_START_/g, iS + 1)
                .replace(/_END_/g, iE)
                .replace(/_TOTAL_/g, elems.length);
            viewModel.datatable.infoMessage(msg);
            return iS;
        };

        /*
         * Core functionality
         */
        viewModel.datatable.resetPageAndRefresh = function () {
            viewModel.datatable.page(1);
            viewModel.datatable.iDisplayStart(0);
            viewModel.datatable.refresh();
        };
        viewModel.datatable.selectLength = function (length) {
            viewModel.datatable.iDisplayLength(length);
            viewModel.datatable.iDisplayLength.valueHasMutated();
        };
        viewModel.datatable.refresh = function (extraParams) {
            if (initialized) {
                viewModel.datatable.loading(true);
                // Reset Message
                // var msg = opts.info.replace(/_START_/g, "0")
                //                    .replace(/_END_/g,  "0")
                //                    .replace(/_TOTAL_/g, "0");
                // viewModel.datatable.infoMessage(msg);

                var defaultPostData = {
                    rn: Math.random(),
                    sEcho: viewModel.datatable.sEcho++,
                    page: viewModel.datatable.page() - 1,
                    page_elements: viewModel.datatable.iDisplayLength().value,
                    search: viewModel.datatable.filter.favouritesFilter,
                    iDisplayStart: viewModel.datatable.iDisplayStart(),
                    iDisplayLength: viewModel.datatable.iDisplayLength().value,
                    iSortCol_0: (viewModel.datatable.sorting.iSortCol()) ? viewModel.datatable.sorting.iSortCol().index : 0,
                    sSortDir_0: viewModel.datatable.sorting.sSortDir(), // TODO: Figure out ASC/DESC sorting
                    order: viewModel.datatable.orderType,
                };

                var postData = $.extend(defaultPostData, viewModel.datatable.customFilters());

                for (var i = 0; i < viewModel.datatable.filter.__names__.length; i++) {
                    var name = viewModel.datatable.filter.__names__[i];
                    postData["ko_filter_" + name] = viewModel.datatable.filter[name]();
                }
                if ($.isPlainObject(extraParams))
                    postData = $.extend(postData, extraParams);
                if ($.isPlainObject(opts["postData"]))
                    postData = $.extend(postData, opts["postData"]);
                else if ($.isFunction(opts["postData"]))
                    postData = opts["postData"](postData);
                viewModel.datatable.lastCaller(postData.sEcho);
                if(postData.page < 0) return;
                setTimeout(function () {

                    if (postData.sEcho == viewModel.datatable.lastCaller()) {

                        $.ajaxHippo({
                            type: 'POST',
                            dataType : 'json',
                            url: opts.url,
                            data: postData,
                            success: function (data) {
                                //if (data.sEcho == (viewModel.datatable.sEcho -1) + ""){
                                var defaultData = { content: [], iTotalDisplayRecords: 0, foundElements: 0 };
                                var normalizedData = viewModel.normalizeDatatable(data) || defaultData;
                                //If the actual page has not records to show, after product deletion for example.
                                var stopLoading = true;
                                if (normalizedData.iTotalDisplayRecords == 0 && viewModel.datatable.iDisplayStart() > 0) {
                                    var start = viewModel.datatable.iDisplayStart();
                                    viewModel.datatable.iDisplayStart(start - viewModel.datatable.iDisplayLength().value);
                                    viewModel.datatable.page(viewModel.datatable.page() - 1);
                                    stopLoading = false;
                                }
                                var mapped = ko.iketek.modelMapper(normalizedData.content, opts.extras, opts["fnExtras"], opts["elemCallback"]);
                                opts["appendPages"] ? viewModel[opts.data](viewModel[opts.data]().concat(mapped())) : viewModel[opts.data](mapped());
                                //Apply some function to global returned data
                                if (opts.globalCallback && typeof opts.globalCallback == 'function') opts.globalCallback(data);
                                var totalRec = parseInt(normalizedData.foundElements);
                                var iS = viewModel.datatable.iDisplayStart() + 1;
                                if (totalRec == 0) iS = 0;
                                var iE = opts["inPlacePaging"] ? Math.min(iS + viewModel.datatable.iDisplayLength().value - 1, viewModel[opts.data]().length) : viewModel.datatable.iDisplayStart() + parseInt(normalizedData.iTotalDisplayRecords);
                                if (normalizedData.iTotalDisplayRecords == 0) iE = 0;
                                var msg = opts.info.replace(/_START_/g, iS)
                                    .replace(/_END_/g, iE)
                                    .replace(/_TOTAL_/g, normalizedData.foundElements);
                                viewModel.datatable.infoMessage(msg);
                                viewModel.datatable.pages(Math.ceil(totalRec / viewModel.datatable.iDisplayLength().value));
                                if (stopLoading) {
                                    viewModel.datatable.loading(false);
                                    viewModel.datatable.initializating(false);
                                }
                                ko.iketek.fireEvent(document.body, "ikReload");
                                //}
                            }
                        }); 

                        // $.post(opts.url, postData, function (data) {
                        //     //if (data.sEcho == (viewModel.datatable.sEcho -1) + ""){
                        //     var defaultData = { content: [], iTotalDisplayRecords: 0, foundElements: 0 };
                        //     var normalizedData = viewModel.normalizeDatatable(data) || defaultData;
                        //     //If the actual page has not records to show, after product deletion for example.
                        //     var stopLoading = true;
                        //     if (normalizedData.iTotalDisplayRecords == 0 && viewModel.datatable.iDisplayStart() > 0) {
                        //         var start = viewModel.datatable.iDisplayStart();
                        //         viewModel.datatable.iDisplayStart(start - viewModel.datatable.iDisplayLength().value);
                        //         viewModel.datatable.page(viewModel.datatable.page() - 1);
                        //         stopLoading = false;
                        //     }
                        //     var mapped = ko.iketek.modelMapper(normalizedData.content, opts.extras, opts["fnExtras"], opts["elemCallback"]);
                        //     opts["appendPages"] ? viewModel[opts.data](viewModel[opts.data]().concat(mapped())) : viewModel[opts.data](mapped());
                        //     //Apply some function to global returned data
                        //     if (opts.globalCallback && typeof opts.globalCallback == 'function') opts.globalCallback(data);
                        //     var totalRec = parseInt(normalizedData.foundElements);
                        //     var iS = viewModel.datatable.iDisplayStart() + 1;
                        //     if (totalRec == 0) iS = 0;
                        //     var iE = opts["inPlacePaging"] ? Math.min(iS + viewModel.datatable.iDisplayLength().value - 1, viewModel[opts.data]().length) : viewModel.datatable.iDisplayStart() + parseInt(normalizedData.iTotalDisplayRecords);
                        //     if (normalizedData.iTotalDisplayRecords == 0) iE = 0;
                        //     var msg = opts.info.replace(/_START_/g, iS)
                        //         .replace(/_END_/g, iE)
                        //         .replace(/_TOTAL_/g, normalizedData.foundElements);
                        //     viewModel.datatable.infoMessage(msg);
                        //     viewModel.datatable.pages(Math.ceil(totalRec / viewModel.datatable.iDisplayLength().value));
                        //     if (stopLoading) {
                        //         viewModel.datatable.loading(false);
                        //         viewModel.datatable.initializating(false);
                        //     }
                        //     ko.iketek.fireEvent(document.body, "ikReload");
                        //     //}
                        // }, "json");
                    }
                    $(".ikSelectAll input:first").attr('checked', false);
                }, 500);
            }
        };

        /*
         * Subscriptions, event handlers...
         */
        viewModel.datatable.pageClicked = function (pageElem) {
            viewModel.datatable.page(pageElem.page);
            viewModel.datatable.iDisplayStart((pageElem.page - 1) * viewModel.datatable.iDisplayLength().value);
        };
        viewModel.datatable.iDisplayLength.subscribe(function (newV, oldV) {
            viewModel.datatable.page(1);
            var launchRefresh = !opts["inPlacePaging"] && viewModel.datatable.iDisplayStart() == 0;
            viewModel.datatable.iDisplayStart(0);
            if (opts["inPlacePaging"]) {
                viewModel.datatable.pages(Math.ceil(viewModel.elements().length / newV.value));
                //var iS = updatePagerText();
                //$.get("https://www.smc.eu/portal_ssl/WebContent/basket_v2/includes/utils/IkDatatablePersistence.jsp?namespace=" + opts["container"] + "&action=store_and_keep&iDisplayStart=" + iS + "&iDisplayLength=" + newV.value);
            }
            if (launchRefresh) viewModel.datatable.refresh();
        }, viewModel);
        viewModel.datatable.iDisplayStart.subscribe(function () {
            if (!opts["inPlacePaging"]) {
                viewModel.datatable.refresh();
            } else {
                var iS = updatePagerText();
                var length = viewModel.datatable.iDisplayLength().value;
                //$.get("https://www.smc.eu/portal_ssl/WebContent/basket_v2/includes/utils/IkDatatablePersistence.jsp?namespace=" + opts["container"] + "&action=store_and_keep&iDisplayStart=" + iS + "&iDisplayLength=" + length);
            }
        });
        viewModel.datatable.sorting.iSortCol.subscribe(viewModel.datatable.resetPageAndRefresh, viewModel);
        if (opts["refreshOnFilterUpdate"]) {
            for (var i = 0; i < viewModel.datatable.filter.__names__.length; i++) {
                var name = viewModel.datatable.filter.__names__[i];
                (viewModel.datatable.filter[name]).subscribe(viewModel.datatable.resetPageAndRefresh, viewModel);
            }
        }
        // DEPRECATED: Remove old sorting functionality
        //ko.iketek.bindSortables(opts.container);
        initialized = true;
    };
    // DEPRECATED: Remove old sorting functionality
    ko.iketek.bindSortables = function (container, datatable) {
        $(document).ready(function () {
            $("#" + container).find(".ikSortableColumn").each(function () {
                var sc = new viewModel.datatable.sorting.SortableColumn($(this).index());
                ko.applyBindingsToNode(this, { click: datatable.sorting.sort.bind(datatable, sc), css: sc.className }, datatable);
            });
        });
    };
})(ko);
