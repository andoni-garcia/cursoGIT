<#include "../../include/imports.ftl">
<#include "../../digitalcatalog/catalog-macros.ftl">
<#include "../../digitalcatalog/product/product-toolbar-macro.ftl">
<@hst.setBundle basename="SearchPage,SearchBar,ProductToolbar,eshop"/>

<@productToolbar product=node boxTitle="eshop.moreInfo" renderingMode="simple" partNumber=partNumber statisticsSource="BASKET"/>
