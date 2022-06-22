<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.SuccessStory" -->
<#-- @ftlvariable name="isSuccessStoryAdmin" type="java.lang.Boolean" -->

<#include "../../include/imports.ftl">
<#include "imports.ftl">

<#compress>
    <@hst.setBundle basename="success-stories.detail"/>
</#compress>
<#assign empty=true>
<#if document??>
    <#assign empty=false>
</#if>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/success-stories/success-stories.component.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link href="/js/fancybox/dist/jquery.fancybox.min.css" media="all" rel="stylesheet" type="text/css"/>
</@hst.headContribution>



<div class="container ss-container">

    <@fmt.message var="modalDeleteTitle" key="sstories.dialog.delete.title"/>
    <@fmt.message var="modalDeleteContent" key="sstories.dialog.delete.content"/>
    <@fmt.message var="modalDeleteSecondaryButton" key="sstories.dialog.delete.button.no"/>
    <@fmt.message var="modalDeletePrimaryButton" key="sstories.dialog.delete.button.yes"/>

    <@hst.link var="baseUrl" hippobean=document>
      <@hst.sitemapitem preferPath="/success-stories" />
    </@hst.link>

    <#if baseUrl?contains("/success-stories")>
        <#if locale != "en-eu">
            <#assign baseUrl = baseUrl?replace('/success-stories', '/${locale}/success-stories')>
        </#if>
    </#if>

    <@ssPopUp htmlId="modal-confirm-delete" title="${modalDeleteTitle}" message="${modalDeleteContent}"  primaryButton="${modalDeletePrimaryButton}" secondaryButton="${modalDeleteSecondaryButton}" url=renderActionUrl(baseUrl, "d")/>

    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="sstories.title"/></h2>
    <h1 class="heading-02 heading-main">${document.application}</h1>

    <#if disapprovalSuccess?has_content && disapprovalSuccess>
        <div id="success-disapprove" class="dialog blue-dialog temporary">
            <div class="dialog-icon"><i class="fas fa-check"></i></div>
            <div class="dialog-content">
                <span class="dialog-title"><@fmt.message key="sstories.dialog.disapprove.title"/></span>
                <span><@fmt.message key="sstories.dialog.disapprove.content"/></span>
            </div>
            <div class="dialog-close"><i class="fas fa-times-circle"></i></div>
        </div>
    </#if>
    <#if approvalSuccess?has_content && approvalSuccess>
        <div id="success-approve" class="dialog blue-dialog temporary">
            <div class="dialog-icon"><i class="fas fa-check"></i></div>
            <div class="dialog-content">
                <span class="dialog-title"><@fmt.message key="sstories.dialog.approve.title"/></span>
                <span><@fmt.message key="sstories.dialog.approve.content"/></span>
            </div>
            <div class="dialog-close"><i class="fas fa-times-circle"></i></div>
        </div>
    </#if>

    <div class="col-md-9">

        <div class="row ssFormRow">
            <div class="blue-separator">
                <div class="col-md-2 col-sm-2">
                    <label class="ss-label ss-white-label"><strong><@fmt.message key="sstories.reference"/></strong></label>
                </div>
                <div class="col-md-10 col-sm-10">
                    <span class="ss-white-value">${document.formattedReference}</span>
                </div>
            </div>
        </div>

        <#if isSuccessStoryAdmin>
            <div class="row ssFormRow mt-4">
                <div class="col-md-2 col-sm-12">
                    <label class="ss-label"><strong><@fmt.message key="sstories.status"/></strong></label>
                </div>
                <div class="col-md-10 col-sm-12">
                    <#if document.publish?? && document.publish>
                        <span class="ss-value ss-item-status ss-item-status-approved"><@fmt.message key="sstories.approved"/><i class="fas fa-check-circle"></i></span>
                    <#else>
                        <span class="ss-value ss-item-status ss-item-status-disapproved"><@fmt.message key="sstories.disapproved"/><i class="fas fa-minus-circle"></i></span>
                    </#if>
                </div>
            </div>
        </#if>

        <div class="row ssFormRow mt-4">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.subsidiary"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.subsidiary}</span>
            </div>
        </div>

        <#-- Removed for LOPD conistence

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.sales_person"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.sales_person}</span>
            </div>
        </div>


        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.email"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.email}</span>
            </div>
        </div>

        -->

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.date"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.formattedDate?string["dd-MM-yyyy"]}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.customer_name"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.customer_name}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.customer_type"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.customer_type}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.industry_code"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.industry_code}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.application"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.application}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.details"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.details}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.smc_series"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.smc_series}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.part_number"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.part_number}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.competitor"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.competitor}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.specify_competitor"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.specify_competitor}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.competitor_product"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.competitor_product}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.customer_requirement"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.customer_requirement}</span>
            </div>
        </div>

        <div class="row ssFormRow mt-3">
            <div class="col-md-2 col-sm-12">
                <label class="ss-label"><strong><@fmt.message key="sstories.factor_success"/></strong></label>
            </div>
            <div class="col-md-10 col-sm-12">
                <span class="ss-value">${document.factor_success}</span>
            </div>
        </div>
        <#if empty || (!empty && document.attachments?has_content)>
            <div class="row ssFormRow mt-5">
                <div class="blue-separator">
                    <div class="col-md-2 col-sm-12">
                        <label class="ss-label ss-white-label"><strong><@fmt.message key="sstories.attachments"/></strong></label>
                    </div>
                </div>
            </div>
        </#if>

        <#if !empty>
            <#if document.attachments?has_content>
                <div class="row mt-3">
                    <ul class="ss-files-list">

                        <#list document.attachments as attachment>
                            <li class="ss-files-list-item mt-4">
                                <div class="attachment-detail">
                                    <!-- if image -->

                                    <@showThumbnail file=attachment />
                                    <div class="attachment-info">${attachment?split("/")?last}</div>
                                    <div class="attachment-buttons">
                                        <a class="btn ss-btn-secondary" href="${attachment}" target="_blank"><i class="fas fa-external-link-alt"></i></a>
                                        <a class="btn ss-btn-secondary btn-preview" data-fancybox="gallery" href="${attachment}"><i class="fas fa-search-plus"></i></a>
                                    </div>
                                </div>
                            </li>
                        </#list>

                    </ul>
                </div>
            </#if>
        </#if>

        <@dashboard location="detail" isAdmin=isSuccessStoryAdmin document=document />

    </div>
</div>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/success-stories/SuccessStoriesRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/success-stories/SuccessStoriesViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="/js/fancybox/dist/jquery.fancybox.min.js" type="text/javascript"></script>
</@hst.headContribution>
