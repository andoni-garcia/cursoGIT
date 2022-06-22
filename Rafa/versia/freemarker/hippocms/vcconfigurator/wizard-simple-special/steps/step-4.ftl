<div class="step step-4" data-step="4">
    <div class="row">
        <div class="col-12">
            <@fmt.message key="wizardsimplespecial.step4.selectAdditionalFiles"/>:
        </div>
    </div>
    <div class="row">
        <div class="col-6 offset-3">
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $component.configFiles.haveSyf"> <@fmt.message key="wizardsimplespecial.step4.syf"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $component.configFiles.havePdf"> <@fmt.message key="wizardsimplespecial.step4.pdf"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $component.configFiles.haveXls"> <@fmt.message key="wizardsimplespecial.step4.xls"/>
            </div>
            <div class="mt-2">
                <input type="checkbox" data-bind="checked: $component.configFiles.haveCad"> <@fmt.message key="wizardsimplespecial.step4.cad"/>
            </div>
            
        </div>
    </div>
</div>