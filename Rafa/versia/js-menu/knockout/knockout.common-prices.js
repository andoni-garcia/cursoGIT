/**
 * Global common utils for Knockout
 * @author Mikel Cano
 */
(function(globalKoPrices){

    function convertDoubleToStringI18n(price, language) {

        if(!language) {
            language = 'en';
        }

        return price.toLocaleString(language, { maximumSignificantDigits: 2 });
    
    }
    
    globalKoPrices.koPrices = {
        convertDoubleToStringI18n: convertDoubleToStringI18n
    }

})(window)