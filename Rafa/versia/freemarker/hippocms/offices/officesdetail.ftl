<#include "../../include/imports.ftl">

<@hst.setBundle basename="local-offices"/>

<div class="container" id="news-detail" data-title="${document.title}">
  <#if document??>
      <div class="row">
          <div class="col-md-6">
              <div class="image-header">
                  <#if document.image??>
                      <img src="<@hst.link hippobean=document.image.small/>" alt="${document.title?html}" />
                  </#if>
              </div>
              <div class="details-distributor">
                  <h2 class="heading-07">${document.title}</h2>
                  <p><i class="faicon fas fa-map-marker-alt fa-sm"></i> <#list document.address as address>${address}<br></#list> ${document.postalCode} ${document.city} <br>${document.country}
                      <#if document.telephone?has_content>
                          <br><a href="tel:${document.telephone}"><i class="faicon fas fa-phone fa-sm"></i> ${document.telephone}</a>
                      </#if>
                      <#if document.fax?has_content>
                          <br><i class="faicon fas fa-fax fa-sm"></i> ${document.fax}
                      </#if>
                      <#if document.website?has_content>
                          <br><a href="${document.website?starts_with("http")?then(document.website, "http://" + document.website)}" target="_blank"><i class="faicon fas fa-globe fa-sm"></i> ${document.website}</a>
                      </#if>
                       <#if document.email?has_content>
                          <br><a href="mailto:${document.email}"><i class="icon-mail icon"></i> ${document.email}</a></p>
                       </#if>
              </div>
          </div>
          <#if document.latitude?? && document.latitude?has_content && document.longitude?? && document.longitude?has_content>
              <div class="col-md-6 smc-sidebar">
                  <div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
              </div>
          </#if>
      </div>
      <hr style="border: none; border-bottom: 1px solid #007bff; margin: 27px 0;">
      <div class="row">
          <div class="col-md-6">
              <@hst.setBundle basename="local-offices"/>
              <h5><b><@fmt.message key="offices.title.sectors" /></b></h5>
              <#if document.sectors?? && document.sectors?has_content>
                  <@printOfficeValueList document.sectors />
              </#if>
          </div>
          <div class="col-md-6">
              <@hst.setBundle basename="local-offices"/>
              <h5><b><@fmt.message key="offices.title.services" /></b></h5>
              <#if document.services?? && document.services?has_content>
                  <@printOfficeValueList document.services />
              </#if>
          </div>
      </div>
  </#if>
</div>

<#macro printOfficeValueList list>
    <ul class="list-sectores">
        <@hst.setBundle basename="facets"/>
        <#list list as element>
            <#assign elementName><@fmt.message key="facet.label.${element}" /></#assign>
            <li><i class="icon-valid" ></i>${elementName?contains("???")?then(element, elementName)}</li>
        </#list>
    </ul>
</#macro>

<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/lister&detail-pages.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
<script>
    // Initialize and add the map
    function initMap() {
        var position = {lat: ${document.latitude}, lng: ${document.longitude}};
        var map = new google.maps.Map(document.getElementById('map'), {zoom: 13, center: position});
        var marker = new google.maps.Marker({position: position, map: map});
    }

    $( document ).ready(function() {
        initMap();
    });
</script>
</@hst.headContribution>