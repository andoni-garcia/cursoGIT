/**
 * Ko component to create multiple step title
 * 
 * params
 * |-> currentStep - number of current step if is a incorrect number will revert to previous step
 * |-> config - configuration for css styles (Could be interesting to add styles inside elements or extract from root elements of every title)
 */
(function (globalKoUtils) {

    function MultiStepTitleNode(index, html) {
        this.index = index;
        this.html = html;
    }

    function MultiStepTitleViewModel(params, nodes) {
        var self = this;

        //Css classes for specific cases
        var firstElementClass = params.config.firstElementClass;
        var currentElementClass = params.config.currentElementClass;
        var nonCurrentElementClass = params.config.nonCurrentElementClass;
        var leftBorderElementClass = params.config.leftBorderElementClass;
        var rightBorderElementClass = params.config.rightBorderElementClass;

        // Incrementor for special conditions
        self.increment = params.increment || ko.observable(0);

        //Need to be an observable of integer number
        self.currentStep = params.currentStep;

        /**
         * Function to assign corresponding style of each element
         */
        self.titleStepsStyle = function (index) {
            let elementClasses = rightBorderElementClass;
            if (index + 1 !== 1) {
                elementClasses += ' ' + leftBorderElementClass;
            } else {
                elementClasses += ' ' + firstElementClass;
            }

            if(index + 1 === self.currentStep() + self.increment()) {
                elementClasses += ' ' + currentElementClass;
            } else {
                elementClasses += ' ' + nonCurrentElementClass;
            }
            return elementClasses;
        }

        self.getHtmlAtIndex = function(index) {
            return self.titles[index].html;
        }

        /**
         *
         * Private methods
         *
         */

        /**
         * Function to extract nodes
         */
        var extractSpansMstData = function(nodes) {
            var mstData = [];
            for(var i = 0; i < nodes.length; i++) {
                var currentNode = nodes[i];
                if(currentNode.nodeName === 'SPAN') {
                    var mstIndex = $(currentNode).data('mst');
                    var multiStepTitleNode = new MultiStepTitleNode(mstIndex, nodes[i].innerHTML);
                    mstData.push(multiStepTitleNode);
                }
            }
            return mstData.sort(compareIndex);
        }

        /**
         * Function to compare elements of array
         * @param a First element to compare
         * @param b Second element to compare
         */
        var compareIndex = function(a,b) {
            if (a.index < b.index)
                return -1;
            if (a.index > b.index)
                return 1;
            return 0;
        }

        //Titles extraction
        self.titles = extractSpansMstData(nodes);

        //Shared param with parent viewmodel --!!!! Observable integer
        self.sharedSteps = params.sharedSteps;
        self.sharedSteps(self.titles.length);

    }

    ko.components.register('smc-multi-step-title', {
        viewModel: {

            createViewModel: function(params, componentInfo) {
                return new MultiStepTitleViewModel(params, componentInfo.templateNodes);
            }

        },
        template: {
            name: 'smc-multi-step-title'
        }
    });

})(window.koUtils)