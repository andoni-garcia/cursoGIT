<div class="step step-5" data-step="5">
    <div class="row">
        <div class="col-12">
            <@fmt.message key="wizardsimplespecial.step5.selectFields"/>
        </div>
    </div>
    <div class="row">
        <div class="col-6 offset-3">
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $root.pdfConfig.designerContact"> <@fmt.message key="designerContact"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $root.pdfConfig.customerContact"> <@fmt.message key="customerContact"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $root.pdfConfig.sellingPrice"> <@fmt.message key="wizardsimplespecial.step5.sellingPrice"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $root.pdfConfig.listPrice"> <@fmt.message key="eshop.listPrice"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $root.pdfConfig.bom"> <@fmt.message key="wizardsimplespecial.step5.billOfMaterials"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $root.pdfConfig.leadTime"> <@fmt.message key="vc.bom.leadTime"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $root.pdfConfig.leadListPriceDetails"> <@fmt.message key="wizardsimplespecial.step5.listPriceDetails"/>
            </div>
        </div>
    </div>
</div>