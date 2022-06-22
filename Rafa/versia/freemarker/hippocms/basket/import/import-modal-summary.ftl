<@fmt.message key="basket.importModal.summaryMessage" var="summaryMessage"/>

<#if  summaryMessage?has_content && !summaryMessage?contains('???')>
<p>${summaryMessage}</p>
</#if>
<table class="table">
<thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col"><@fmt.message key="eshop.partnumber"/></th>
      <th scope="col"><@fmt.message key="eshop.customerPartNumber"/></th>
      <!-- <th scope="col"><@fmt.message key="eshop.productDescription"/></th> -->
      <th scope="col"><@fmt.message key="eshop.quantity"/></th>
    </tr>
  </thead>

<tbody>

<!-- ko foreach: validatedProducts    -->
    <tr data-bind="css:{ 'bg-not-match': status == 'ALIAS_NOT_MATCH', 'bg-repeated': status == 'ALREADY_EXISTS' }">
        <th style="width: 8.33%" class="col-md-1" scope="row" data-bind="text: $root.itemNumber($index())"></th>
        <td style="width: 25%">
          <span data-bind="text: partNumber"> </span>
        </td>
        <td style="width: 25%">
          <span data-bind="text: customerPartNumber"> </span>
        </td>
        <!--
        <td class="text-dark description" style="width: 33.33%">
            <span data-bind="text: name"> </span>
        </td>
        -->
        <td style="width: 16.66%">
            <span data-bind="text: quantity"> </span>
        </td>
    </tr>
<!-- /ko -->
</tbody>
</table>

<div>
    <div class="row col-12 mb-1">
        <div class="bg-not-match legend-square"></div>
        <span> <@fmt.message key="basket.importModal.aliasInUse"/> </span>
    </div>
    <div class="row col-12">
        <div class="bg-repeated legend-square"></div>
        <span> <@fmt.message key="basket.importModal.alreadyExists"/> </span>
    </div>
</div>
