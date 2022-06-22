function WizardSimpleSpecialConfigPdf() {
    /** Pdf config */
    this.designerContact = ko.observable(true);
    this.customerContact = ko.observable(true);
    this.sellingPrice = ko.observable(true);
    this.listPrice = ko.observable(true);
    this.bom = ko.observable(true);
    this.leadTime = ko.observable(true);
    this.leadListPriceDetails = ko.observable(true);
}

WizardSimpleSpecialConfigPdf.prototype.getJsonObject = function() {
    return ko.toJSON(this);
}

function WizardSimpleSpecialConfigModel() {

    /** Files */
    this.havePdf = ko.observable(true);
    this.haveXls = ko.observable(true);
    this.haveCad = ko.observable(false);
    this.haveSyf = ko.observable(true);

}

function WizardSimpleSpecialViewModel(wizardSimpleSpecialModalId, totalPages) {
    var self = this;
    self.stepComponents = {};

    self.STEP_FILES_INITIAL = 4;
    self.STEP_FILES_PDF = 5;
    self.STEP_FILES_CAD = 6;
    self.STEP_NO_FILES_SELECTED = 7;
    self.STEP_LAST = 8;

    /**
     * Default config for multi step title
     */
    self.config = {
        firstElementClass: 'wss-title-first-element',
        currentElementClass: 'wss-title-current-step',
        nonCurrentElementClass: 'wss-title-non-current-step',
        leftBorderElementClass: 'wss-title-steps-left',
        rightBorderElementClass: 'wss-title-steps-right'
    };

    self.modalId = wizardSimpleSpecialModalId;
    self.minimunPage = ko.observable(1);
    self.currentPage = ko.observable(1);
    self.sharedSteps = ko.observable(1);
    self.disableBack = ko.observable(true);
    self.disableNext = ko.observable(true);
    self.disableMove = ko.observable(false);
    self.goingNext = ko.observable(false);
    self.goingBack = ko.observable(false);

    self.selectedFolderId = ko.observable(null);
    self.creatingNewFolder = ko.observable(null);
    self.saveFolder = ko.observable(false);

    self.simpleSpecial = ko.observable(null);
    self.simpleSpecialPartNumber = ko.observable(null);

    self.selectedCustomerNumber = ko.observable(null);
    self.selectedCustomerName = ko.observable(null);

    self.configFiles = new WizardSimpleSpecialConfigModel();
    self.pdfConfig = new WizardSimpleSpecialConfigPdf();
    self.noFile = ko.observable(false);

    self.generatingZipFile = ko.observable(true);
    self.selectedCadOption = ko.observable(null);

    self.versioningPermission = simpleSpecialVersioningPermission;
    self.versioningState = ko.observable(false);
    self.incrementor = ko.observable(0);

    // Without events
    self.goTo = function(page, checkDisable) {
        if(!self.disableMove()) {
            if(isOutOfRange(page)) {
                return;
            }

            self.currentPage(page);
            goToCurrentPage();
            if (checkDisable === undefined || checkDisable) {
                checkAfterMoveDisable();
            }
        }
    }

    self.generateNextEvent = function() {
        self.goingNext(true);
        self.goingNext(false);
    }

    self.generateBackEvent = function() {
        self.goingBack(true);
        self.goingBack(false);
    }

    self.skip = function() {
        self.disableMove(false);
        self.goToNext();7
    }

    self.skipFile = function() {
        self.disableMove(false);
        self.noFile(true);
        self.goTo(self.STEP_LAST, false);
    }

    self.goToNext = function () {
        self.goingNext(true);
        if(!self.disableMove()) {
            if (isLastPage()) {
                return;
            }

            self.currentPage(self.currentPage() + 1);
            goToCurrentPage();
            checkAfterMoveDisable();
        }
        self.goingNext(false);
    }

    self.goToPrev = function () {
        self.goingBack(true);
        if(!self.disableMove()) {
            if (isFirstPage()) {
                return;
            }

            self.currentPage(self.currentPage() - 1);
            goToCurrentPage();
            checkAfterMoveDisable();
        }
        self.goingBack(false);
    }

    self.showWizard = function () {
        $(self.modalId).modal({
            show: true,
            backdrop: 'static',
            keyboard: false
        });

        defaults();
    }

    self.closeWizard = function () {
        $(self.modalId).modal('hide');
    }

    self.goToPrevVersioning = function() {
        self.versioningState(false);
        self.incrementor(self.incrementor() - 1);
    }

    self.goToNextVersioning = function() {
        self.versioningState(true);
        self.incrementor(self.incrementor() + 1);
    }

    // Go next event from parentVm
    self.goingNext.subscribe(function(newValue) {

        if(newValue) {

            if(self.currentPage() >= self.STEP_FILES_INITIAL && self.currentPage() <= self.STEP_FILES_CAD) {

                let stepsToMove = 3;
                if(self.currentPage() == self.STEP_FILES_INITIAL) {
                    if(self.configFiles.havePdf() == true) {
                        stepsToMove -= 2;
                    } else if(self.configFiles.haveCad() == true) {
                        stepsToMove -= 1;
                    }
                } else if(self.currentPage() == self.STEP_FILES_PDF) {
                    if(self.configFiles.haveCad() == true) {
                        stepsToMove -= 1;
                    }
                }

                stepsToMove = self.STEP_FILES_INITIAL + stepsToMove;

                self.disableBack(false);

                self.goTo(stepsToMove, false);

            }

        }
    });

    self.goingBack.subscribe(function(newValue) {

        if(newValue) {

            if(self.currentPage() >= self.STEP_FILES_PDF && self.currentPage() <= self.STEP_NO_FILES_SELECTED) {

                let stepsToMove = 0;
                if(self.currentPage() == self.STEP_NO_FILES_SELECTED) {
                    stepsToMove = 0;
                    if(self.configFiles.haveCad() == true) {
                        stepsToMove += 2;
                    } else if(self.configFiles.havePdf() == true) {
                        stepsToMove += 1;
                    }
                } else if(self.currentPage() == self.STEP_FILES_CAD) {
                    stepsToMove = 0;
                    if(self.configFiles.havePdf() == true) {
                        stepsToMove += 1;
                    }
                }

                stepsToMove = self.STEP_FILES_INITIAL + stepsToMove;

                self.goTo(stepsToMove, false);

            }

        }

    });

    self.simpleSpecial.subscribe(function(newValue){
        if(typeof valveConfigurationViewModel !== 'undefined'){
            valveConfigurationViewModel.simpleSpecialCode(newValue);
        }
    });

    self.createFolder = function() {
        self.creatingNewFolder(true);
    }

    self.completeCreateFolder = function() {
        self.saveFolder(true);
    }

    self.cancelCreateFolder = function() {
        self.creatingNewFolder(false);
    }
    var checkAfterMoveDisable = function () {
        if (isFirstPage()) {
            self.disableBack(true);
        } else {
            if (isLastPage()) {
                self.disableNext(true);
            } else {
                self.disableBack(false);
                self.disableNext(false);
            }
        }

    }

    var isFirstPage = function () {
        return self.currentPage() === self.minimunPage();
    }

    var isOutOfRange = function(page) {
        return page < self.minimunPage() || page > self.sharedSteps();
    }

    var isLastPage = function () {
        return self.currentPage() === self.sharedSteps();
    }

    var goToCurrentPage = function () {
        $(self.modalId).trigger('next.m.' + self.currentPage());
    }

    $(self.modalId).on('hidden.bs.modal', function () {
        $(self.modalId).modal('hide');
        defaults();
    });

    var defaults = function () {
        self.creatingNewFolder(null);
        self.minimunPage(1);
        self.currentPage(1);
        self.disableBack(true);
        self.disableNext(true);
        self.disableMove(false);
        self.configFiles = new WizardSimpleSpecialConfigModel();
        self.generatingZipFile(true);
        self.noFile(false);
        self.versioningState(false);
        self.incrementor(0);
        childComponentsDefaults();
        goToCurrentPage();
        self.selectedFolderId(null);
    }

    var childComponentsDefaults = function() {
        for(var i = 1; i <= self.sharedSteps(); i++) {
            if (typeof self.stepComponents['step-' + i] !== 'undefined' &&
                typeof self.stepComponents['step-' + i].defaults !== 'undefined') {
                    self.stepComponents['step-' + i].defaults();
            }
        }
    }

}