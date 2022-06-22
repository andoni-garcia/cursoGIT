function OrderStatusRepository() {
    
    let self = this;

    self.doExportOrderStatus = function(fromDateTime, toDateTime, statusFrom, statusTo, searchBy, search, sortCol, type){
        return $.ajaxHippo({
            method: 'POST',
            url: orderStatusExportToXlsxUrl,
            async: true,
            data: {
                ko_filter_filterDateFrom: fromDateTime,
                ko_filter_filterDateTo: toDateTime,
                ko_filter_filterStatusFrom: statusFrom,
                ko_filter_filterStatusTo: statusTo,
                ko_filter_filterSearchBy: searchBy,
                ko_filter_filterValue: search,
                iSortCol_0: sortCol,
                type: type
            }
        });

    }
}