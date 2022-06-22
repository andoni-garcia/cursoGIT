function ProductsSolutionsFinderByApplicationViewModel() {
    //Self as 'this' reference
    var self = this;
    self.applicationGeneral = ko.observable();
    self.applicationDetail = ko.observable();
    self.applicationConditions = ko.observable();
    self.aplicationItems=ko.observableArray([]);
    self.isSummary=ko.observable();
    self.isSummary(false);
    self.handleApplication=function(model,e){
        console.log("event application",model);
        console.log("event application",$(e.currentTarget).attr("data-btn"));
        switch($(e.currentTarget).attr("data-target")){
            case '#collapseOne':
                self.applicationGeneral($(e.currentTarget).attr("data-btn"));
                 //$('#collapseOne').collapse('hide');
                 //$('#collapseTwo').collapse('show');
                setTimeout(function(){
                    $('#btn_collapseTwo').show();
                }, 400); 
                 setTimeout(function(){
                    $('#collapseTwo').collapse('show');
                }, 500);
                break;
            case '#collapseTwo':
                self.applicationDetail($(e.currentTarget).attr("data-btn"));
                 //$('#collapseOne').collapse('hide');
                 //$('#collapseTwo').collapse('show');
                setTimeout(function(){
                    $('#btn_collapseThree').show();
                }, 400); 
                setTimeout(function(){
                    $('#collapseThree').collapse('show');
                }, 500);
                break;
            case '#collapseThree':
                self.applicationConditions($(e.currentTarget).attr("data-btn"));
                setTimeout(function(){
                    $('#container_additionalParameters').fadeIn("slow");
                    $('html,body').animate({
                        scrollTop:$('#container_additionalParameters').offset().top-135
                    }, 1000);
                }, 700);
                break;
        }
    };
    self.handleBestItems=function(){
       $('.selectpicker').selectpicker('toggle');
        $('#container_bestItems').fadeIn("slow");
        $('html,body').animate({
                scrollTop:$('#container_bestItems').offset().top-135
            }, 1000);
    };
    self.handleItemAdapted=function(model,e){
        var itemsAdapted=[]
        switch($(e.currentTarget).attr("data-btn")){
            case 'A':
                self.isSummary(false);
                itemsAdapted=[
                        {
                            "partNumber":"AFF8C-F04D-T",
                            "description":"Main line filter with N.O. auto-drain",
                            "price":"161,10 €",
                            "delivery":"In stock",
                            "image":"http://content2.smcetech.com/image/medium/6001A.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":false
                        },
                        {
                            "partNumber":"AFF8C-F04-T",
                            "description":"Main line filter",
                            "price":"128,27 €",
                            "delivery":"15 days",
                            "image":"http://content2.smcetech.com/image/medium/6001A.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":true
                        }
                ];
                self.aplicationItems(itemsAdapted);
                break;
            case 'B':
                self.isSummary(false);
                itemsAdapted=[
                        {
                            "partNumber":"IDFA11E-23-K",
                            "description":"Refrigerated air dryer with autodrain bowl",
                            "price":"1304,91 €",
                            "delivery":"In stock",
                            "image":"http://content2.smcetech.com/image/medium/6011Em.jpg",
                            "type":"B",
                            "summary":0,
                            "isDisabled":false
                        },
                        {
                            "partNumber":"IDFA11E-23",
                            "description":"Refrigerated air dryer",
                            "price":"1238,07 €",
                            "delivery":"3 days",
                            "image":"http://content2.smcetech.com/image/medium/6011Em.jpg",
                            "type":"B",
                            "summary":0,
                            "isDisabled":true
                        }
                ];
                self.aplicationItems([]);
                self.aplicationItems(itemsAdapted);
                break;
            case 'C':
                self.isSummary(false);
                itemsAdapted=[
                        {
                            "partNumber":"AM350C-F04D-T",
                            "description":"Mist separator with N.O. auto-drain",
                            "price":"150,06 €",
                            "delivery":"3 days",
                            "image":"http://content2.smcetech.com/image/medium/6002A.jpg",
                            "type":"C",
                            "summary":0,
                            "isDisabled":false
                        },
                        {
                            "partNumber":"AM350C-F04-T",
                            "description":"Mist separator",
                            "price":"119,98 €",
                            "delivery":"3 days",
                            "image":"http://content2.smcetech.com/image/medium/6002A.jpg",
                            "type":"C",
                            "summary":0,
                            "isDisabled":true
                        }
                ];
                self.aplicationItems([]);
                self.aplicationItems(itemsAdapted);
                break;
        }
    };
    self.handleCheckboxItem = function (e,item) {
        var checkboxes = $('#spares-accessories-result-container').find(':checkbox');
        //checkboxes.prop('checked', $(this).is(':checked'));
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                switch(e.type){
                    case "A":
                        $('#check--a').show(300);
                        break;
                    case "B":
                        $('#check--b').show(300);
                        break;
                    case "C":
                        $('#check--c').show(300);
                        $( "#btn_disabled" ).prop( "disabled", false );
                        break;
                }
                break;
            }
        }
        return true;
    };
    self.handleSummary=function(){
        var itemsAdapted=[];
        self.isSummary(true);
        itemsAdapted=[
            {
                "partNumber":"AFF8C-F04D-T",
                "description":"Main line filter with N.O. auto-drain",
                "price":"161,10 €",
                "delivery":"In stock",
                "image":"http://content2.smcetech.com/image/medium/6001A.jpg",
                "summary":1,
                "isDisabled":false
            },
            {
                "partNumber":"IDFA11E-23-K",
                "description":"Refrigerated air dryer with autodrain bowl",
                "price":"1304,91 €",
                "delivery":"In stock",
                "image":"http://content2.smcetech.com/image/medium/6011Em.jpg",
                "summary":2,
                "isDisabled":false
            },
            {
                "partNumber":"AM350C-F04D-T",
                "description":"Mist separator with N.O. auto-drain",
                "price":"150,06 €",
                "delivery":"3 days",
                "image":"http://content2.smcetech.com/image/medium/6002A.jpg",
                "summary":3,
                "isDisabled":false
            }
        ];
        self.aplicationItems(itemsAdapted);
        $("#btn_disabled_dowload").prop( "disabled", false );
    }
}
(function (window) {
    var vmpsf = new ProductsSolutionsFinderByApplicationViewModel();
    ko.applyBindings(vmpsf, document.getElementById("psfApplicationcontenedor"));
}(window));