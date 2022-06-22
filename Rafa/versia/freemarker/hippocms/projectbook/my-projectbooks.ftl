<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.webfile var="noImage" path='/images/nodisp3_big.png'/>

<@hst.setBundle basename="eshop"/>

<@security.authentication property="principal.companyName" var="principalName" />
<@security.authentication property="principal.fullName" var="principalFullname" />
</#compress>

<div class="container">
    <div class="mb-30">
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
    <div class="cmseditlink">
    </div>
    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="projectbooks.myprojectbooks.title"/></h2>
</div>

<br>
<div class="container" id="contenedor">
    <ul class="row">
    <#list projectBooks as projectbook>
        <div class="col-12 col-md-6">
            <div class="border border-secondary eshop-box-rounded p-3 d-flex mt-3 mr-3" >
                <a class="other-pb-ref" href="/projectbook?projectBook=${projectbook.id}">
                    <#if projectbook.hasLogo>
                        <img src="${s3bucket}project-books/${projectbook.id}/logo.jpg" width="80" height="80">
                    <#else>
                        <img src="${noImage}" width="80" height="80">
                    </#if>
                </a> 
                <div class="mt-3 ml-10">
                    <a class="other-pb-ref" href="/projectbook?projectBook=${projectbook.id}">${projectbook.name}</a> 
                    <p class="text-muted"> ${projectbook.company}</p>
                </div>
            </div>
        </div>
    </#list>
    </ul>
</div>

<@hst.headContribution category="scripts"> 
 <script type="text/javascript">

	$(document).ready(function() {
       
        $('.other-pb-ref').each(function(){
            var currentHref = $(this).attr('href');
            $(this).attr('href',smc.channelPrefix+currentHref);
        });

	});
</script>
</@hst.headContribution> 
