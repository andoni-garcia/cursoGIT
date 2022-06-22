<div class="modal fade" id="modal-edit-mybaskets" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="mybaskets.editTitle"/></h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div id="error-dialog-edit" class="alert alert-danger m-2" hidden> </div>
            <div class="modal-body">
                
                <div class="col-12">
                    <div class="form-check">
                        <label class="form-check-label" for=""><@fmt.message key="mybaskets.description"/></label>
                        <input type="text" class="form-control" data-bind="value: $root.currentBasketDescription, valueUpdate: 'keyup'"/>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <label class="form-check-label" for=""><@fmt.message key="mybaskets.comments"/></label>
                        <input type="text" class="form-control" data-bind="value: $root.currentBasketComments, valueUpdate: 'keyup'"/>
                   </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" id="btn-return" class="btn  btn-danger" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                <button type="button" id="btn-submit" class="btn  btn-primary" data-dismiss="modal"><@fmt.message key="eshop.save"/></button>
            </div>
        </div>
    </div>
</div>