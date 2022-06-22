<ul class="content-lister__resultsTable__langList">
    <#if documentList?size gt 0>
        <li>
            <a onclick="javascript:downloadFile('${documentList[0].files[0].url}','${documentType}','${currentModel}');"
               href="javascript:void(0);">${documentList[0].lang}</a>
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
                                <a onclick="javascript:downloadFile('${document.files[0].url}','${documentType}','${currentModel}');"
                                   href="javascript:void(0);">${document.files[0].label}</a>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </div>
        </li>
    </#if>
</ul>