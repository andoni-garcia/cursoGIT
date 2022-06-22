  <!-- modal to delete user-->
<div class="modal fade" id="modal-delete" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="users.deleteUser"/></h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div id="error-delete-dialog" class="alert alert-danger m-2" hidden> </div>
            <div class="modal-body">
                <span><@fmt.message key="users.deleteMssg"/></span>

            </div>
            <div class="modal-footer">
                <button type="button" id="btn-return" class="btn" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                <button type="button btn-danger" id="btn-submit" class="btn" data-dismiss="modal"><@fmt.message key="eshop.delete"/></button>
            </div>
        </div>
    </div>
</div></div>