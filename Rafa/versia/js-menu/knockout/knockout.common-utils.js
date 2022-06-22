/**
 * Global common utils for Knockout
 * @author Mikel Cano
 */
(function(globalKoUtils){

    /**
     * Returns array of observable fields of object
     * @param element object to analize
     * @param fieldname name of field to check in object
     */
    function findAllObservableFields(element, fieldname) {
        return findAllObservableFieldsByFieldname(element, fieldname);
    }

    /**
     * Returns array of observable fields of object searching field by fieldname
     * @param element object to analize
     * @param fieldname name of field to check in object
     * @param deepsearch enables deep search for fields
     * @param fieldsToIgnore array of fields to ignore (Important to prevent looping references)
     */
    function findAllObservableFieldsByFieldname(element, fieldname, deepsearch, fieldsToIgnore) {
        var observables = [];
        for(var i in element) {
            if(element.hasOwnProperty(i)){
                if(ko.isObservable(element[i]) && (!fieldname || (fieldname && i === fieldname))) {
                    observables.push(element[i]);
                }

                var isIgnoredField = false;
                if(fieldsToIgnore) {
                    isIgnoredField = fieldsToIgnore.indexOf(i) > -1;
                }

                if(deepsearch && !isIgnoredField && (!ko.isObservable(element[i]) || (ko.isObservable(element[i]) && element[i].length) ) ) {
                    var recursiveObservables = findAllObservableFieldsByFieldname(element[i], fieldname, deepsearch);
                    observables = observables.concat(recursiveObservables);
                }
            }
        }
        return observables;
    }

    /**
     * Returns all observables inside every element of array
     * @param elements array of elements to analize
     * @param fieldname name of field to check in every object
     */
    function findObservablesInArray(elements, fieldname) {
        return findObservablesByFieldNameInArray(elements, fieldname);
    }

    /**
     * Returns all observables inside every element of array by field name
     * @param elements array of elements to analize
     * @param fieldname name of field to check in every object
     * @param deepsearch enables deep search for fields
     * @param fieldsToIgnore array of fields to ignore (Important to prevent looping references)
     */
    function findObservablesByFieldNameInArray(elements, fieldname, deepsearch, fieldsToIgnore) {
        var observables = [];
        for(var i = 0; i < elements.length; i++) {
            observables = observables.concat(findAllObservableFieldsByFieldname(elements[i], fieldname, deepsearch, fieldsToIgnore));
        }
        return observables;
    }

    function compareObjects(object1, object2) {
        if(!object1 || !object2) return [];
        return Object.keys(object1).filter( function(k) { return object1[k] !== object2[k] });
    }

    function equalsObjects(object1, object2) {
        console.log("[koUtils] equalsObjects");
        if(!object1 || !object2) return false;
        console.log("[koUtils] equalsObjects comparing");
        console.log("[koUtils] comparation " + compareObjects(object1, object2).length);
        return compareObjects(object1, object2).length === 0;
    }

    function arrayMove(arr, old_index, new_index) {
        if (new_index >= arr.length) {
            var k = new_index - arr.length + 1;
            while (k--) {
                arr.push(undefined);
            }
        }
        arr.splice(new_index, 0, arr.splice(old_index, 1)[0]);
        return arr; // for testing
    }

    function extractLanguageUrl(path) {

        var regex = /\/[A-Za-z]{2}-[A-Za-z]{2}([\/|]{1})*/g;
        var group = regex.exec(path)
        var result = '';
        if(group && group.length > 0) {
            result = group[0].replace(/\//g,"");
        }
        return result
    }

    function getUrlWithLanguage() {
        var path = location.pathname;
        var language = extractLanguageUrl(path);
        var partialPath = '';

        var previousSubPath = '';
        if (language !== '') {
            var split = path.split(language);
            if (split.length > 1) {
                previousSubPath = split[0];
            }
        }

        if (partialPath === '' && previousSubPath === '') {
            partialPath = '/';
        }

        if (language !== '') {
            partialPath += previousSubPath + language;
        }

        var index = partialPath.lastIndexOf("/");
        if(index !== -1 && index === partialPath.length-1) {
            partialPath = partialPath.substring(0, index);
        }
        return partialPath;
    }

    globalKoUtils.koUtils = {
        findAllObservableFields: findAllObservableFields,
        findAllObservableFieldsByFieldname: findAllObservableFieldsByFieldname,
        findObservablesInArray: findObservablesInArray,
        findObservablesByFieldNameInArray: findObservablesByFieldNameInArray,
        compareObjects: compareObjects,
        equalsObjects: equalsObjects,
        getUrlWithLanguage: getUrlWithLanguage,
        arrayMove: arrayMove
    }

})(window)