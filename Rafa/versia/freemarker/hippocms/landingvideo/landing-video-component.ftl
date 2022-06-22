<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Banner" -->

<#if document??>

    <div class="container-fluid container-landingvideo <#if hideMobile == true>d-none d-sm-block</#if>" style="padding-left: 0;margin-left:0;">
        <div class="row">
            <div class="col col-xs-12 col-md-12 banner-nomargin" >
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
                <div class="landing-video-container allowphone" style="position:absolute; z-index: 1;">
                    <div class="more-content" data-swiftype-index='false'>
                        <span class="more-content__button">
                            <i class="more-content__button__icon fas fa-angle-double-down"></i>
                        </span>
                    </div>
                </div>
                <div class="landing-video-container" style="cursor: default;">
                    <div id="${videoDivID}" style="pointer-events: none, cursor: default;"></div>
                </div>
                </#if>
           </div>
       </div>
    </div>
    <#elseif editMode>
     <div>
         <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit video
     </div>
</#if>

<script>
$(window).scroll(function() {
  if ($(this).scrollTop() > 0) {
    $('.more-content').css({"opacity":"0","transition":"1s"});
  } else {
    $('.more-content').css({"opacity":"1","transition":"1s"});
  }
});

</script>






