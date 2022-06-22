<#include "../../include/imports.ftl">

<#if document??>
    <div class="container">
          <div class="cmseditlink">
               <@hst.manageContent hippobean=document/>
          </div>
          <div class="separator"></div>
          <div class="row">
            <div class="col-md-6">
                <#if document.title??><h2 class="heading-04">${document.title?html}</h2></#if>
                <ul class="list-unstyled mb-0">
                    <#if document.address??>
                        <li class="pl-4"><#list document.address as address>${address}<br></#list></li>
                    </#if>
                    <#if document.telephone??><li><a href="tel:${document.telephone}"><i class="faicon fas fa-phone fa-sm mr-1"></i> ${document.telephone}</a></li></#if>
                    <#if document.locationText??><li><button onclick="initMap()" class="btn-unstyled"><i class="faicon fas fa-map-marker-alt fa-sm mr-1"></i> ${document.locationText}</button></li></#if>
                </ul>
            </div>
            <div class="col-md-6">
                <#if document.latitude?? && document.latitude?has_content && document.longitude?? && document.longitude?has_content>
                    <div id="map" style="width:400px;height:250px"></div>
                </#if>
            </div>
         </div>
         <div class="separator"></div>
         <#if document.contactTeam??>
             <div class="row">
                <#list document.contactTeam as contactTeam>
                    <#if contactTeam.title?has_content>
                        <div class="col-sm-6">
                            <h2 class="heading-04">${contactTeam.title}</h2>
                            <p> <a href="tel:${contactTeam.telephone!}"><i class="faicon fas fa-phone fa-sm mr-1"> </i> ${contactTeam.telephone!}</a></p>
                            <p><a href="mailto:${contactTeam.email!}"><i class="faicon fas fa-envelope fa-sm mr-1"></i> ${contactTeam.email!}</a></p>
                        </div>
                    </#if>
                </#list>
             </div>
         </#if>
    </div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/simple-content.png" />"> Click to edit Contact Component
  </div>
</#if>
<@hst.headContribution category="htmlBodyEnd">
<script>
    // Initialize and add the map
    function initMap() {
        var position = {lat: ${document.latitude}, lng: ${document.longitude}};
        var map = new google.maps.Map(document.getElementById('map'), {zoom: 13, center: position});
        var marker = new google.maps.Marker({position: position, map: map});
    }
</script>
</@hst.headContribution>