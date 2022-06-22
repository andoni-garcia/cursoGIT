<#include "../../../include/imports.ftl">
<#include "../intranet-credentials.ftl">
<#include "../macros/showThumbnail.ftl">
<#include "../macros/dashboardIntranet.ftl">

<#compress>
    <@hst.setBundle basename="intranet-price_proposal,intranet-communication_images"/>º
</#compress>
<#assign empty=true>
<#if document??>
    <#assign empty=false>
</#if>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/intranet/intranet.component.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link href="/js/fancybox/dist/jquery.fancybox.min.css" media="all" rel="stylesheet" type="text/css"/>
</@hst.headContribution>



<div class="container generalList-container">

    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="pp_detail.title"/></h2>
    <h1 class="heading-02 heading-main"></h1>

    <div class="col-md-9">

        <div class="row generalListFormRow">
            <div class="blue-separator">
                <div class="col-md-2 col-sm-2">
                    <label class="generalList-label generalList-white-label"><strong><@fmt.message key="pp.name"/></strong></label>
                </div>
                <div class="col-md-10 col-sm-10">
                    <span class="generalList-white-value">${document.ppname}</span>
                </div>
            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.series"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="generalList-value">${document.series}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.subject"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="generalList-value">${subjectList[document.subject]}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.proposaldate"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="generalList-value">${document.proposaldate.time?datetime?string["dd/MM/yyyy"]}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.fixeddate"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="generalList-value">${document.fixeddate.time?datetime?string["dd/MM/yyyy"]}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.category"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="generalList-value">${categoryList[document.category]}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.status"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="generalList-value">${statusList[document.status]}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.product"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <#if document.product?? && document.product>
                    <span class="generalList-value"><@fmt.message key="pp.yes"/></span>
                <#else>
                    <span class="generalList-value"><@fmt.message key="pp.no"/></span>
                </#if>

            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.contraproposal"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <#if document.contraproposal?? && document.contraproposal>
                    <span class="generalList-value"><@fmt.message key="pp.yes"/></span>
                <#else>
                    <span class="generalList-value"><@fmt.message key="pp.no"/></span>
                </#if>

            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.createdby"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="generalList-value">${document.createdby}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="generalList-label"><strong><@fmt.message key="pp.informto"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="generalList-value">${document.informto}</span>
            </div>
        </div>

        <#if !empty>
            <div class="row generalListFormRow mt-5">
                <div class="blue-separator">
                    <div class="col-md-2 col-sm-2">
                        <label class="generalList-label generalList-white-label"><strong><@fmt.message key="pp.attachments"/></strong></label>
                    </div>
                </div>
            </div>
            <#if document.attachments.richFile[0].embedded?? || (document.attachments.richFile[0].external.url?has_content)>
                <div class="row mt-3">
                    <ul class="generalList-files-list">
                        <#list document.attachments.richFile as richFile>
                            <#if richFile.external.url?has_content>
                                <#assign fileurl = richFile.external.url>
                                <li class="generalList-files-list-item mt-4">
                                     <div class="attachment-detail">
                                        <!-- if image -->

                                        <@showThumbnail file=fileurl />
                                        <div class="attachment-info">${fileurl?split("/")?last}</div>
                                        <div class="attachment-buttons">
                                            <a class="btn generalList-btn-secondary" href="${fileurl}" target="_blank"><i class="fas fa-external-link-alt"></i></a>
                                            <a class="btn generalList-btn-secondary btn-preview" data-fancybox="gallery" href="${fileurl}"><i class="fas fa-search-plus"></i></a>
                                        </div>
                                    </div>
                                </li>

                            <#elseif richFile.embedded?has_content && !richFile.embedded.blank>
                                <#assign file = richFile.embedded>
                                    <li class="generalList-files-list-item mt-4">
                                        <div class="attachment-detail">
                                            <@hst.link var="link" path="/binaries${file.path}"/>

                                            <!-- if image -->
                                            <#assign mimeType = file.mimeType>
                                            <@showThumbnail file=link mimeType=mimeType/>

                                            <div class="attachment-info">${file.filename}</div>
                                            <div class="attachment-buttons">
                                                <a class="btn generalList-btn-secondary" href="${link}" target="_blank"><i class="fas fa-external-link-alt"></i></a>
                                                <a class="btn generalList-btn-secondary btn-preview" data-fancybox="gallery" href="${link}"><i class="fas fa-search-plus"></i></a>
                                            </div>
                                        </div>
                                    </li>


                            </#if>
                        </#list>
                    </ul>
                </div>
            </#if>
        </#if>

    <@dashboardIntranet location="detail"/>
    </div>
</div>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/intranet/IntranetViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="/js/fancybox/dist/jquery.fancybox.min.js" type="text/javascript"></script>
</@hst.headContribution>
