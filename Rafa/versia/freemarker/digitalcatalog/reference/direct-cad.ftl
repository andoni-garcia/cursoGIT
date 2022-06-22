<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<@hst.setBundle basename="essentials.global,SmartQuotations"/>
<section class="row" >
    <div class="container">
        <div class="col-12" >
            <h1 class="heading-03 color-blue"
                data-swiftype-index='false'><@fmt.message key="smartQuotations.directCad" /> </h1>
            <p><@fmt.message key="smartQuotations.requestedCad" /> ${partNumber}<#if rodEndConf?has_content>, <@fmt.message key="smartQuotations.requestedRodEnd" />${rodEndConf}</#if></p>
            <p><@fmt.message key="smartQuotations.requestedFormat" /> ${format}</p>
            <#if hstRequest.getParameter("STATUS") == "OK">
                <p><@fmt.message key="smartQuotations.cadFound" /> <a id="cad_link" target="_blank" href="${hstRequest.getParameter("cadUrl")}"><@fmt.message key="smartQuotations.here" /></a></p>
            <#else>
                <p><@fmt.message key="smartQuotations.cadNotFound" /></p>
            </#if>
        </div>
    </div>
</section>
<@hst.headContribution category="htmlBodyEnd">
<script type="text/javascript">
    $(document).ready(function() {
        var curLink = "${hstRequest.getParameter("cadUrl")}";
        if (curLink !== ""){
            $("#cad_link")[0].click();
            setTimeout(window.top.close(),5000);
        }
    });
</script>
</@hst.headContribution>