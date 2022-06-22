<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.SuccessStory" -->
<#-- @ftlvariable name="counter" type="com.smc.hippocms.beans.SuccessStoryCounter" -->
<#-- @ftlvariable name="isSuccessStoryAdmin" type="java.lang.Boolean" -->

<#include "../../include/imports.ftl">
<#include "imports.ftl">

<#compress>
    <@hst.setBundle basename="success-stories.form"/>
</#compress>
<#assign empty=true>
<#if document?? && document?has_content>
  <#assign empty=false>
</#if>



<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/success-stories/success-stories.component.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link href="/js/fancybox/dist/jquery.fancybox.min.css" media="all" rel="stylesheet" type="text/css"/>
</@hst.headContribution>




<#if success??>
    <@fmt.message key="sstories.dialog.creation.success.content" var="messageSuccess"/>
    <div class="container">
        <h1 class="heading-08 color-blue mt-20"><@fmt.message key="sstories.dialog.creation.success.title"/></h1>
        <div class="row">
            <div class="col-md-9 mt-2">
                <p>${messageSuccess?replace("%application", showApplication)?replace("%reference", showReference)}</p>
                <div class="mt-5">
                    <a class="btn ss-btn-primary mr-2" href="${successStoriesForm}"><@fmt.message key="sstories.dialog.creation.success.button.new"/></a>
                    <a class="btn ss-btn-secondary" href="${successStoriesMain}"><@fmt.message key="sstories.dialog.creation.success.button.gotomain"/></a>
                </div>
            </div>
        </div>
    </div>

<#else>
    <div class="container ss-container-form">
        <@fmt.message var="modalQuitTitle" key="sstories.dialog.quit.title"/>
        <@fmt.message var="modalQuitContent" key="sstories.dialog.quit.content"/>
        <@fmt.message var="modalQuitSecondaryButton" key="sstories.dialog.quit.button.no"/>
        <@fmt.message var="modalQuitPrimaryButton" key="sstories.dialog.quit.button.yes"/>

        <@hst.link var="baseUrl" hippobean=document>
            <@hst.sitemapitem preferPath="/success-stories/detail/"/>
        </@hst.link>

        <@ssPopUp htmlId="modal-confirm-quit" title="${modalQuitTitle}" message="${modalQuitContent}"  primaryButton="${modalQuitPrimaryButton}" secondaryButton="${modalQuitSecondaryButton}" url=baseUrl/>
        <@ssPopUp htmlId="modal-confirm-quit-new" title="${modalQuitTitle}" message="${modalQuitContent}"  primaryButton="${modalQuitPrimaryButton}" secondaryButton="${modalQuitSecondaryButton}" url=successStoriesMain/>



        <h1 class="heading-08 color-blue mt-20"><@fmt.message key="sstories.title"/></h1>
        <#if updateSuccess?has_content && updateSuccess>
            <div class="dialog blue-dialog temporary">
                <div class="dialog-icon"><i class="fas fa-check"></i></div>
                <div class="dialog-content">
                    <span class="dialog-title"><@fmt.message key="sstories.dialog.update.title"/></span>
                    <span><@fmt.message key="sstories.dialog.update.content"/></span>
                </div>
                <div class="dialog-close"><i class="fas fa-times-circle"></i></div>
            </div>
        </#if>

        <div class="col-md-9">
            <form class="ss-edit"
                  action="<@hst.actionURL escapeXml=false />&${_csrf.parameterName}=${_csrf.token}"
                  method="post"
                  role="form"
                  id="ssForm"
                  enctype="multipart/form-data">
                <div class="row mt-4 ssFormRow">
                    <div class="blue-separator">

                        <div class="col-md-12 col-sm-12">
                            <#if empty>
                                <label class="ss-label ss-white-label"><strong><@fmt.message key="sstories.new_story"/></strong></label>
                            <#else>
                                <label class="ss-label ss-white-label"><strong><@fmt.message key="sstories.reference"/></strong></label>
                                <span class="ss-white-value">${document.formattedReference}</span>
                            </#if>
                        </div>
                    </div>
                </div>


                <div class="row ssFormRow">
                    <div class="col-md-6 mt-3">
                        <label><strong><@fmt.message key="sstories.subsidiary"/></strong><span class="required"> *</span></label>
                        <div class="dropdown smc-select">
                            <select id="subsidiary" class="required" name="subsidiary">
                            <#if empty>
                              <@displayValueListDropdown subsidiaries/>
                            <#else>
                              <@displayValueListDropdown subsidiaries document.subsidiary/>
                            </#if>
                            </select>
                        </div>
                    </div>
                </div>


                <div class="row ssFormRow">

                    <#-- Removed for LOPD conistence
                    <div class="col-md-6 mt-3">
                        <label><strong><@fmt.message key="sstories.sales_person"/></strong><span class="required"> *</span></label>
                        <input class="form-control required"
                               id="sales_person"
                               name="sales_person"
                               type="text"
                               value="<#if !empty>${document.sales_person}</#if>"
                               required>
                    </div>
                    <div class="col-md-6 mt-3">
                        <label><@fmt.message key="sstories.email"/></label>
                        <input class="form-control"
                               id="email"
                               name="email"
                               type="email"
                               value="<#if !empty>${document.email}</#if>">
                    </div>
                    -->

                    <div class="col-md-6 mt-3">
                        <label><strong><@fmt.message key="sstories.date"/></strong><span class="required"> *</span></label>
                        <input class="form-control required"
                               id="date"
                               name="date"
                               type="text"
                               autocomplete="off"
                               value="<#if !empty>${document.formattedDate?string["dd/MM/yyyy"]}</#if>"
                               required>
                    </div>
                </div>
                <div class="row ssFormRow">
                    <div class="col-md-6 mt-3">
                        <label><@fmt.message key="sstories.customer_name"/></label>
                        <input class="form-control"
                               id="customer_name"
                               name="customer_name"
                               type="text"
                               value="<#if !empty>${document.customer_name}</#if>">
                    </div>
                    <div class="col-md-6 mt-3">
                        <label><@fmt.message key="sstories.customer_type"/></label>
                        <div class="dropdown smc-select">
                            <select id="customer_type"
                                    name="customer_type">
                            <#if empty>
                              <@displayValueListDropdown customerTypes />
                            <#else>
                              <@displayValueListDropdown customerTypes document.customer_type/>
                            </#if>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6 mt-3">
                        <label><strong><@fmt.message key="sstories.industry_code"/></strong><span class="required"> *</span></label>
                        <div class="dropdown smc-select">
                            <select id="industry_code"
                                    class="required"
                                    name="industry_code"
                                    required>
                            <#if empty>
                              <@displayValueListDropdown industryCodes/>
                            <#else>
                              <@displayValueListDropdown industryCodes document.industry_code/>
                            </#if>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row ssFormRow">
                    <div class="col-md-12 mt-3">
                        <label><strong><@fmt.message key="sstories.application"/></strong><span class="required"> *</span></label>
                        <input class="form-control required"
                               id="application"
                               name="application"
                               type="text"
                               value="<#if !empty>${document.application}</#if>"
                               required>
                    </div>
                    <div class="col-md-12 mt-3">
                        <label><@fmt.message key="sstories.details"/></label>
                        <div class="form-group__inputWrapper ">
                            <textarea name="details"
                                      id="details"
                                      variant-name="details"
                                      class="form-control ssFormTextarea"
                                      cols="40"
                                      rows="10"
                                      placeholder=""><#if !empty>${document.details}</#if></textarea>
                        </div>
                    </div>
                </div>
                <div class="row ssFormRow">
                    <div class="col-md-6 mt-3">
                        <label><strong><@fmt.message key="sstories.smc_series"/></strong><span class="required"> *</span></label>
                        <div class="dropdown smc-select">
                            <select id="smc_series"
                                    class="required"
                                    name="smc_series"
                                    required>
                              <#if empty>
                                <@displayValueListDropdown smcSeries/>
                              <#else>
                                <@displayValueListDropdown smcSeries document.smc_series/>
                              </#if>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6 mt-3">
                        <label><strong><@fmt.message key="sstories.part_number"/></strong><span class="required"> *</span></label>
                        <input class="form-control required"
                               id="smc_part_number"
                               name="smc_part_number"
                               type="text"
                               value="<#if !empty>${document.part_number}</#if>"
                               required>
                    </div>
                    <div class="col-md-6 mt-3">
                        <label><@fmt.message key="sstories.competitor"/></label>
                        <div class="dropdown smc-select">
                            <select id="competitor_name"
                                    name="competitor_name">
                              <#if empty>
                                <@displayValueListDropdown competitors/>
                              <#else>
                                <@displayValueListDropdown competitors document.competitor/>
                              </#if>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6 mt-3">
                        <label><@fmt.message key="sstories.specify_competitor"/></label>
                        <input class="form-control"
                               id="specify_competitor"
                               name="specify_competitor"
                               type="text"
                               disabled="disabled"
                               value="<#if !empty>${document.specify_competitor}</#if>">
                    </div>
                    <div class="col-md-6 mt-3">
                        <label><@fmt.message key="sstories.competitor_product"/></label>
                        <input class="form-control"
                               id="competitor_product"
                               name="competitor_product"
                               type="text"
                               value="<#if !empty>${document.competitor_product}</#if>">
                    </div>
                </div>

                <div class="row ssFormRow">
                    <div class="col-md-12 mt-3">
                    <label><strong><@fmt.message key="sstories.customer_requirement"/></strong><span class="required"> *</span></label>
                    <div class="form-group__inputWrapper ">
                        <textarea name="customer_requirement"
                                  class="required form-control ssFormTextarea"
                                  cols="40"
                                  rows="10"
                                  placeholder=""
                                  id="customer_requirement"
                                  required><#if !empty>${document.customer_requirement}</#if></textarea>
                    </div>
                    </div>
                    <div class="col-md-12 mt-3">
                        <label><strong><@fmt.message key="sstories.factor_success"/></strong><span class="required"> *</span></label>
                        <div class="form-group__inputWrapper ">
                            <textarea name="factor_success"
                                      class="required form-control ssFormTextarea"
                                      cols="40"
                                      rows="10"
                                      placeholder=""
                                      id="factor_success"
                                      required><#if !empty>${document.factor_success}</#if></textarea>
                        </div>
                    </div>
                </div>

                <div class="row ssFormRow mt-5">
                    <div class="blue-separator">
                        <div class="col-md-2 col-sm-12">
                            <label class="ss-label ss-white-label"><strong><@fmt.message key="sstories.attachments"/></strong></label>
                        </div>
                    </div>
                </div>

                <div class="row ssFormRow dashboard-files">
                    <div class="files" id="files1">
                        <div class="btn ss-btn-primary btn-file">
                            <i class="fas fa-folder-open"></i>
                            <span class="hidden-xs">Browse …</span>
                            <input id="attachments_0" type="file" name="attachments_0" multiple />
                            <input id="attachments_1" type="file" name="attachments_1" multiple />
                            <input id="attachments_2" type="file" name="attachments_2" multiple />
                            <input id="attachments_3" type="file" name="attachments_3" multiple />
                            <input id="attachments_4" type="file" name="attachments_4" multiple />
                            <input id="fake_input" type="file" name="fake_input" multiple />
                        </div>
                        <span class="attachment-note"><@fmt.message key="sstories.dialog.attachments.notes"/></span>
                        <br />
                        <ul class="fileList ss-files-list">
                            <#if !empty && document.attachments?has_content>
                                <#assign counter = 0>
                                <#list document.attachments as attachment>
                                    <li class="ss-files-list-item mt-4" id="li_attachments_${counter}">
                                        <div class="attachment-detail">
                                            <!-- if image -->
                                            <@showThumbnail file=attachment />
                                            <div class="attachment-info">${attachment?split("/")?last}</div>
                                            <div class="attachment-buttons">
                                                <a class="removeFile btn ss-btn-secondary" href="#" data-fileid="attachments_${counter}"><i class="fas fa-trash"></i></a>
                                                <a class="btn ss-btn-secondary" data-fancybox="gallery" href="${attachment}"><i class="fas fa-search-plus"></i></a>
                                            </div>
                                            <input id="prev_attachments_${counter}" type="hidden" name="prev_attachments_${counter}" value="${attachment}"/>
                                        </div>
                                    </li>
                                    <#assign counter = counter + 1>
                                </#list>
                            </#if>
                        </ul>
                        <div id="dialog-error-maxfilescount" class="dialog error-dialog temporary" style="display: none;">
                            <div class="dialog-icon"><i class="fas fa-times"></i></div>
                            <div class="dialog-content">
                                <span class="dialog-title"><@fmt.message key="sstories.dialog.attachments.error.amount.title"/></span>
                                <span><@fmt.message key="sstories.dialog.attachments.error.amount.content"/></span>
                            </div>
                        </div>
                        <div id="dialog-error-maxfilesize" class="dialog error-dialog temporary" style="display: none;">
                            <div class="dialog-icon"><i class="fas fa-times"></i></div>
                            <div class="dialog-content">
                                <span class="dialog-title"><@fmt.message key="sstories.dialog.attachments.error.size.title"/></span>
                                <span><@fmt.message key="sstories.dialog.attachments.error.size.content"/></span>
                            </div>
                        </div>
                    </div>
                </div>

                <@dashboard location="form" isAdmin=isSuccessStoryAdmin document=document />

            </form>
        </div>
    </div>
</#if>


<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/bindings/Datepicker.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/success-stories/SuccessStoriesRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/success-stories/SuccessStoriesForm.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="/js/fancybox/dist/jquery.fancybox.min.js" type="text/javascript"></script>
</@hst.headContribution>

<script>
    // Used for creating a new FileList in a round-about way
    function FileListItem(a) {
        a = [].slice.call(Array.isArray(a) ? a : arguments)
        for (var c, b = c = a.length, d = !0; b-- && d;) d = a[b] instanceof File
        if (!d) throw new TypeError("expected argument to FileList is File or array of File objects")
        for (b = (new ClipboardEvent("")).clipboardData || new DataTransfer; c--;) b.items.add(a[c])
        return b.files
    }


    $.fn.fileUploader = function (sectionIdentifier, maxFilesCount, maxFilesSize) {
        this.closest(".files").change(function (evt) {
        var output = [];
        var filesCountExceeded = false; // True if more than maxFilesCount files are uploaded.
        var fileSizeExceeded = false; // True if a file of more than maxFilesSize bytes is uploaded.

        // Loop through the files selected
        for (var i = 0; i < evt.target.files.length; i++) {
            var fileSaved = false;
            var id = 0;
            var file = evt.target.files[i];

            if(file.size > maxFilesSize) {
                // The file is too big
                fileSizeExceeded = true;
            } else {

                while (fileSaved === false && id < maxFilesCount) {
                    if (($("#attachments_" + id).val() === '') && !($("#li_attachments_" + id).length)) {
                        var fileId = sectionIdentifier + id;
                        var extension = file.name.split('.').pop().toLowerCase();

                        // Includes selected file in the list to show it on the page
                        var wrapBegin = "<li class=\"ss-files-list-item mt-4\" id=\"li_" + fileId + "\"><div class=\"attachment-detail new-item\">";
                        var thumbBegin = "<div class=\"attachment-thumbnail thumbnail-placeholder\">";
                        var thumbnail = "";

                        switch (extension) {
                            case 'png':
                            case 'jpg':
                            case 'jpeg':
                            case 'gif':
                                thumbnail = "<i class=\"far fa-file-image\"></i>";
                                break;
                            case 'pdf':
                                thumbnail = "<i class=\"far fa-file-pdf\"></i>";
                                break;
                            case 'doc':
                            case 'docx':
                                thumbnail = "<i class=\"far fa-file-word\"></i>";
                                break;
                            case 'xls':
                            case 'xlsx':
                                thumbnail = "<i class=\"far fa-file-excel\"></i>";
                                break;
                            case 'zip':
                                thumbnail = "<i class=\"far fa-file-archive\"></i>";
                                break;
                            default:
                                thumbnail = "<i class=\"far fa-file\"></i>";
                        }

                        var thumbEnd = "</div>";

                        var fileInfo = "<div class=\"attachment-info\">" + escape(file.name) + "</div>";
                        var actions = "<div class=\"attachment-buttons\"><i class=\"fas fa-plus-circle fas-left\"></i>\n" +
                            "             <a class=\"removeFile btn ss-btn-secondary\" href=\"#\" data-fileid=\"" + fileId + "\"><i class=\"fas fa-trash\"></i></a>\n" +
                            "          </div>";
                        var wrapEnd = "</div></li>";


                        output.push(wrapBegin + thumbBegin + thumbnail + thumbEnd + fileInfo + actions + wrapEnd);


                        // Set input file
                        var fileInput = $('#' + fileId);
                        var files = [file];
                        fileInput[0].files = new FileListItem(files);

                        // There was available space for this file
                        fileSaved = true;
                    }
                    id++;
                }
                if (!fileSaved) {
                    filesCountExceeded = true;
                }
            }
        }

        if (filesCountExceeded) {
            $('#dialog-error-maxfilescount').slideDown('');
            setTimeout(function(){
                $("#dialog-error-maxfilescount").slideUp();
            }, 5000);
        }

        if (fileSizeExceeded) {
            $('#dialog-error-maxfilesize').slideDown('');
            setTimeout(function(){
                $("#dialog-error-maxfilesize").slideUp();
            }, 5000);
        }

        $(this).children(".fileList")
            .append(output.join(""));

        // Reset the input to null - nice little chrome bug!
        evt.target.value = null;
    });

    $(this).on("click", ".removeFile", function (e) {
        e.preventDefault();

        var fileId = $(this).parent().children("a").data("fileid");

        // Reset input file
        $('#' + fileId).val('');

        // Remove item from the list
        $('#li_' + fileId).remove();
    });

    //binds to this element, the event 'change' for when the value will change, it will trigger
    $("#competitor_name").on("change", function(){

        //this will trigger when the val contains the word 'other'
       if($(this).val().toLowerCase().indexOf("other") !== -1){
           $("#specify_competitor").removeAttr("disabled");
        } else {
           $("#specify_competitor").attr("disabled","disabled");
           $("#specify_competitor").val("");
       }
    });

    return this;
};

(function () {
    var maxFilesCount = 5;
    var maxFilesSize = 5000000;
    var sectionIdentifier = "attachments_";
    var filesUploader = $("#files1").fileUploader(sectionIdentifier, maxFilesCount, maxFilesSize);

})()
</script>