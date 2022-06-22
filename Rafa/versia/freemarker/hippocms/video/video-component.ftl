<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Video" -->
<#if document??>
<div class="container" id="${document.getCanonicalHandleUUID()}">
  <div class="cmseditlink">
           <@hst.manageContent hippobean=document/>
  </div>
  <div <#if document.description??>class="video-with-caption"</#if>>
    <#if document.title??>
      <h2 class="heading-04">${document.title?html}</h2>
    </#if>

    <div class="video-component">
        <div class="video-component__content">
            <#if document.videoSource?? && document.videoSource?has_content>
                <#if document.videoSource="Youtube">
                    <iframe width="560" height="315" src="https://www.youtube.com/embed/${document.videoID}" frameborder="0" allowfullscreen></iframe>
                <#elseif document.videoSource="Vimeo">
                    <iframe width="560" height="315" src="https://player.vimeo.com/video/${document.vimeoVideoID}" frameborder="0" allowfullscreen></iframe>
                </#if>
            <#else>
                <#if document.videoID?? && document.videoID?has_content>
                    <iframe width="560" height="315" src="https://www.youtube.com/embed/${document.videoID}" frameborder="0" allowfullscreen></iframe>
                <#elseif document.vimeoVideoID?? && document.vimeoVideoID?has_content>
                    <iframe width="560" height="315" src="https://player.vimeo.com/video/${document.vimeoVideoID}" frameborder="0" allowfullscreen></iframe>
                </#if>
            </#if>
        </div>
    </div>
      <#if document.logActions?? && document.logActions == true>
          <input type="hidden" id="${document.getCanonicalHandleUUID()}_logRegisterLink"  action-logged="false" smc-content-statistic-action="CLICK ON COMPONENT" smc-statistic-source="VIDEO CONTENT" smc-statistic-data2="${document.title}"/>
          <script>
              $(document).ready(function () {
                  $("#${document.getCanonicalHandleUUID()}_logRegisterLink").attr("smc-statistic-data1", window.location.href);
                  var overiFrame = -1;
                  $("#${document.getCanonicalHandleUUID()} iframe").hover( function() {
                      overiFrame = $(this).closest('.banner').attr('bannerid');
                  }, function() {
                      overiFrame = -1
                  });

                  $(window).blur( function() {
                      if( overiFrame != -1 ) {
                          if ($("#${document.getCanonicalHandleUUID()}_logRegisterLink").attr("action-logged") == "false") {
                              $("#${document.getCanonicalHandleUUID()}_logRegisterLink").attr("action-logged", "true");
                              contentlogAction($("#${document.getCanonicalHandleUUID()}_logRegisterLink"), $("#logActionLink").attr("href"));
                          }
                      }
                  });

              });
          </script>
      </#if>
    <#if document.description??>
        <div class="media-caption text-01">${document.description?html}
            <#if document.externalLink??>
               <div class="media-caption__link">
                   <a href="${document.externalLink.url}" <@osudio.openInNewTab document.externalLink.url/>>${document.externalLink.description?html}</a>
               </div>
            </#if>
        </div>
    </#if>
  </div>
</div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/video.png" />"> Click to edit Video Component
  </div>
</#if>
