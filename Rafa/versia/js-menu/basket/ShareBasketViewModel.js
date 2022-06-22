function ShareBasketViewModel() {

    let self = this;

    const StepsEnum = {

        SAVE_PAGE: 0,
        CONTACT_PAGE: 1,
        SEND_PAGE: 2,
        END_PAGE: 3

    };


    const BASKET_REPO = new BasketProductRepository();
    let modal = $('#modal-share-baskets');

    //Observables
    self.loading = ko.observable(false);
    self.nextPageAvailable = ko.observable(true);
    self.prevPageAvailable = ko.observable(false);
    self.currentPage = ko.observable(StepsEnum.SAVE_PAGE);
    self.modalTitle = ko.observable(SHARE_MESSAGES.title1);

    self.myBasketId = ko.observable(0);
    self.myBasketDescription = ko.observable('');
    self.myBasketComments = ko.observable('');
    self.contacts = ko.observable([]);
    self.selectedContact = ko.observable({});
    self.shareBasketDescription = ko.observable('');
    self.shareBasketComments = ko.observable('');

    self.init = function (savedBasket) {
        clear();
        
        if(savedBasket){
            self.loading(true);
            self.myBasketDescription(savedBasket.description());
            self.myBasketComments(savedBasket.comments());
            self.myBasketId(savedBasket.id());
            self.currentPage(StepsEnum.CONTACT_PAGE);
            loadContacts();
        } else{
            self.currentPage(StepsEnum.SAVE_PAGE);
        }

        modal.modal('show');
    }

    self.nextPage = function () {
        switch (self.currentPage()) {
            case StepsEnum.SAVE_PAGE:
                return saveCurrentBasket()
            case StepsEnum.CONTACT_PAGE:
                return goToSendStep()
            case StepsEnum.SEND_PAGE:
                return sendBasket();
            case StepsEnum.END_PAGE:
                return end();
        }
    }

    const saveCurrentBasket = function(){
        
        if(basketViewModel.products().length === 0){
            return smc.NotifyComponent.error(SHARE_MESSAGES.basketEmpty);
        }

        if(self.myBasketDescription() === ''){
            return smc.NotifyComponent.error(SHARE_MESSAGES.descriptionCannotBeEmpty);
        }
        self.loading(true);
        BASKET_REPO.doSaveBasket(self.myBasketDescription(), self.myBasketComments())
            .then(function(res){
                self.myBasketId(res.id);
                self.modalTitle(SHARE_MESSAGES.title2);
            })
            .then(loadContacts)
            .catch(function(){
                return smc.NotifyComponent.error(SHARE_MESSAGES.errorSavingBasket);
            });

    }

    self.selectContact = function(contact){
        if(self.selectedContact() && self.selectedContact().id === contact.id) {
            self.selectedContact({});
        } else {
            self.selectedContact(contact);
        }
    }

    self.close = function(){
        modal.modal('hide');
    }

    const sendBasket = function(){

        if(!self.shareBasketDescription() || self.shareBasketDescription() === '') {
            return smc.NotifyComponent.error(SHARE_MESSAGES.descriptionCannotBeEmpty);
        }

        self.modalTitle(SHARE_MESSAGES.title4);
        return updatePage(StepsEnum.END_PAGE);

    }

    const goToSendStep = function(){

        if(!self.selectedContact() || !self.selectedContact().id){
            return smc.NotifyComponent.error(SHARE_MESSAGES.contactNotSelected);
        }

        self.modalTitle(SHARE_MESSAGES.title3);
        updatePage(StepsEnum.SEND_PAGE);
    }

    const loadContacts = function () {
        return BASKET_REPO.doLoadContacts()
            .then(function(contacts){
                self.loading(false);
                self.contacts(parseContacts(contacts));
                return updatePage(StepsEnum.CONTACT_PAGE);
            })
    }

    const parseContacts = function(contacts){
        return _.map(contacts, function(contact){
            let company;
            if(contact.userAtt && contact.userAtt[0]){
                company = contact.userAtt[0].value;
            }
            return $.extend(contact, {company : company});
        })
    }

    const end = function () {
        
        BASKET_REPO.doSendBasket(self.myBasketId(), self.selectedContact().id, self.shareBasketDescription(), self.shareBasketComments())
            .then(function(){
                smc.NotifyComponent.info(SHARE_MESSAGES.successShare);
                modal.modal('hide');
            })
            .catch(function(err){
                console.error(err);
                modal.modal('hide');
                return smc.NotifyComponent.error(SHARE_MESSAGES.errorShare);

            })
        
    }

    const updatePage = function (nextPage) {
        self.currentPage(nextPage);
        self.nextPageAvailable(hasNext());
    }


    const hasNext = function () {
        return self.currentPage() < StepsEnum.END_PAGE;
    }

    const clear = function(){
        self.loading(false);
        self.nextPageAvailable(true);
        self.prevPageAvailable(false);
        self.currentPage(StepsEnum.SAVE_PAGE);

        self.myBasketId(0);
        self.myBasketDescription('');
        self.myBasketComments('');
        self.contacts([]);
        self.selectedContact({});
        self.shareBasketDescription('');
        self.shareBasketComments('');
    }
}