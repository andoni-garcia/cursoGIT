<#compress>
<@fmt.message key="wizardsimplespecial.versioning.errorVersioning" var="labelErrorVersioning"/>
<@fmt.message key="wizardsimplespecial.versioning.errorVersioningEmptySimpleSpecial" var="labelErrorVersioningSs"/>
</#compress>
<div class="row mb-3">
    <div class="col-12">
        <input type="radio" name="simpleSpecialVersion" value="new" data-bind="checked: $component.ssType"> 
        <@fmt.message key="wizardsimplespecial.versioning.newSimpleSpecial"/>
    </div>
</div>
<div class="row mb-3">
    <div class="col-12">
        <@fmt.message key="wizardsimplespecial.versioning.or"/>
    </div>
</div>
<div class="row mb-3">
    <div class="col-12">
        <input type="radio" name="simpleSpecialVersion" value="existing" checked data-bind="checked: $component.ssType">
        <@fmt.message key="wizardsimplespecial.versioning.existingSimpleSpecial"/>
    </div>
</div>
<div class="row mb-3">
    <div class="col-5">
        <div class="row">
            <div class="col-12">
                <@fmt.message key="wizardsimplespecial.versioning.enterSimpleSpecial"/>
            </div>
            <div class="col-12">
                <input type="text" class="form-control" data-bind="disable: $component.ssType() == 'new', value: $component.simpleSpecialPartnumber, valueUpate: afterkeydown">
            </div>
        </div>
    </div>
    <div class="col-2 align-self-end">
        <button class="btn btn-primary" data-bind="click: getNewSimpleSpecial.bind()">
            <@fmt.message key="eshop.accept"/>
        </button>
    </div>
    <div class="col-5">
        <div class="row">
            <div class="col-12">
                <@fmt.message key="wizardsimplespecial.versioning.yourNewVersion"/>
            </div>
            <div class="col-12">
                <input type="text" class="form-control wss-new-version-text" data-bind="value: $component.simpleSpecialPartnumberVersion" disabled="disabled">
            </div>
        </div>
    </div>
</div>

<@hst.headContribution  category="htmlBodyEnd">
<script type="text/javascript">
var SS_VERSIONING_MESSAGES = {
	errorVersioning: '${labelErrorVersioning?js_string}',
    errorVersioningEmpty: '${labelErrorVersioningSs?js_string}'
};
 </script>
 </@hst.headContribution>