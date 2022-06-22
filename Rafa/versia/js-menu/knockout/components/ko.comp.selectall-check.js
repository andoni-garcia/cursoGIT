/**
 * Ko component to select all elements of list and un-select
 * -> Implements an standard behavior of select all component
 *
 * params
 * |-> list - Array of elements to check (observableArray)
 * |-> fiel - Field to check in every elements of array (observable boolean)
 */
(function (globalKoUtils) {

    function checkIfRegister() {
        var registered = false;
        if(typeof globalKoUtils != 'undefined' && globalKoUtils != null) {
            registerComponent();
            registered = true;
        }
        return registered;
    }

    function registerComponent() {
        ko.components.register('smc-select-all-check', {
            viewModel: function (params) {

                var self = this;
                var preventSubscribe = false;

                self.loaded = ko.observable(false);

                self.selectAll = ko.observable(false);

                //Need to be observableArray
                var listOfSelection = params.list;
                var previousListSize = listOfSelection().length;

                //Need to be boolean field and observable to detect changes
                var fieldForChecked = ko.observable(params.field);

                //Private functions

                /**
                 * Set all array items field to specified value
                 * @param value value to set all field of array
                 */
                var setSelecteds = function (value) {
                    for (var i = 0; i < listOfSelection().length; i++) {
                        listOfSelection()[i][fieldForChecked()](value);
                    }
                }

                /**
                 * Checks if all elements are selected
                 */
                var isAllSelected = function () {
                    if (listOfSelection().length === 0) {
                        return false;
                    }

                    var allChecked = true;
                    for (var i = 0; i < listOfSelection().length; i++) {
                        allChecked &= listOfSelection()[i][fieldForChecked()]();
                    }
                    return allChecked;
                }

                //Subscribers
                self.selectAll.subscribe(function (newValue) {
                    if (!preventSubscribe) {
                        setSelecteds(newValue);
                    }
                });

                listOfSelection.subscribe(function (newValue) {
                    if (newValue.length !== previousListSize) {
                        preventSubscribe = true;
                        self.selectAll(false);
                        preventSubscribe = false;
                        previousListSize = newValue.length;
                    }
                });


                //Init
                ko.computed(function () {

                    var listOfObservables = globalKoUtils.findObservablesInArray(listOfSelection(), fieldForChecked());
                    ko.toJS(listOfObservables);
                    preventSubscribe = true;
                    self.selectAll(isAllSelected());
                    preventSubscribe = false;

                }).extend({
                    notify: 'always'
                });

                self.loaded(true);
                console.log("smc-select-all-check");

            },
            template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
        });
    }

    var registered = checkIfRegister();
    if(!registered) {
        var componentDetectionInterval = setInterval(function(){
            registered = checkIfRegister();
            if(registered) {
                clearInterval(componentDetectionInterval);
            }
        }, 250);
    }

})(window.koUtils)