<div class="row">
    <div class="col-md-6 mb-3">
        <label class="mb-0"><@fmt.message key="eshop.customerName"/>:</label><br>
        <label class="heading-09 mb-0">${currentDeliveryAddress.cusName}</label>
    </div>
    <div class="col-md-3 col-sm-6 mb-3">
        <label class="mb-0"><@fmt.message key="eshop.customerNumber"/>:</label><br>
        <label class="heading-09 mb-0">${currentDeliveryAddress.customerNumber}</label>
    </div>
    <div class="col-md-3 col-sm-6 mb-3">
        <label class="mb-0"><@fmt.message key="order.deliveryMethod"/>:</label><br>
        <label class="heading-09 mb-0">${currentDeliveryAddress.deliveryMethod}</label>
    </div>
    <div class="col-lg-6 col-sm-6 mb-3">
        <label class="mb-0 delivery-option" data-bind="click: selectDeliveryAddress"><i class="fas fa-edit"></i><@fmt.message key="users.deliveryAddress"/>:</label><br>
        <!-- ko if: selectedAddressData().loadedModel() == false -->
        <label class="heading-09 mb-0">${currentDeliveryAddress.cusName}</label><br>
        <#list currentDeliveryAddress.deliveryAddress as deliveryAddressElement>
        <#if deliveryAddressElement?index != 0 || deliveryAddressElement != currentDeliveryAddress.cusName>
        <label class="heading-09 mb-0">${deliveryAddressElement}</label>
        <#if currentDeliveryAddress.deliveryAddress?size!=deliveryAddressElement?index-1><br></#if>
        </#if>
        </#list>
        <!-- /ko -->
        <!-- ko if: selectedAddressData().loadedModel() == true -->
            <label class="heading-09 mb-0" data-bind="text: selectedAddressData().customerName()"></label><br>
            <!-- ko foreach: selectedAddressData().deliveryAddress() -->
            <label class="heading-09 mb-0" data-bind="text: $data"></label>
            <!-- ko if: $parent.selectedAddressData().deliveryAddress().length != $index()-1  -->
            <br>
            <!-- /ko -->
            <!-- /ko -->
        <!-- /ko -->
    </div>
</div>