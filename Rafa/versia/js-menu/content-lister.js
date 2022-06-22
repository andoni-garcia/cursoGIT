"use strict";

function _instanceof(left, right) { if (right != null && typeof Symbol !== "undefined" && right[Symbol.hasInstance]) { return right[Symbol.hasInstance](left); } else { return left instanceof right; } }

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!_instanceof(instance, Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

var Form =
    /*#__PURE__*/
    function (_React$Component) {
        _inherits(Form, _React$Component);

        function Form() {
            var _getPrototypeOf2;

            var _this;

            _classCallCheck(this, Form);

            for (var _len = arguments.length, args = new Array(_len), _key = 0; _key < _len; _key++) {
                args[_key] = arguments[_key];
            }

            _this = _possibleConstructorReturn(this, (_getPrototypeOf2 = _getPrototypeOf(Form)).call.apply(_getPrototypeOf2, [this].concat(args)));

            _defineProperty(_assertThisInitialized(_this), "state", {
                searchQuery: ''
            });

            _defineProperty(_assertThisInitialized(_this), "doSearch", function (event) {
                _this.setState({
                    searchQuery: event.target.value
                }, function () {
                    _this.props.onSomething(_this.state.searchQuery);
                });
            });

            _defineProperty(_assertThisInitialized(_this), "resetForm", function (event) {
                event.preventDefault();

                _this.setState({
                    searchQuery: ''
                }, function () {
                    _this.props.resetResults();
                });
            });

            return _this;
        }

        _createClass(Form, [{
            key: "render",
            value: function render() {
                return React.createElement("form", {
                    className: "row",
                    onSubmit: this.resetForm
                }, React.createElement("div", {
                    className: "form-group col-md-10"
                }, React.createElement("input", {
                    type: "text",
                    className: "form-control",
                    placeholder: this.props.formData.placeholder,
                    value: this.state.searchQuery,
                    onChange: this.doSearch
                }), React.createElement("div", {
                    className: "search-inpage__submit"
                }, React.createElement("span", {
                    className: "icon-close"
                }))), React.createElement("div", {
                    className: "form-group col-md-2"
                }, React.createElement("button", {
                    type: "submit",
                    className: "btn btn-primary btn-full"
                }, this.props.formData.buttonLabel)));
            }
        }]);

        return Form;
    }(React.Component);

var Thead =
    /*#__PURE__*/
    function (_React$Component2) {
        _inherits(Thead, _React$Component2);

        function Thead() {
            var _getPrototypeOf3;

            var _this2;

            _classCallCheck(this, Thead);

            for (var _len2 = arguments.length, args = new Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
                args[_key2] = arguments[_key2];
            }

            _this2 = _possibleConstructorReturn(this, (_getPrototypeOf3 = _getPrototypeOf(Thead)).call.apply(_getPrototypeOf3, [this].concat(args)));

            _defineProperty(_assertThisInitialized(_this2), "state", {
                asc: false,
                sorted: false
            });

            _defineProperty(_assertThisInitialized(_this2), "testur", function (header) {
                _this2.props.onSort(header, _this2.state.asc);

                _this2.setState({
                    asc: !_this2.state.asc,
                    sorted: true
                });
            });

            _defineProperty(_assertThisInitialized(_this2), "getStuff", function (header) {
                var ret = '';

                if (header.label !== 'documents') {
                    ret = React.createElement("th", {
                        onClick: function onClick() {
                            return _this2.testur(header.label);
                        },
                        key: header.label,
                        "data-sort": "string"
                    }, React.createElement("span", null, header.translation));
                } else {
                    ret = React.createElement("th", {
                        className: "content-lister__resultsTable--noSort",
                        key: header.label
                    }, React.createElement("span", null, header.translation));
                }

                return ret;
            });

            return _this2;
        }

        _createClass(Thead, [{
            key: "render",
            value: function render() {
                var _this3 = this;

                return React.createElement("thead", null, React.createElement("tr", null, this.props.headers.map(function (header) {
                    return _this3.getStuff(header);
                })));
            }
        }]);

        return Thead;
    }(React.Component);

var Field = function Field(props) {
    return React.createElement("td", {
        dangerouslySetInnerHTML: {
            __html: props.label
        }
    });
};

var FieldImage = function FieldImage(props) {
    return React.createElement("td", null, React.createElement("img", {
        className: "simbol-image",
        src: props.label
    }));
};

var Filesmodal = function Filesmodal(props) {
    return React.createElement("div", {
        className: "filesModal content-lister__modal"
    }, React.createElement("ul", null, props.files.map(function (file) {
        return React.createElement("li", null, React.createElement("a", {
            target: "_blank",
            href: file.url
        }, file.label));
    })));
};

var Langmodal = function Langmodal(props) {
    return React.createElement("li", {
        className: "content-lister__resultsTable--modalTrigger content-lister__resultsTable__iconContainer"
    }, React.createElement("a", {
        href: "#"
    }, React.createElement("i", {
        className: "icon-small-plus"
    })), React.createElement("div", {
        className: "langModal content-lister__modal"
    }, React.createElement("ul", null, props.langs.map(function (lang) {
        var files = lang.files.map(function (file) {
            return React.createElement("li", null, React.createElement("a", {
                target: "_blank",
                href: file.url
            }, file.label));
        });
        return [React.createElement("li", null, lang.lang), files];
    }))));
};

var Documents =
    /*#__PURE__*/
    function (_React$Component3) {
        _inherits(Documents, _React$Component3);

        function Documents() {
            var _getPrototypeOf4;

            var _this4;

            _classCallCheck(this, Documents);

            for (var _len3 = arguments.length, args = new Array(_len3), _key3 = 0; _key3 < _len3; _key3++) {
                args[_key3] = arguments[_key3];
            }

            _this4 = _possibleConstructorReturn(this, (_getPrototypeOf4 = _getPrototypeOf(Documents)).call.apply(_getPrototypeOf4, [this].concat(args)));

            _defineProperty(_assertThisInitialized(_this4), "getList", function (docs) {
                var list = [];
                if (docs) {
                    var secondaryLanguages = docs.slice(0);
                    var primaryLanguages = secondaryLanguages.splice(0, 2);
                    primaryLanguages.map(function (doc) {
                        if (doc.files.length === 0) {
                            if (doc.lang != null) {
                                list.push(React.createElement("li", {
                                    className: "content-lister__resultsTable__emptyLink"
                                }, doc.lang));
                            }
                        } else if (doc.files.length === 1) {
                            list.push(React.createElement("li", null, React.createElement("a", {
                                target: "_blank",
                                href: doc.files[0].url
                            }, doc.lang)));
                        } else {
                            list.push(React.createElement("li", {
                                className: "content-lister__resultsTable--modalTrigger"
                            }, React.createElement("a", {
                                href: "#"
                            }, doc.lang), React.createElement(Filesmodal, {
                                files: doc.files
                            })));
                        }
                    });

                    if (secondaryLanguages.length > 0) {
                        list.push(React.createElement(Langmodal, {
                            langs: secondaryLanguages
                        }));
                    } else {//list.push(<li className="content-lister__resultsTable__inactiveMoreLangs"><i className="icon-small-plus"></i></li>)
                    }
                }

                return list;
            });

            return _this4;
        }

        _createClass(Documents, [{
            key: "render",
            value: function render() {
                return React.createElement("td", null, React.createElement("ul", {
                    className: "content-lister__resultsTable__langList"
                }, this.getList(this.props.documents)));
            }
        }]);

        return Documents;
    }(React.Component);

var Tbody = function Tbody(props) {
    var getFields = function getFields(item) {
        var fields = [];
        props.fieldsToDisplay.map(function (h) {
            if (h.label === 'symbol') {
                fields.push(React.createElement(FieldImage, {
                    label: item[h.label]
                }));
            } else {
                fields.push(React.createElement(Field, {
                    label: item[h.label]
                }));
            }
        });
        return fields;
    };

    return React.createElement("tbody", null, props.items.map(function (i) {
        return React.createElement("tr", null, getFields(i), React.createElement(Documents, {
            documents: i.documents
        }));
    }));
};

var Thitem =
    /*#__PURE__*/
    function (_React$Component4) {
        _inherits(Thitem, _React$Component4);

        function Thitem() {
            var _getPrototypeOf5;

            var _this5;

            _classCallCheck(this, Thitem);

            for (var _len4 = arguments.length, args = new Array(_len4), _key4 = 0; _key4 < _len4; _key4++) {
                args[_key4] = arguments[_key4];
            }

            _this5 = _possibleConstructorReturn(this, (_getPrototypeOf5 = _getPrototypeOf(Thitem)).call.apply(_getPrototypeOf5, [this].concat(args)));

            _defineProperty(_assertThisInitialized(_this5), "getClassName", function () {
                var clz = '';

                if (_this5.props.sortable === true) {
                    if (_this5.props.sorted === null) {
                        clz = '';
                    } else {
                        if (_this5.props.sorted === true) {
                            clz = 'headerSortUp';
                        } else {
                            clz = 'headerSortDown';
                        }
                    }
                } else {
                    clz = 'content-lister__resultsTable--noSort';
                }

                return clz;
            });

            _defineProperty(_assertThisInitialized(_this5), "thClicked", function () {
                if (_this5.props.sortable === true) {
                    _this5.props.onSetHeaderSortInfo(_this5.props.code, _this5.getClassName);
                } // this.setClassName()

            });

            return _this5;
        }

        _createClass(Thitem, [{
            key: "render",
            value: function render() {
                return React.createElement("th", {
                    className: this.getClassName(),
                    onClick: this.thClicked
                }, React.createElement("span", null, this.props.label));
            }
        }]);

        return Thitem;
    }(React.Component);

var Theader = function Theader(props) {
    return React.createElement("thead", null, React.createElement("tr", null, props.headers.map(function (header) {
        return React.createElement(Thitem, {
            sorted: header.sorted,
            label: header.translation,
            onSort: props.onSort,
            onSetHeaderSortInfo: props.onSetHeaderSortInfo,
            code: header.label,
            sortable: header.sortable
        });
    })));
};

var Table =
    /*#__PURE__*/
    function (_React$Component5) {
        _inherits(Table, _React$Component5);

        function Table() {
            _classCallCheck(this, Table);

            return _possibleConstructorReturn(this, _getPrototypeOf(Table).apply(this, arguments));
        }

        _createClass(Table, [{
            key: "render",
            value: function render() {
                if (this.props.itemsLength > 0) {
                    return React.createElement("div", {
                        className: "row"
                    }, React.createElement("div", {
                        className: "col-md-12"
                    }, React.createElement("table", {
                        className: "content-lister__resultsTable"
                    }, React.createElement(Theader, {
                        headers: this.props.headers,
                        onSort: this.props.onSort,
                        onSetHeaderSortInfo: this.props.onSetHeaderSortInfo
                    }), React.createElement(Tbody, {
                        items: this.props.items,
                        fieldsToDisplay: this.props.fieldsToDisplay
                    }))));
                }

                return null;
            }
        }]);

        return Table;
    }(React.Component);

var App =
    /*#__PURE__*/
    function (_React$Component6) {
        _inherits(App, _React$Component6);

        function App() {
            var _getPrototypeOf6;

            var _this6;

            _classCallCheck(this, App);

            for (var _len5 = arguments.length, args = new Array(_len5), _key5 = 0; _key5 < _len5; _key5++) {
                args[_key5] = arguments[_key5];
            }

            _this6 = _possibleConstructorReturn(this, (_getPrototypeOf6 = _getPrototypeOf(App)).call.apply(_getPrototypeOf6, [this].concat(args)));

            _defineProperty(_assertThisInitialized(_this6), "state", {
                items: _this6.props.data.items,
                headers: _this6.props.data.headers,
                fieldsToDisplay: _this6.props.data.fieldsToDisplay,
                formData: _this6.props.data.formData
            });

            _defineProperty(_assertThisInitialized(_this6), "filterData", function (item, regex) {
                var ret = false;

                _this6.state.fieldsToDisplay.map(function (key) {
                    if (item[key.label].match(regex)) {
                        ret = true;
                    }
                });

                return ret;
            });

            _defineProperty(_assertThisInitialized(_this6), "testFilter", function (inp) {
                var result = [];
                var regex = new RegExp(inp, 'gi');

                _this6.props.data.items.map(function (item) {
                    if (_this6.filterData(item, regex)) {
                        result.push(item);
                    }
                });

                return result;
            });

            _defineProperty(_assertThisInitialized(_this6), "testAppMethod", function (x) {
                _this6.setState({
                    items: _this6.testFilter(x)
                });
            });

            _defineProperty(_assertThisInitialized(_this6), "resetResults", function () {
                _this6.setState({
                    items: _this6.props.data.items
                }, function () {
                    _this6.sortJson('model', true);

                    _this6.resetHeaderSort();
                });
            });

            _defineProperty(_assertThisInitialized(_this6), "sortJson", function (key, asc) {
                var array = _this6.state.items;
                array.sort(function (a, b) {
                    var x = a[key];
                    var y = b[key];

                    if (asc === true) {
                        return x < y ? -1 : x > y ? 1 : 0;
                    } else {
                        return x > y ? -1 : x < y ? 1 : 0;
                    }
                });

                _this6.setState({
                    items: array
                });
            });

            _defineProperty(_assertThisInitialized(_this6), "resetHeaderSort", function () {
                var headers = _this6.state.headers;
                headers.map(function (h) {
                    h.sorted = null;
                });
                console.log(headers);
            });

            _defineProperty(_assertThisInitialized(_this6), "setHeaderSortInfo", function (label, callback) {
                var headers = _this6.state.headers;

                var headerId = _this6.state.headers.findIndex(function (x) {
                    return x.label == label;
                });

                var sortValue = headers[headerId].sorted;
                headers.map(function (h) {
                    h.sorted = null;
                });
                headers[headerId].sorted = !sortValue;

                _this6.setState({
                    headers: headers
                }, function () {
                    _this6.sortJson(label, headers[headerId].sorted);

                    callback();
                });
            });

            return _this6;
        }

        _createClass(App, [{
            key: "componentDidMount",
            value: function componentDidMount() {
                this.sortJson('model', true);
            }
        }, {
            key: "render",
            value: function render() {
                return React.createElement("div", null, React.createElement(Form, {
                    onSomething: this.testAppMethod,
                    resetResults: this.resetResults,
                    formData: this.state.formData
                }), React.createElement(Table, {
                    headers: this.state.headers,
                    items: this.state.items,
                    fieldsToDisplay: this.state.fieldsToDisplay,
                    itemsLength: this.state.items.length,
                    onSort: this.sortJson,
                    onSetHeaderSortInfo: this.setHeaderSortInfo
                }));
            }
        }]);

        return App;
    }(React.Component);

var generateFieldsToDisplay = function generateFieldsToDisplay(headers) {
    var fieldsToDisplay = [];
    headers.map(function (h) {
        if (h.label !== 'documents') {
            fieldsToDisplay.push({
                label: h.label
            });
        }
    });
    return fieldsToDisplay;
};

if ($('#js--contentLister').length > 0) {
    var data = JSON.parse($('#js--contentLister').html());
    var processedHeaders = [];
    var sortbl = '';

    for (var key in data.headers) {
        sortbl = key === 'documents' ? false : true;
        processedHeaders.push({
            "label": key,
            "translation": data.headers[key],
            "sorted": null,
            "sortable": sortbl
        });
    }

    data.headers = processedHeaders;
    data.fieldsToDisplay = generateFieldsToDisplay(data.headers);
    ReactDOM.render(React.createElement(App, {
        data: data
    }), document.getElementById('root'));
}