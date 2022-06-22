<div class="modal fade" id="modal-cad" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Download CAD</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div id="error-dialog-import" class="alert alert-danger m-2" hidden> </div>
            <div class="modal-body">
                <div class="row">
                    <!-- ko foreach: cadOptions    -->
                    <div class="col-6">
                        <span data-bind="text: $data.name"></span>
                        <ul >
                            <!-- ko foreach: $data.options    -->
                                <li>
                                    <input type="radio" name="cad" data-bind="value: $data.key, attr: { id: $data.key }" />
                                    <label data-bind="text: $data.value, attr: { for: $data.key }"></label>
                                </li>
                            <!-- /ko -->
                        </ul>
                    </div>
                    <!-- /ko -->
                    
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="btn-return" class="btn mb-1" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                <button type="button" id="btn-primary" class="btn mb-1" data-bind="click: downloadCadFile.bind($data)">Download file</button>

            </div>
        </div>
    </div>
</div>