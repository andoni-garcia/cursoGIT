<#ftl encoding="UTF-8">

<div class="form-row">

    <div class="form-group col-md-12">
        <label class="smc-file-upload">
            <input type="file" multiple name="${field.formRelativeUniqueName}" class="${field.styleClass!} form-control"
                   data-validate="fileSizeAndExtension" data-max-size="${field.maxUploadSize}"
                   data-allowed-extensions="<#if field.fileExtensions?? && (field.fileExtensions?size > 0)>${field.fileExtensions?join(",")}</#if>" />
            <span class="btn btn-primary">${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></span>
        </label>
        <label class="file-attached"></label>
        <div class="smc-dummy-placeholder">${field.hint!?html}</div>
    </div>
</div>
