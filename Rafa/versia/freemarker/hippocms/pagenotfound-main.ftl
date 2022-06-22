<#include "../include/imports.ftl">

<@hst.setBundle basename="errorpages"/>

<main class="smc-main-container page-error page-error_404" data-swiftype-index='false'>
    <div class="container">
        <h1 class="heading-02 heading-main"><@fmt.message key="pagenotfound.title" var="title"/>${title?html}</h1>
        <p><@fmt.message key="pagenotfound.text"/><#--Skip XML escaping--></p>
        <div>
          <@hst.include ref="content"/>
        </div>
    </div>
</main>
