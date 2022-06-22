<#macro showThumbnail file mimeType=false>
    <#if file?lower_case?ends_with(".png") || file?lower_case?ends_with(".jpg") || file?lower_case?ends_with(".jpeg") ||
    file?lower_case?ends_with(".gif") || file?lower_case?ends_with(".tif") || file?lower_case?starts_with("image/") || mimeType?lower_case?starts_with("image/")>
        <img class="img-responsive attachment-thumbnail" src="${file}" alt="">

    <#elseif file?lower_case?ends_with(".pdf") || mimeType?lower_case?ends_with("application/pdf")>
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