<#include "../../include/imports.ftl">

<@hst.setBundle basename="subsidiaries"/>
<#if subsidiaries?? && subsidiaries?has_content>
    <section class="sub_container">
        <div class="row">
            <#list subsidiaries?keys as country>
                 <div class="col-md-4">
                     <div class="row">
                         <div class="col-12">
                             <div class="container-country" data-toggle="collapse" aria-expanded="false">
                                <a class="subsidiary-country" style="cursor: pointer"><span>${country}</span></a>
                                <div class="icons-country">
                                    <a class="subsidiary-country" style="cursor: pointer"></a>
                                    <#if subsidiaries[country]?first?has_content && subsidiaries[country]?first.website?has_content>
                                        <a class="www" href="${subsidiaries[country]?first.website}" target="_blank"><i class="fas fa-globe fa-sm"></i></a>
                                    </#if>
                                    <a class="www">
                                        <i class="faicon-dropdown fas fa-chevron-circle-down fa-sm"></i>
                                    </a>
                                </div>
                                <div class="subsidiary-info collapse">
                                     <#list subsidiaries[country] as item>
                                         <ul>
                                             <li><a href="${item.location}" class="link-info" target="_blank"> <i class="icon-location"></i>
                                                <span>
                                                    ${item.name}<br>
                                                     <#list item.address as address>
                                                         ${address?has_next?then(address + "<br>", address)}
                                                     </#list>
                                                 <br>${item.zipCode} ${item.city}</span></a></li>
                                             <li><a href="tel:${item.telephone}" class="link-info"><i class="faicon fas fa-phone fa-sm"></i><span>${item.telephone}</span></a></li>
                                             <li><a href="fax:${item.fax}" class="link-info"><i class="faicon fas fa-fax fa-sm"></i><span>${item.fax}</span></a></li>
                                             <li><a href="mailto:${item.email}" class="link-info"><i class="faicon fas fa-envelope fa-sm"></i><span>${item.email}</span></a></li>
                                         </ul>
                                     </#list>
                                </div>
                             </div>
                         </div>
                     </div>
                 </div>
            </#list>
        </div>
    </section>
</#if>


