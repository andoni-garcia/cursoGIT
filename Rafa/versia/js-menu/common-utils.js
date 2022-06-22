//SPLIT DETAILS
function slicePartnumberDetails(partnumberDetails) {

    var result = [null, null];

    partnumberDetails = (partnumberDetails || '').split(';');

    if (typeof partnumberDetails !== 'undefined' && partnumberDetails != null && partnumberDetails.length > 0) {
        var slicePosition = Math.floor(partnumberDetails.length / 2) + (partnumberDetails.length % 2);
        result[0] = partnumberDetails.slice(0, slicePosition);
        result[1] = partnumberDetails.slice(slicePosition, partnumberDetails.length);
    }

    return result;

}

function splitString(data, separator, part, includeSep){
    var value = typeof data !== 'undefined' && data != null ? data.split(separator)[part] : '';
    if(includeSep) value += separator;
    return value;
};

//COPY Array without copy of elements
function copyArray(arr) {
    var arrCpy = [];
    for(var i=0; i<arr.length; i++) {
        arrCpy.push(arr[i]);
    }
    return arrCpy;
}

//Converts a array of objects taking one field of each objects to simple array with that field
function convertComplexArrayToSimpleArray(cmpxArray, indexField) {
    return cmpxArray.map(function(object) { return object[indexField]; });
}

Object.byString = function(o, s) {
    s = s.replace(/\[(\w+)\]/g, '.$1'); // convert indexes to properties
    s = s.replace(/^\./, '');           // strip a leading dot
    var a = s.split('.');
    for (var i = 0, n = a.length; i < n; ++i) {
        var k = a[i];
        if (k in o) {
            o = o[k];
        } else {
            return;
        }
    }
    return o;
}

//Date from JSON to dd/mm/yyyy
function hippoConvertJsonDateTo(jsonDate, format, separator) {

    var value = '';
    if(!jsonDate || !format) return value;
    if(!separator) separator = '/';

    var dateArr = jsonDate.split('-');
    var formatComps = [];
    if(format.indexOf('-') != -1) formatComps = format.split('-');
    if(format.indexOf('/') != -1) formatComps = format.split('/');

    for(var i=0; i<format.length; i++){
        if(formatComps[i] === 'yyyy' || formatComps[i] === 'yy'){
            value += dateArr[0];
        } else if(formatComps[i] === 'mm' || formatComps[i] === 'm') {
            value += dateArr[1];
        } else if(formatComps[i] === 'dd' || formatComps[i] === 'd') {
            value += dateArr[2];
        }
        if(i<2) value += separator;
    }

    return value;

}

function hippoDateToJson(date) {

    return hippoDateConvertToJson(date, 'dd/mm/yyyy', 'yyyy-mm-dd', '/', '-');

}

function hippoDateConvertToJson(date, format, toFormat, originSeparator, destSeparator) {

    var value = '';
    if(!date || !format) return value;
    if(!originSeparator) originSeparator = '/';
    if(!destSeparator) destSeparator = '-';

    var fromFormatComps = [];
    if(format.indexOf(originSeparator) != -1) {
        fromFormatComps = format.split(originSeparator);
    } else {
        return value;
    }

    var toFormatComps = [];
    if(toFormat.indexOf(destSeparator) != -1) {
        toFormatComps = toFormat.split(destSeparator);
    } else {
        return value;
    }

    if(fromFormatComps.length !== 3 || toFormatComps.length !== 3) {
        return value;
    }

    var originDateArr = date.split(originSeparator);
    var formatComps = new Array(3);
    var convertedTemp = '';
    for(var i=0; i<fromFormatComps.length; i++) {
        var j;
        if(fromFormatComps[i] === 'yyyy' || fromFormatComps[i] === 'yy'){
            j=0;
        } else if(fromFormatComps[i] === 'mm' || fromFormatComps[i] === 'm') {
            j=1
        } else if(fromFormatComps[i] === 'dd' || fromFormatComps[i] === 'd') {
            j=2;
        }
        formatComps[j] = fromFormatComps[i];
        convertedTemp += originDateArr[j];
        if(i<2) convertedTemp += '-';
    }

    var convertedDateArr = convertedTemp.split('-');
    var value = '';
    for(var i=0; i<convertedDateArr.length; i++){
        if(toFormatComps[i] === 'yyyy' || toFormatComps[i] === 'yy'){
            value += convertedDateArr[0];
        } else if(toFormatComps[i] === 'mm' || toFormatComps[i] === 'm') {
            value += convertedDateArr[1];
        } else if(toFormatComps[i] === 'dd' || toFormatComps[i] === 'd') {
            value += convertedDateArr[2];
        }
        if(i<2) value += destSeparator;
    }

    return value;

}