<div class="modal fade ask-smc-modal" id="${componentId}_askSMCModal" tabindex="-1" role="dialog" aria-labelledby="${componentId}_askSMCModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="${componentId}_askSMCModalTitle">${askSmcAboutLbl}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <#include "../../include/spinner.ftl">
                <iframe src="${iframeSrc}" width="100%" height="100%" frameBorder="0" class="hidden">${browserNotCompatibleLbl}</iframe>
            </div>
        </div>
    </div>
</div>
