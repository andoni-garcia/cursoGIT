
<@fmt.message key="basket.importModal.completeMessage" var="completeMessage"/>

<#if  completeMessage?has_content && !completeMessage?contains('???')>
<p>${completeMessage}</p>
</#if>
<table class="table">
<thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col"><@fmt.message key="eshop.partnumber"/></th>
      <th scope="col"><@fmt.message key="eshop.customerPartNumber"/></th>
      <th scope="col"></th>
    </tr>
  </thead>

<tbody>

<!-- ko foreach: emptyPartNumberProducts    -->
    <tr>
        <th style="width: 8.33%" class="col-md-1" scope="row" data-bind="text: $index"></th>
        <td style="width: 41.66%">
            <input  class="form-control" data-bind="attr: {'data-bind': ''}, value: partNumber, valueUpdate: 'afterkeydown', event: { blur: $root.checkAlias, keyup: $root.checkAlias }" placeholder="" >
        
            
        </td>
        <td class="text-dark description" style="width: 41.66%">
            <span data-bind="text: customerPartNumber"> </span>
        </td>
        <td style="width: 16.66%">
             <i class="fa fa-trash pointer btn btn-danger" data-bind="click: $root.removeProduct.bind($data)"></i>
        </td>
    </tr>
    <!-- ko if: !valid -->
    <tr>
        <td colspan="4" class="import-row text-danger import-complete--error">
                <i class="fa fa-times text-danger pointer mr-1" ></i>
                <!-- ko if: status === 'INTERNAL_SERVER_ERROR'-->
                    <span><@fmt.message key="basket.importModal.internalError"/></span>
                <!-- /ko -->
                <!-- ko if: status === 'INVALID_PARTNUMBER_ERROR'-->
                    <span><@fmt.message key="basket.importModal.invalidPartNumber"/> </span>
                <!-- /ko -->
                <!-- ko if: status === 'ALIAS_IN_USE_ERROR'-->
                    <span><@fmt.message key="basket.importModal.aliasInUse"/></span>
                <!-- /ko -->
                <!-- ko if: status === 'PARTNUMBER_IN_USE_ERROR'-->
                    <span><@fmt.message key="basket.importModal.partNumberInUse"/></span>
                <!-- /ko -->
                <!-- ko if: status === 'INVALID_PARAMS_ERROR'-->
                    <span><@fmt.message key="basket.importModal.invalidParameters"/></span>
                <!-- /ko -->
                <!-- ko if: status === 'ALREADY_EXISTS'-->
                    <span><@fmt.message key="basket.importModal.alreadyExists"/></span>
                <!-- /ko -->
        </td>
    </tr>
        <!-- /ko -->

<!-- /ko -->
</tbody>
</table>