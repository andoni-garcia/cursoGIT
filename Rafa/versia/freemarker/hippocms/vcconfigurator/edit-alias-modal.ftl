<div class="modal fade" id="modal-edit-alias" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="editAlias"/></h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div id="error-dialog-save" class="alert alert-danger m-2 modal-message" hidden> </div>
            <div class="modal-body">
                <!-- <smc-spinner-inside-element params="loading: loading"></smc-spinner-inside-element> -->
                <div class="mb-3 is-valid">
                    <label for="company"><@fmt.message key="simpleSpecial.reference"/></label>                                
                    <input type="text" class="form-control " id="vcSSReference" readonly>
                </div>
                <div class="mb-3 is-valid">
                    <label for="company"><@fmt.message key="customer.code"/></label>                                
                    <input type="text" class="form-control " id="vcCustomerCodeInput" readonly>
                </div>
                <div class="mb-3 is-valid">
                    <label for="company"><@fmt.message key="customer.name"/></label>                                
                    <input type="text" class="form-control " id="vcCustomerNameInput" readonly>
                </div>
                <div class="mb-3 is-valid">
                    <label for="company"><@fmt.message key="simpleSpecial.alias"/></label>                                
                    <input type="text" class="form-control " id="vcAliasInput" placeholder="Alias" required>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button btn-danger"  class="btn btn-primary" id="aliasModalAcceptBtn"><@fmt.message key="modal.contact.confirm"/></button>
                <button type="button btn-danger"  class="btn btn-danger" id="aliasModalCancelBtn" ><@fmt.message key="modal.contact.cancel"/></button>
            </div>
        </div>
    </div>
</div>