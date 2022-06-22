<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Banner" -->

<#if document??>
    <#if isLeftPosition>
        <#if isBlueColor>
            <div class="container-fluid banner-blue banner-nomargin <#if hideMobile == true>d-none d-sm-block</#if>">
        <#else>
            <div class="container-fluid banner-white banner-nomargin <#if hideMobile == true>d-none d-sm-block</#if>">
        </#if>
        <div class="row banner-nomargin banner-main">
            <div class="banner-div-main banner-div-main-left">
                <div>
                    <#if document.title?? && document.title?has_content>
                        <h3 class="bannerheader">
                            ${document.title?html}
                        </h3>
                    </#if>

                </div>
                <div>
                    <#if document.subtitle?? && document.subtitle?has_content>
                        <h4 class="subheader">
                            ${document.subtitle?html}
                        </h4>
                    </#if>
                </div>
                <div class="banner-div-separator">
                    <#if document.content?? && document.content?has_content>
                        <p class="content-p">
                            <@hst.html hippohtml=document.content/>
                        </p>
                    </#if>
                </div>
                <div class="btn-holder">
                    <#if document.bannerLink?? && document.bannerLink.linkCaption?has_content>
                        <#assign link><@osudio.linkUrl link=document.bannerLink /></#assign>
                        <button class="btn btn-tertiary mr-10 btn-banner-white">
                            <a href="${link}" class="btn-banner-white" target="_blank">${document.bannerLink.linkCaption}</a>
                        </button>
                    </#if>
                </div>
            </div>
            <#if document.videoID?? && document.videoID?has_content>
            <#assign videoDivID = "video" + document.name>
            <script>
                 var obj = {videoDivId: '${videoDivID}', videoID: '${document.videoID}'};

                if (typeof idsArray !== 'undefined') {
                    idsArray.push(obj);
                } else {
                    var idsArray = [obj];
                }
            </script>
            <div class="video-foreground">
                <div id="${videoDivID}" class="banner-img" style="cursor: default;"></div>
            </div>
           <#elseif document.image??>
               <@hst.link var="img" hippobean=document.image.inline/>
            <div class="video-foreground">
               <img src="${img}" class="banner-img" title="${document.title}" alt="<@osudio.altTag document=document />"/>
            </div>
           </#if>
       </div>
    </div>
    <#else>
    <#if isBlueColor>
        <div class="container-fluid banner-blue banner-nomargin <#if hideMobile == true>d-none d-sm-block</#if>">
    <#else>
        <div class="container-fluid banner-white banner-nomargin <#if hideMobile == true>d-none d-sm-block</#if>">
    </#if>
        <div class="row banner-nomargin">
            <#if document.videoID?? && document.videoID?has_content>
            <#assign videoDivID = "video" + document.name>
            <script>
                 var obj = {videoDivId: '${videoDivID}', videoID: '${document.videoID}'};

                if (typeof idsArray !== 'undefined') {
                    idsArray.push(obj);
                } else {
                    var idsArray = [obj];
                }
            </script>
            <div class="video-foreground">
                <div id="${videoDivID}" class="banner-img" style="cursor: default;"></div>
            </div>
           <#elseif document.image??>
               <@hst.link var="img" hippobean=document.image.inline/>
            <div class="video-foreground">
               <img src="${img}" class="banner-img" title="${document.title}" alt="<@osudio.altTag document=document />"/>
            </div>
           </#if>
		   <div class="banner-div-main banner-div-main-right">
                <div>
                    <#if document.title?? && document.title?has_content>
                        <h2 class="bannerheader">
                            ${document.title?html}
                        </h2>
                    </#if>

                </div>
                <div>
                    <#if document.subtitle?? && document.subtitle?has_content>
                        <h4 class="subheader">
                            ${document.subtitle?html}
                        </h4>
                    </#if>
                </div>
                <div class="banner-div-separator">
                    <#if document.content?? && document.content?has_content>
                        <p class="content-p">
                            <@hst.html hippohtml=document.content/>
                        </p>
                    </#if>
                </div>
                <div class="btn-holder">
                    <#if document.bannerLink?? && document.bannerLink.linkCaption?has_content>
                        <#assign link><@osudio.linkUrl link=document.bannerLink /></#assign>
                        <#if isBlueColor>
                        <button class="btn btn-tertiary mr-10 btn-banner-white">
                            <a href="${link}" class="a-banner-white" target="_blank">${document.bannerLink.linkCaption}</a>
                        </button>
                        <#else>
                        <button class="btn btn-tertiary mr-10 btn-banner-blue">
                            <a href="${link}" class="a-banner-blue" target="_blank">${document.bannerLink.linkCaption}</a>
                        </button>
                        </#if>
                    </#if>
                </div>
            </div>
       </div>
    </div>
    </#if>
<#elseif editMode>
 <div>
     <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit Banner
 </div>
</#if>

<script>

</script>






