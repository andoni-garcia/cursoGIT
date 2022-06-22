<#include "../../include/imports.ftl">

<@hst.setBundle basename="component.newslist"/>

<div class="container" id="news-detail" data-title="${document.title}">
  <#if document??>
      <div class="row">
          <div class="col-md-8">

              <#if document.image??>
                  <div class="mb-5">
                    <picture>
                        <source media="(min-width: 768px)" srcset="<@hst.link hippobean=document.image.large/>">
                        <img src="<@hst.link hippobean=document.image.medium/>" alt="${document.title?html}" class="img-fluid">
                    </picture>
                  </div>
              </#if>
              <div class="mb-5">
                  <@hst.link var="link" hippobean=document/>
                  <h1 class="heading-03 color-blue same-size">${document.title?html}</h1>
                  <h4 class="heading-07 mb-4">${document.introduction?html}</h4>
                  <@hst.html hippohtml=document.content/>
                  <#if document.date??>
                      <@fmt.setLocale value="${hstRequest.locale.language}"/>
                      <span> <@fmt.formatDate value=document.date.time /></span>
                  </#if>
              </div>
              <#if document.relatedDocuments?? && document.relatedDocuments?has_content>
                  <section class="news-releases">
                      <div class="news-releases-item">
                          <h2 class="heading-07"><@fmt.message key="news.detail.related.title" /></h2>
                          <div class="separator my-4"></div>
                          <#list document.relatedDocuments as relatedDoc>
                              <div class="row">
                                  <#if relatedDoc.image??>
                                      <div class="col-6 col-sm-3 ">
                                          <a href="<@hst.link hippobean=relatedDoc />" class="">
                                              <@hst.link var="img" hippobean=relatedDoc.image.medium/>
                                              <img src="${img}" class="thumb-new img-fluid mb-2" alt="${relatedDoc.title?html}" />
                                          </a>
                                              </div>
                                              <div class="col-sm-9">
                                                  <a href="<@hst.link hippobean=relatedDoc />" class="font-weight-bold">
                                                      <span>${relatedDoc.title}</span>
                                                  </a>
                                                  <p class="small">${relatedDoc.introduction}</p>
                                                  <a href="<@hst.link hippobean=relatedDoc />" class="font-weight-bold small"><@fmt.message key="link.read.more" /> <i class="icon-arrow-right"></i></a>
                                              </div>
                                          <#else>
                                      <div class="col-12">
                                          <a href="<@hst.link hippobean=relatedDoc />" class="font-weight-bold">
                                              <span>${relatedDoc.title}</span>
                                          </a>
                                          <p class="small">${relatedDoc.introduction}</p>
                                          <a href="<@hst.link hippobean=relatedDoc />" class="font-weight-bold small"><@fmt.message key="link.read.more" /> <i class="icon-arrow-right"></i></a>
                                      </div>
                                  </#if>
                              </div>
                              <#if relatedDoc_has_next><div class="separator"></div></#if>
                          </#list>
                      </div>
                  </section>
              </#if>
          </div>
          <div class="col-md-4 smc-sidebar">
              <#if document.pdf?? && document.pdf.linkCaption?length gt 0>
                  <div class="sub_container">
                      <div class="cta-box-list">
                        <div class="cta-box">
                            <a href="<@osudio.linkUrl link=document.pdf />" class="btn btn-primary mr-10" <@osudio.openInNewTab document.pdf.externalLink/>>${document.pdf.linkCaption?html}</a>
                        </div>
                      </div>
                  </div>
              </#if>
              <#if document.annexes?? && document.annexes?has_content && document.annexes?first.linkCaption?has_content>
                <div class="sub_container">
                  <div class="info-box ">
                      <div class="info-box__head">
                          <h2 class="heading-07"><@fmt.message key="news.detail.annexes.title" /></h2>
                      </div>
                      <div class="info-box__body text-01">
                          <ul class="empty-list">
                            <#list document.annexes as resource>
                                <#assign title><#if resource.linkCaption?? && resource.linkCaption?length gt 0>${resource.linkCaption}<#else>${resource.internalLink.name}</#if></#assign>
                                <li>
                                    <#assign link><@osudio.linkUrl link=resource /></#assign>
                                    <a href="${link}" <@osudio.handleFileOpening downloadableFileExtensions link title />  class="iconed-text">
                                        <span>${title}</span>
                                        <#if resource.icon??><img src="<@hst.link hippobean=resource.icon.original/>"><#else><i class="faicon fas fa-download fa-sm"></i></#if>
                                    </a>
                                </li>
                            </#list>
                          </ul>
                      </div>
                  </div>
                </div>
              </#if>
          </div>
      </div>
  </#if>
</div>

<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/lister&detail-pages.js"/>"></script>
</@hst.headContribution>