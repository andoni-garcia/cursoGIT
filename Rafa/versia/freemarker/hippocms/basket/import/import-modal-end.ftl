<!-- ko if: $data.errorOnImport() -->
    <div>
        <@fmt.message key="basket.importModal.errorMessage"/>
        <div class="row mt-5 mb-5"><i class="fa fa-times-circle text-danger" style="font-size:96px;margin: auto;"></i></div>

    </div>
<!-- /ko -->

<!-- ko if: !$data.errorOnImport() -->
    

    <div class="row mt-5 mb-5"><i class="fa fa-check-circle text-success" style="font-size:96px;margin: auto;"></i></div>

    <@fmt.message key="basket.importModal.successMessage"/>

    <p><span> <@fmt.message key="basket.importModal.importedProducts"/>: </span> <span data-bind="text: $data.importedProducts().length"></span></p>
    <p><span> <@fmt.message key="basket.importModal.nonImportedProducts"/>: </span> <span data-bind="text: $data.validatedProducts().length - $data.importedProducts().length"></span></p>
    <ul data-bind="foreach: $data.errorImportedProducts()">
        <li><span data-bind="text: partnumberCode"></span> Qty: <span data-bind="text: quantity"></span></li>
    </ul>

<!-- /ko -->