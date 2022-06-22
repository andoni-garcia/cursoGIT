<#include "../../../../include/imports.ftl">
<@hst.setBundle basename="CylinderConfigurator"/>
<#list customers as customer>
    <label class="row sscw__customer__register smc-checkbox" for="accessory_customer_${customer?index}">
        <div class="col-12 col-lg-3 sscw__customer__register_content" data-field-title="<@fmt.message key="cylinderConfigurator.customerNumber"/>">
            <span  class="sscw__customer__register_value" value ="${customer.getCode()}">
                <input onchange="javascript:enableNextButton();" name = "accesory_customerName" id="accessory_customer_${customer?index}" currentIndex="${customer?index}" customerId = "${customer.getCustomerNumber()}"  customerName ="${customer.getCustomerName()}" customerPostalCode = "${customer.getPostalCode()}" type="radio" class="radio sscw__radio sscw__customer_selection_radio" value="${customer.getCode()}">
                <strong class="smc-checkbox__label pl-5" id = "accessory_customerNumber_text_${customer?index}" >${customer.getCustomerNumber()}</strong>
            </span>
        </div>
        <div class="col-12 col-lg-4 sscw__customer__register_content" data-field-title="<@fmt.message key="cylinderConfigurator.customerName"/>">
            <div class=" sscw__customer__register_value" id = "accessory_customerName_text_${customer?index}" >${customer.getCustomerName()}</div>
        </div>
        <div class="col-12 col-lg-4 sscw__customer__register_content" data-field-title="<@fmt.message key="cylinderConfigurator.customerAddress"/>">
            <div class=" sscw__customer__register_value" id = "accessory_customerAddress_text_${customer?index}" >
                <div id = "accessory_customerAddress_text_${customer?index}_complete" class="sscw__customer__register_value_address">
                    <#if (customer.getCustomerAddress1()?? && customer.getCustomerAddress1() != "") && (customer.getCustomerAddress2()?? && customer.getCustomerAddress2() != "") >
                        <span class="part1">
                            ${customer.getCustomerAddress1()+", "+customer.getCustomerAddress2()}
                        </span>
                    <#elseif customer.getCustomerAddress1()?? && customer.getCustomerAddress1() != "" >
                        <span class="part1">
                            ${customer.getCustomerAddress1()}
                        </span>
                    <#elseif customer.getCustomerAddress2()?? && customer.getCustomerAddress2() != "" >
                        <span class="part1">
                            ${customer.getCustomerAddress2()}
                        </span>
                    </#if>
                    <#if (customer.getCustomerAddress3()?? && customer.getCustomerAddress3() != "") && (customer.getCustomerAddress4()?? && customer.getCustomerAddress4() != "") >
                        <span class="part2">
                            ${customer.getCustomerAddress3()+", "+customer.getCustomerAddress4()}
                        </span>
                    <#elseif customer.getCustomerAddress3()?? && customer.getCustomerAddress3() != "" >
                        <span class="part2">
                            ${customer.getCustomerAddress3()}
                        </span>
                    <#elseif customer.getCustomerAddress4()?? && customer.getCustomerAddress4() != "" >
                        <span class="part2">
                            ${customer.getCustomerAddress2()}
                        </span>
                    </#if>
                </div>
                <div id = "accessory_customerAddress_text_${customer?index}_postalCode" class="sscw__customer__register_value_address">
                    <#if customer.getPostalCode()?? && customer.getPostalCode() != "" >
                        <span>${customer.getPostalCode()}</span>
                    </#if>
                </div>
            </div>
        </div>
    </label>
</#list>
<#if !(customers?has_content) >
    <div class="alert alert-info">
        <@fmt.message key="cylinderConfigurator.error.noCustomerFound"/>
    </div>
<#else>
        <script type="text/javascript">
            function enableNextButton(){
                $("#btn-next").removeClass("disabled");
                $("#btn-next").removeAttr("disabled");
            }
        </script>
</#if>
