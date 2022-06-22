/**
 * Global common utils for Knockout
 *
 * Required $.datepicker defined and requestDateFormat var with current format defined ('dd/mm/yy' ...)
 *
 * @author Mikel Cano
 */
(function(globalKoDate){

    /**
     * Converts date string from Json format to dd/mm/yyyy
     * @param date
     */
    function hippoDateToJson(date) {

        return hippoDateConvertToJson(date, 'dd/mm/yyyy', 'yyyy-mm-dd', '/', '-');

    }

    /**
     * Converts date on string format from one format to other one
     * @param date String date to convert
     * @param format String origin format
     * @param toFormat String destination format
     * @param originSeparator Separator of origin string format
     * @param destSeparator Separator of destination format
     */
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

    /**
     * Parse Json format date to Date format
     * @param str Date to parse
     */
    function parseDateFromJson(str) {
        var mdy = str.split('-');
        return new Date(mdy[0], mdy[1]-1, mdy[2]);
    }

    /**
     * Returns number of days between dates
     * @param first First date
     * @param second Second date
     */
    function dateDaysDiff(first, second) {
        return Math.round((second-first)/(1000*60*60*24));
    }

    /**
     * Compares two dates with requestDateFormat
     * @param first First date to compare (formatted with requestDateFormat)
     * @param second Second date to compare (formatted with requestDateFormat)
     */
    function dateDaysDiffFormatted(first, second) {
        let date1 = requestDateFormatted(first);
        let date2 = requestDateFormatted(second);
        return dateDaysDiff(date1, date2);
    }

    /**
     * Converts formatted date as String to Date
     *
     * @param dateToConvert Date to convert
     */
    function requestDateFormatted(dateToConvert) {
        return $.datepicker.parseDate(requestDateFormat, dateToConvert);
    }

    /**
     * Convert Date to java format yy-mm-dd
     *
     * @param dateToConvert
     */
    function dateToJavaStringDate(dateToConvert) {
        return $.datepicker.formatDate("yy-mm-dd", dateToConvert);
    }

    /**
     * Converts request format date as String to yy-mm-dd String formatted date
     *
     * @param dateToConvert Date to convert
     */
    function requestDateStringFormatted(dateToConvert) {
        var date = requestDateFormatted(dateToConvert);
        return dateToJavaStringDate(date);
    }

    /**
     * Convert yy-mm-dd String formatted date to Date
     *
     * @param dateToConvert Date to convert
     */
    function requestDateToFormat(dateToConvert) {
        return $.datepicker.parseDate("yy-mm-dd", dateToConvert);
    }

    /**
     * Converts Date to request format date String
     *
     * @param dateToConvert
     */
    function dateToFormat(dateToConvert) {
        return $.datepicker.formatDate(requestDateFormat, dateToConvert);
    }

    /**
     * Converts yy-mm-dd String formatted date to request format date
     *
     * @param dateToConvert Date to convert
     */
    function requestDateStringToFormat(dateToConvert) {
        var date = requestDateToFormat(dateToConvert);
        return dateToFormat(date);
    }

    function requestDateObjectToFormat(date) {
        if (!date) return "";
        return requestDateStringToFormat(date[0] + "-" + date[1] + "-" + date[2]);
    }

    globalKoDate.koDate = {
        // DEPRECATED
        hippoDateToJson: hippoDateToJson,
        hippoDateConvertToJson: hippoDateConvertToJson,
        parseDateFromJson: parseDateFromJson,
        // END DEPRECATED
        dateDaysDiff: dateDaysDiff,
        dateDaysDiffFormatted: dateDaysDiffFormatted,
        requestDateFormatted: requestDateFormatted,
        dateToJavaStringDate: dateToJavaStringDate,
        requestDateStringFormatted: requestDateStringFormatted,
        requestDateToFormat: requestDateToFormat,
        dateToFormat: dateToFormat,
        requestDateStringToFormat: requestDateStringToFormat,
        requestDateObjectToFormat: requestDateObjectToFormat
    }

})(window)