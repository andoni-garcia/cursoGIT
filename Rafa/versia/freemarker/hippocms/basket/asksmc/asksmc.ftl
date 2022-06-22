<div class="modal fade" id="ask-smc-modal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4><@fmt.message key="eshop.askSmc"/></h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col"><@fmt.message key="eshop.partnumber"/></th>
                            <th scope="col"><@fmt.message key="eshop.productDescription"/></th>
                            <th scope="col"><@fmt.message key="eshop.qty"/></th>
                            <th scope="col"><@fmt.message key="eshop.days"/></th>
                            <#if showListPrice><th scope="col"><@fmt.message key="eshop.listPrice"/></th></#if>
                            <#if showNetPrice><th scope="col"><@fmt.message key="eshop.netPrice"/></th></#if>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- ko foreach: getEntireSelected() -->
                        <tr>
                            <th rowspan="2" scope="row" data-bind="text: partnumber"></th>
                            <td data-bind="text: name"></td>
                            <td data-bind="text: quantity"></td>
                            <td data-bind="text: toPreferredDeliveryDateDays"></td>
                            <#if showListPrice><td data-bind="text: totalListPrice"></td></#if>
                            <#if showNetPrice><td data-bind="text: totalNetPrice"></td></#if>
                        </tr>
                        <tr>
                            <td colspan="5"><input type="text" class="form-control w-100" data-bind="value: askSmcObservation, valueUpdate: 'afterkeydown'"/></td>
                        </tr>
                        <!-- /ko -->
                        <tr>
                            <td colspan="6">
                                <textarea class="form-control w-100 noresize" name="ask_smc_note" id="ask_smc_note" cols="80" rows="3" data-bind="value: $root.askToSmcGeneralInput, valueUpdate: 'afterkeydown'"></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" id="btn-asksmc-modal-cancel" class="btn btn-secondary" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                <button type="button" id="btn-asksmc-modal-send" class="btn btn-primary" data-bind="click: $root.askSmc.bind($data)"><@fmt.message key="eshop.send"/></button>
            </div>
        </div>
    </div>
</div>