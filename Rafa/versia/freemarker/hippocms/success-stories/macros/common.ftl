<#include "../../../include/imports.ftl">

<#macro displayValueListDropdown valueList value="">
    <@hst.setBundle basename="success-stories.form"/>
    <option value="" selected><@fmt.message key="sstories.placeholder.select"/></option>
    <#list valueList?keys?sort as key>
        <#if value?has_content && value == key>
            <option value="${key}" selected>${valueList[key]}</option>
        <#else>
            <option value="${key}">${valueList[key]}</option>
        </#if>
    </#list>
</#macro>

<#macro ssPopUp htmlId="modal-component" title="" message="" primaryButton="" secondaryButton="" cancelButton="" url="">
    <div class="modal fade" id="${htmlId}" role="dialog" data-swiftype-index='false'>
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">${title}</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <span class="modal-message">${message}</span>
                </div>
                <div class="modal-footer">
                    <button type="button" id="btn-return" class="btn ss-btn-secondary btn-secondary" data-dismiss="modal">${secondaryButton}</button>
                    <a href="${url}" class="btn btn-default ss-btn-primary btn-primary">${primaryButton}</a>
                </div>
            </div>
        </div>
    </div>
</#macro>

<#macro showThumbnail file>
    <#if file?lower_case?ends_with(".png") || file?lower_case?ends_with(".jpg") || file?lower_case?ends_with(".jpeg") || file?lower_case?ends_with(".gif")>
        <img class="img-responsive attachment-thumbnail" src="${file}" alt="">
    <#elseif file?lower_case?ends_with(".pdf")>
        <embed class="file-preview-pdf attachment-thumbnail" src="${file}" type="application/pdf">
    <#else>
        <div class="attachment-thumbnail thumbnail-placeholder">
            <#if file?lower_case?ends_with(".doc") || file?lower_case?ends_with(".docx")><i class="far fa-file-word"></i>
            <#elseif file?lower_case?ends_with(".avi") || file?lower_case?ends_with(".mpeg") || file?lower_case?ends_with(".mov")><i class="far fa-file-video"></i>
            <#elseif file?lower_case?ends_with(".ppt") || file?lower_case?ends_with(".pptx")><i class="far fa-file-powerpoint"></i>
            <#elseif file?lower_case?ends_with(".xls") || file?lower_case?ends_with(".xlsx")><i class="far fa-file-excel"></i>
            <#elseif file?lower_case?ends_with(".zip")><i class="far fa-file-archive"></i>
            <#else><i class="far fa-file"></i></#if>
        </div>
    </#if>
</#macro>

<#macro showPlaceholder file>
    <div class="attachment-thumbnail thumbnail-placeholder">
        <#if file?lower_case?ends_with(".png") || file?lower_case?ends_with(".jpg") || file?lower_case?ends_with(".jpeg") || file?lower_case?ends_with(".gif")><i class="far fa-file-image"></i>
        <#elseif file?lower_case?ends_with(".pdf")><i class="far fa-file-pdf"></i>
        <#elseif file?lower_case?ends_with(".doc") || file?lower_case?ends_with(".docx")><i class="far fa-file-word"></i>
        <#elseif file?lower_case?ends_with(".avi") || file?lower_case?ends_with(".mpeg") || file?lower_case?ends_with(".mov")><i class="far fa-file-video"></i>
        <#elseif file?lower_case?ends_with(".xls") || file?lower_case?ends_with(".xlsx")><i class="far fa-file-excel"></i>
        <#elseif file?lower_case?ends_with(".zip")><i class="far fa-file-archive"></i>
        <#else><i class="far fa-file"></i></#if>
    </div>
</#macro>