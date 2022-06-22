<#include "../../include/imports.ftl">

<@hst.setBundle basename="subsidiaries"/>

<main class="smc-main-container">
    <div class="container">
        <h2 class="heading-08 color-blue mt-20">
            <@fmt.message key="subsidiaries.title"/>
        </h2>
        <h1 class="heading-02 heading-main">
            <@fmt.message key="subsidiaries.subtitle"/>
        </h1>
        <div class="text-01">
            <@fmt.message key="subsidiaries.text"/>
        </div>
        <div>
          <@hst.include ref="content"/>
        </div>
    </div>
</main>
