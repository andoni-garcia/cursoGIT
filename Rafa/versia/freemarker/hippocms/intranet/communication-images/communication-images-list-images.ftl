<#include "../../../include/imports.ftl">
<#include "../macros/dashboardCI.ftl">
<#include "../intranet-credentials.ftl">
<#include "../macros/showThumbnail.ftl">
<#compress>
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
    <@hst.setBundle basename="intranet-communication_images, SearchPage"/>
</#compress>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/intranet/intranet.component.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link href="/js/fancybox/dist/jquery.fancybox.min.css" media="all" rel="stylesheet" type="text/css"/>
</@hst.headContribution>

<#assign empty=true>

<#if pageable?? && pageable.items?has_content>
    <#assign empty=false>
</#if>

<div class="container">
    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="ci_list.title"/></h2>
    <h1 class="heading-02 heading-main"></h1>
</div>

<div class="container generalList-list generalList-container">
    <@hst.include ref="facets" />

    <#include "search-box.ftl">
    <div class="row align-self-end">
        <#if !empty>
            <#include "filters.ftl">
        </#if>
    </div>

    <@hst.link var="linkToDetail" siteMapItemRefId="CIdetailId"/>
    <#if !empty>
        <form>
            <div class="row mt-3">
            <!-- Communication images image list -->
                <ul class="generalList-files-list">

                    <#if pageable?? && pageable.items?has_content>
                        <#list pageable.items as item>

                                <!-- If image -->
                                <#if item.attachments.richFile[0].external.url?has_content>
                                    <#assign fileurl = item.attachments.richFile[0].external.url>
                                    <li class="generalList-files-list-item mt-4">
                                         <div class="attachment-detail">
                                            <!-- if image -->

                                            <@showThumbnail file=fileurl />
                                            <div class="attachment-info">${fileurl?split("/")?last}</div>
                                            <div class="attachment-buttons">
                                                <a class="btn generalList-btn-secondary" href="${linkToDetail}/${item.name}"><i class="far fa-file-alt"></i></a>
                                                <a class="btn generalList-btn-secondary btn-preview" data-fancybox="gallery" href="${fileurl}"><i class="fas fa-search-plus"></i></a>
                                                <label>
                                                    <input type="checkbox">
                                                    <div class="btn generalList-btn-secondary btn-preview" href="${link}">
                                                        <i class="fas fa-check"></i>
                                                    </div>
                                                </label>
                                            </div>
                                        </div>
                                    </li>

                                <#elseif item.attachments.richFile[0].embedded?has_content && !item.attachments.richFile[0].embedded.blank>
                                    <#assign file = item.attachments.richFile[0].embedded>
                                    <li class="generalList-files-list-item mt-4">
                                        <div class="attachment-detail">
                                            <@hst.link var="link" path="/binaries${file.path}"/>

                                            <!-- if image -->
                                            <#assign mimeType = file.mimeType>
                                            <@showThumbnail file=link mimeType=mimeType/>

                                            <div class="attachment-info">${file.filename}</div>
                                            <div class="attachment-buttons">
                                                <a class="btn generalList-btn-secondary" href="${linkToDetail}/${item.name}"><i class="far fa-file-alt"></i></a>
                                                <a class="btn generalList-btn-secondary btn-preview" data-fancybox="gallery" href="${link}"><i class="fas fa-search-plus"></i></a>
                                                <label>
                                                    <input type="checkbox">
                                                    <div class="btn generalList-btn-secondary btn-preview" href="${link}">
                                                        <i class="fas fa-check"></i>
                                                    </div>
                                                </label>
                                            </div>
                                        </div>
                                    </li>

                                </#if>
                            </li>
                        </#list>
                    </#if>
                </ul>

                <div class="form-row col-12">
                    <#if pageable.showPagination??>
                        <#include "pagination.ftl">
                    </#if>
                </div>
            </div>

            <@dashboardCI location="list"/>
        </form>
    <#else>

        <div class="dialog list-dialog">
            <div class="dialog list-dialog-container">
                <div class="dialog-icon"><i class="fas fa-search"></i></div>
                <div class="dialog-content">
                    <span class="dialog-title"><@fmt.message key="ci.noresult"/></span>
                    <span><@fmt.message key="ci.spelled"/></span>
                </div>
            </div>
        </div>

    </#if>
</div>


<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/intranet/IntranetViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script src="/js/fancybox/dist/jquery.fancybox.min.js" type="text/javascript"></script>
</@hst.headContribution>