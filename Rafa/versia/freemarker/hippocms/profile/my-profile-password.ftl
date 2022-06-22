  <!-- modal to update password -->
<div class="modal fade" id="modal-password" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="users.updatePasswordTitle"/></h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div id="error-update-dialog" class="alert alert-danger m-2" hidden> </div>
            <div class="modal-body">
                <div class="col-12">
                    <div class="form-check">
                        <label class="form-check-label"><@fmt.message key="users.password"/>:</label>
                        <input class="form-control" id="updatePwd" type="password" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,20}$" data-bind="value: $root.updatePassword, valueUpdate: 'keyup'"/>
                        <span class="form-validation" style="display: inline"><@fmt.message key="users.regexMssg"/></span> 

                    </div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <label class="form-check-label"><@fmt.message key="users.repeatPassword"/>:</label>
                        <input class="form-control" id="updatePwdRepeat" type="password" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,20}$" data-bind="value: $root.updatePasswordRepeat, valueUpdate: 'keyup'"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="btn-return" class="btn" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                <button type="button" id="btn-submit" class="btn btn-primary" data-dismiss="modal"><@fmt.message key="eshop.update"/></button>
            </div>
        </div>
    </div>
</div>