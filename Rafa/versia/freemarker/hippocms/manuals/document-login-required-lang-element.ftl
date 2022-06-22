<ul class="content-lister__resultsTable__langList">
    <#if documentList?size gt 0>
        <li>
            <#if isAuthenticated>
                <a onclick="javascript:downloadFile('${documentList[0].files[0].url}','${documentType}','${currentModel}');"
                   id="sistema_document_${documentList[0].files[0].identifier}"
                   href="javascript:void(0);" >${documentList[0].lang}</a>
            <#else>
                <a href="javascript:void(0);" id="sistema_document_${documentList[0].files[0].identifier}"
                   onclick="javascript:redirectToLoginForDoc('${documentList[0].files[0].url}',this);">${documentList[0].lang}</a>
            </#if>
        </li>
    </#if>
    <#if documentList?size gt 2>
        <li class="content-lister__resultsTable--modalTrigger content-lister__resultsTable__iconContainer">
            <a href="#"><i class="icon-small-plus"></i></a>
            <div class="langModal content-lister__modal">
                <ul>
                    <#list documentList as document>
                        <#if document?index gt 1>
                            <li>${document.lang}</li>
                            <li>
                                <#if isAuthenticated>
                                    <a onclick="javascript:downloadFile('${document.files[0].url}','${documentType}','${currentModel}');"
                                       id="sistema_document_${document.files[0].identifier}"
                                       href="javascript:void(0);">${document.files[0].label}</a>
                                <#else>
                                    <a href="javascript:void(0);" id="sistema_document_${document.files[0].identifier}"
                                       onclick="javascript:redirectToLoginForDoc('${document.files[0].url}',this);">${document.files[0].label}</a>
                                </#if>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </div>
        </li>
    </#if>
</ul>