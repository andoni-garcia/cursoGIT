<#include "../../../include/imports.ftl">
<#include "../functions/get-ss-url.ftl">
<@hst.link var="successStoriesRedirect" siteMapItemRefId="successstoriesredirect" fullyQualified=true />

<#macro dashboard location="" isAdmin=false document="">
<@hst.link var="link" hippobean=document/>
    <#-- Form -->
    <#if location == "form">
        <#-- Edit -->
        <#if document?has_content>
            <#if isAdmin>
                <div class="row my-5 dashboard-user">
                    <div class="row m-3 w-100">
                        <div class="col-md-6">
                            <div><button type="submit" class="heading-09"><i class="fas fa-save"></i><@fmt.message key="sstories.button.save_changes"/></button></div>
                        </div>
                        <div class="col-md-6">
                            <div><button type="button" class="heading-09 discardChanges" id="quit-button"><i class="fas fa-arrow-left"></i><@fmt.message key="sstories.button.discard_changes"/></button></div>
                        </div>
                    </div>
                </div>
            </#if>
        <#-- Create new -->
        <#else>
            <div class="row my-5 dashboard-user">
                <div class="row m-3 w-100">
                    <div class="col-md-6">
                        <div><button type="submit" class="heading-09"><i class="fas fa-save"></i><@fmt.message key="sstories.button.save_new"/></button></div>
                    </div>
                    <div class="col-md-6">
                        <div><a href="${successStoriesRedirect}" type="button" class="heading-09" id="quit-button"><i class="fas fa-arrow-up"></i><@fmt.message key="sstories.button.go_to_main"/></a></div>
                    </div>
                </div>
            </div>
        </#if>

    <#-- Detail -->
    <#elseif location == "detail">
        <#if isAdmin>
            <div class="row my-5 dashboard-user">
                <div class="row m-3 w-100">
                    <div class="col-md-4">
                        <div><a href="${changeDetailToForm(link)}" class="heading-09"><i class="fas fa-edit"></i><@fmt.message key="sstories.button.edit"/></a></div>
                        <div class="mt-2"><a href="${renderActionUrl(baseUrl, "p")}" class="heading-09" target="_blank"><i class="fas fa-file-pdf"></i> <@fmt.message key="sstories.button.generate_pdf"/></a></div>
                    </div>
                    <div class="col-md-4">
                        <div><button class="heading-09" id="delete-button"><i class="fas fa-trash"></i> <@fmt.message key="sstories.button.delete"/></button></div>
                        <div class="mt-2"><a href="${successStoriesRedirect}" class="heading-09 redirectList" id="quit-button"><i class="fas fa-arrow-up"></i><@fmt.message key="sstories.button.go_to_main"/></button></div>
                    </div>
                    <div class="col-md-4">
                        <#if document.publish?? && document.publish>
                            <div><a href="${renderActionUrl(baseUrl, "o")}" class="heading-09"><i class="fas fa-minus-circle"></i> <@fmt.message key="sstories.button.disapprove"/></a></div>
                        <#else>
                            <div><a href="${renderActionUrl(baseUrl, "a")}" class="heading-09"><i class="fas fa-check-circle"></i> <@fmt.message key="sstories.button.approve"/></a></div>
                        </#if>
                    </div>
                </div>
            </div>
        <#else>
            <div class="row my-5 dashboard-user">
                <div class="row m-3 w-100">
                    <div class="col-md-6">
                        <div><a href="${renderActionUrl(baseUrl, "p")}" class="heading-09" target="_blank"><i class="fas fa-file-pdf"></i> <@fmt.message key="sstories.button.generate_pdf"/></a></div>
                    </div>
                    <div class="col-md-6">
                        <div><a href="${successStoriesMain}" class="heading-09"><i class="fas fa-arrow-up"></i><@fmt.message key="sstories.button.go_to_main"/></a></div>
                    </div>
                </div>
            </div>
        </#if>

    <!-- Success stories list options -->
    <#elseif location == "list">
        <#if isAdmin>
            <div class="row m-0 my-5 dashboard-user">
                <div class="row m-3 w-100">
                    <div class="col-md-4">
                        <a href="${successStoriesForm}" class="heading-09"><i class="fas fa-plus-square"></i> <@fmt.message key="sstories.newstory"/></a>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" name="action" value="approve" class="heading-09"><i class="fas fa-check-circle"></i><@fmt.message key="sstories.approve"/></button>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" name="action" value="disapprove" class="heading-09"><i class="fas fa-minus-circle"></i><@fmt.message key="sstories.disapprove"/></button>
                    </div>
                </div>
            </div>
        <#else>
            <div class="row m-0 my-5 dashboard-user">
                <div class="row m-3 w-100">
                    <div class="col-md-4">
                        <a href="${successStoriesForm}" class="heading-09"><i class="fas fa-plus-square"></i> <@fmt.message key="sstories.newstory"/></a>
                    </div>
                </div>
            </div>
        </#if>
    </#if>
</#macro>

<#function changeDetailToForm link>
    <#if link?contains("detail")>
        <#return link?replace("detail", "form")>
    <#else>
        <#return link>
    </#if>
</#function>