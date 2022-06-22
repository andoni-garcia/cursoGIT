<#include "../../include/imports.ftl">

<@hst.setBundle basename="local-offices,SearchPage,SearchBar,ParametricSearch"/>


<main class="smc-main-container">
    <div class="container">
        <h2 class="heading-08 color-blue mt-20">
            ${pagetitle?html!}
        </h2>
        <div>
          <@hst.include ref="facets"/>
          <@hst.include ref="content"/>
        </div>
    </div>
</main>
