function WizardSimpleSpecialRepository() {
    var self = this;

    ko.di.require({
        jq: "jQuery"
    }, self);

    self.doGetCustomers = function (customerNumberParam, customerNameParam, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: wssGetCustomersUrl,
            dataType: 'json',
            data: {
                customerNumber: customerNumberParam,
                customerName: customerNameParam
            },
            async: true,
        }, callbacks));

    }

    self.doCreateSimpleSpecial = function (customerNumberParam, customerNameParam, simpleSpecialPartNumber, syImageDataParam, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: wssCreateSimpleSpecialUrl,
            dataType: 'json',
            data: {
                customerNumber: customerNumberParam,
                customerName: customerNameParam,
                zspn: simpleSpecialPartNumber,
                syImage: syImageDataParam
            },
            async: true,
        }, callbacks));

    }

    self.doSendToFavourites = function (folderIdParam, syImageData, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: wssSendToFavouritesUrl,
            dataType: 'json',
            data: {
                folderId: folderIdParam,
                syImage: syImageData
            },
            async: true,
        }, callbacks));

    }

    self.doGenerateZip = function (fileOptions, pdfOptions, cadOptions, syImageData, callbacks) {

        let sendObj = {
            haveCad: fileOptions.haveCad(),
            havePdf: fileOptions.havePdf(),
            haveSyf: fileOptions.haveSyf(),
            haveXls: fileOptions.haveXls()
        }

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: wssGenerateZipUrl,
            dataType: 'json',
            data: {
                filesActivatedOptions: JSON.stringify(sendObj),
                pdfFileOptions: pdfOptions,
                syImage: syImageData,
                selectedCadOption: cadOptions.selectedCadOption,
                partNumber: cadOptions.partNumber
            },
            async: true,
        }, callbacks));

    }

    self.doGetCadOptions = function (callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: wssGetCadOptions,
            dataType: 'json',
            async: true
        }, callbacks));

    }

    self.doGetVersioning = function (simpleSpecialPartnumber, simpleSpecialCustomerNumber, callbacks) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: wssGetVersion,
            dataType: 'json',
            data: {
                partNumber: simpleSpecialPartnumber,
                customerNumber: simpleSpecialCustomerNumber
            },
            async: true
        }, callbacks));
    }

}