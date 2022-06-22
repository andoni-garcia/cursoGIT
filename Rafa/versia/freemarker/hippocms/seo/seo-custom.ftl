<#include "../../include/imports.ftl">

<#if document?? && document.metaTitle?? && document.metaTitle?has_content>
    <@hst.headContribution category="htmlBodyEnd">
        <script>
            document.title = "${document.metaTitle}";
        </script>
    </@hst.headContribution>
</#if>

<#if document?? && document.metaDescription?? && document.metaDescription?has_content>
    <@hst.headContribution category="htmlBodyStart">
        <meta name="Description" content="${document.metaDescription?html}"/>
    </@hst.headContribution>
</#if>

<#if document?? && document.metaKeywords?? && document.metaKeywords?has_content>
    <@hst.headContribution category="htmlBodyStart">
        <meta name="Keywords" content="${document.metaKeywords?html}"/>
    </@hst.headContribution>
</#if>

<#if hstRequest.requestContext.channelManagerPreviewRequest>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/seo.png" />"> Click to edit SEO Component
  </div>
</#if>