<#include "../../include/imports.ftl">
<@hst.setBundle basename="SearchPage,SearchBar,ParametricSearch"/>
<div class="container">
    <div id="root-filter">
        <form name="manualsListForm" id="manualsListForm" class="row">
            <div class="form-group col-md-10">
                <@hst.include ref="search-bar" >
                    <div class="input-group search-bar-input-container" id="manual-search-container">
                        <input class="form-control query" id="query" name="query" type="text"
                               placeholder="<@fmt.message key="searchbar.input.placeholder" />" value="${hstRequestContext.servletRequest.getParameter("query")}"/>
                        <span id="searchbutton" class="icon-search" onclick ="javascript:submitSearch();"></span>
                    </div>
                </@hst.include>
            </div>
            <div class="form-group col-md-2">
                <@hst.renderURL var="pageUrlReset">
                    <@hst.param name="page" value="1"/>
                    <@hst.param name="pageSize" value="10"/>
                    <@hst.param name="query" value=""/>
                </@hst.renderURL>
                <button type="submit" class="hidden"/>
                <button type="button" class="btn btn-primary btn-full "
                        onclick="javascript:resetManual('100');"><@fmt.message key="psearch.reset" /></button>
                <a id="hrefReload" class="btn btn-primary btn-full hidden"
                   href="${pageUrlReset}"><@fmt.message key="psearch.reset" /></a>
            </div>
            <#if pageable??>
                <#if (pageable.total > 0) >
                    <div class="col-md-12 manual-pagination-container">
                        <div class="col-lg-12 p-0 ">
                            <div class="row pagination_showing align-items-center">
                                <div class="col-md-4 mt-10 mt-lg-0 text-center text-md-left">
                                    <@fmt.message key="search.searchresult.paging.showing"/>
                                    <span class="js-search-init-page-number">${((pageable.currentPage - 1) * pageable.pageSize) + 1 }</span>
                                    <@fmt.message key="search.searchresult.paging.to"/>
                                    <#if (pageable.total > (pageable.currentPage * (pageable.pageSize + 1)) )>
                                        <span class="js-search-finish-page-number">${(((pageable.currentPage - 1) * pageable.pageSize) +  pageable.pageSize )}</span>
                                    <#else>
                                        <span class="js-search-finish-page-number">${pageable.total}</span>
                                    </#if>
                                    <@fmt.message key="search.searchresult.paging.of"/>
                                    <span class="js-search-total">${pageable.total}</span>
                                    <@fmt.message key="search.searchresult.paging.entries"/>
                                </div>
                                <div class="col-md-4 text-center mt-10 mt-lg-0 d-none d-sm-block">
                                    <@fmt.message key="search.searchresult.paging.display"/>
                                    <#if pageable.pageSize == 10 >
                                        <span data-section='product_catalogue' class="changelen" data-len="10"
                                              href="#">10</span> |
                                    <#else>
                                        <@hst.renderURL var="pageUrl10">
                                            <@hst.param name="page" value="1"/>
                                            <@hst.param name="pageSize" value="10"/>
                                            <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                        </@hst.renderURL>
                                        <a data-section='product_catalogue' class="changelen" data-len="10"
                                           href="${pageUrl10}" onmousedown="javascript:resetManual('10');">10</a> |
                                    </#if>
                                    <#if pageable.pageSize == 20 >
                                        <span data-section='product_catalogue' class="changelen" data-len="20"
                                              href="#">20</span> |
                                    <#else>
                                        <@hst.renderURL var="pageUrl20">
                                            <@hst.param name="page" value="1"/>
                                            <@hst.param name="pageSize" value="20"/>
                                            <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                        </@hst.renderURL>
                                        <a data-section='product_catalogue' class="changelen" data-len="20"
                                           href="${pageUrl20}" onmousedown="javascript:resetManual('20');">20</a> |
                                    </#if>
                                    <#if pageable.pageSize == 50 >
                                        <span data-section='product_catalogue' class="changelen" data-len="50"
                                              href="#">50</span> |
                                    <#else>
                                        <@hst.renderURL var="pageUrl50">
                                            <@hst.param name="page" value="1"/>
                                            <@hst.param name="pageSize" value="50"/>
                                            <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                        </@hst.renderURL>
                                        <a data-section='product_catalogue' class="changelen" data-len="50"
                                           href="${pageUrl50}" onmousedown="javascript:resetManual('50');">50</a> |
                                    </#if>
                                    <#if pageable.pageSize == 100 >
                                        <span data-section='product_catalogue' class="changelen" data-len="100"
                                              href="#">100</span>
                                    <#else>
                                        <@hst.renderURL var="pageUrl100">
                                            <@hst.param name="page" value="1"/>
                                            <@hst.param name="pageSize" value="100"/>
                                            <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                        </@hst.renderURL>
                                        <a data-section='product_catalogue' class="changelen" data-len="100"
                                           href="${pageUrl100}" onmousedown="javascript:resetManual('100');">100</a>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                <#else>
                    <#if !query?has_content >
                        <div class="searchResult text-center m-auto p-5">
                            <div class="col align-self-center"><@fmt.message key="psearch.noresultsfound"/></div>
                        </div>
                    <#else>
                        <div class="searchResult text-center m-auto p-5">
                            <p>
                                <span><@fmt.message key="search.searchresult.begin.text"/> </span>
                                <span id="searchResultText" class="search-query"> "${query}" </span>
                                <span> <@fmt.message key="search.searchresult.middle.text"/> </span>
                                <span id="searchResultNumber" class="search-query"> 0 </span>
                                <span> <@fmt.message key="search.searchresult.end.text"/></span>
                            </p>
                        </div>
                    </#if>
                </#if>
            </#if>
        </form>
    </div>

    <#if (pageable?? && (pageable.total > 0)) || !pageable?? >
        <div id="root-table">
            <div>
                <form class="row hidden">
                    <div class="form-group col-md-10"><input type="text" class="form-control"
                                                             placeholder="Search for..." value="">
                        <div class="search-inpage__submit"><span class="icon-close"></span>
                        </div>
                    </div>
                    <div class="form-group col-md-2">
                        <button type="submit" class="btn btn-primary btn-full">Reset</button>
                    </div>
                </form>
                <div class="row">
                    <div class="col-md-12">
                        <table class="content-lister__resultsTable tabla-descargas table-sistemalist">
                            <thead>
                            <tr>
                                <#list manualsData.headers?keys as key>
                                    <#if key == "models">
                                        <#if sortDirection == "desc">
                                            <th class="headerSortDown"><span>${manualsData.headers[key]}</span></th>
                                        <#else>
                                            <th class="headerSortUp"><span>${manualsData.headers[key]}</span></th>
                                        </#if>
                                    <#else>
                                        <th class="content-lister__resultsTable--noSort"><span>${manualsData.headers[key]}</span></th>
                                    </#if>
                                </#list>
                            </tr>
                            </thead>
                            <tbody>
                            <a target = "_blank" class ="hidden" id="baseDownloadLink" href ="">fakeLink</a>
                            <#list manualsData.items as item>
                                <tr>
                                    <#--                                    <#list manualsData.headers?keys as value>-->
                                    <#--                                        <td>-->
                                    <#--                                            <#assign my_variable = "item." + value>-->
                                    <#--                                            <#if my_variable?eval[0]?contains("ManualDocumentData")>-->
                                    <#--                                                <#if my_variable?eval?counter gt 0>-->
                                    <#--                                                    <#assign documentList = my_variable?eval/>-->
                                    <#--                                                    <#include "document-lang-element.ftl" >-->
                                    <#--                                                </#if>-->
                                    <#--                                            <#else>-->
                                    <#--                                                ${my_variable?eval}-->
                                    <#--                                            </#if>-->
                                    <#--                                        </td>-->
                                    <#--                                    </#list>-->

                                    <td data-column-title="${manualsData.headers["models"]}">
                                        <#assign currentModel = item.models />
                                        ${item.models}
                                    </td>
                                    <td data-column-title="${manualsData.headers["description"]}">
                                        ${item.description}
                                    </td>
                                    <td data-column-title="${manualsData.headers["instructionmanuals"]}">
                                        <#assign documentList = item.instructionmanuals/>
                                        <#assign documentType = "INSTRUCTIONS MAINTENANCE"/>
                                        <#include "document-lang-element.ftl" >
                                    </td>
                                    <td data-column-title="${manualsData.headers["declarationofconformities"]}">
                                        <#assign documentList = item.declarationofconformities/>
                                        <#assign documentType = "CE CERTIFICATE"/>
                                        <#include "document-lang-element.ftl" >
                                    </td>
                                    <td data-column-title="${manualsData.headers["reliabilitydatas"]}">
                                        <#assign documentList = item.reliabilitydatas/>
                                        <#assign documentType = "RELIABILITY DATA"/>
                                        <#include "document-login-required-lang-element.ftl" >
                                    </td>
                                    <td data-column-title="${manualsData.headers["drawings"]}">
                                        <#assign documentList = item.drawings/>
                                        <#assign documentType = "DRAWINGS"/>
                                        <#include "document-login-required-lang-element.ftl" >
                                    </td>
                                </tr>
                            </#list>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </#if>

    <div class="manual-pagination-container pagination-container align-items-center">
        <#include "../../include/pagination_manuals.ftl">
    </div>

</div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->

<#--<@hst.headContribution category="htmlBodyEnd">-->
<#--    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/jquery.tablesorter.js"/>"></script>-->
<#--</@hst.headContribution>-->

<script>
    $(function () {
        // $('.content-lister__resultsTable').addClass('tabla-descargas');
        window.smc = window.smc || {};
        $("#root form").addClass("hidden");

        $(".table-sistemalist th:not(.content-lister__resultsTable--noSort)").click(function (e) {
            if (this.className === "headerSortDown") {
                window.location.href = updateURLParameter(window.location.href, "sort", "asc");
            } else {
                window.location.href = updateURLParameter(window.location.href, "sort", "desc");
            }
        });

        var url = removeURLParameter("action", window.location.href);
        url = removeURLParameter("termsOfUse", url);
        url = removeURLParameter("privacyStatement", url);
        window.history.pushState({}, document.title, url);

        // // Remove unwanted parameters from changelen elements
        // if ($("a.changelen").attr("href")) {
        //     $("a.changelen").attr("href", removeURLParameter("action", $("a.changelen").attr("href")));
        //     $("a.changelen").attr("href", removeURLParameter("termsOfUse", $("a.changelen").attr("href")));
        //     $("a.changelen").attr("href", removeURLParameter("privacyStatement", $("a.changelen").attr("href")));
        // }

        if (window.smc.isAuthenticated){
            setTimeout(function(){
                var previouslySelectedItem = getUrlParameter("selectedLink");
                if (previouslySelectedItem !== undefined && previouslySelectedItem !== ""
                    && $("#"+previouslySelectedItem) !== undefined){
                    $("#"+previouslySelectedItem).get(0).click();
                    removeURLParameter("selectedLink", window.location.href);
                    var curUrl = window.location.href.replace(window.location.search,'');
                    window.history.pushState({}, document.title, curUrl);
                }
            },500);
        }
    });

    function resetManual(newPageSize) {
        $(".query").val('');
        $("#query").val('');
        $("#pageSizeAux").val(newPageSize);
        var resetLocation = $("#hrefReload").attr("href").split("?")[0];
        window.location.href = resetLocation;
    }

    function updateURLParameter(url, param, paramVal){
        var newAdditionalURL = "";
        var tempArray = url.split("?");
        var baseURL = tempArray[0];
        var additionalURL = tempArray[1];
        var temp = "";
        if (additionalURL) {
            tempArray = additionalURL.split("&");
            for (var i=0; i<tempArray.length; i++){
                if(tempArray[i].split('=')[0] != param){
                    newAdditionalURL += temp + tempArray[i];
                    temp = "&";
                }
            }
        }

        var rows_txt = temp + "" + param + "=" + paramVal;
        return baseURL + "?" + newAdditionalURL + rows_txt;
    }

    function removeURLParameter(key, sourceURL) {
        var rtn = sourceURL.split("?")[0],
            param,
            params_arr = [],
            queryString = (sourceURL.indexOf("?") !== -1) ? sourceURL.split("?")[1] : "";
        if (queryString !== "") {
            params_arr = queryString.split("&");
            for (var i = params_arr.length - 1; i >= 0; i -= 1) {
                param = params_arr[i].split("=")[0];
                if (param === key) {
                    params_arr.splice(i, 1);
                }
            }
            rtn = rtn + "?" + params_arr.join("&");
        }
        return rtn;
    }

    function redirectToLoginForDoc(documentURLToDownload, selectedLink){
        var globalConfig = window.smc;
        if (!globalConfig.isAuthenticated){
            url = removeURLParameter("action", window.location.href);
            url = removeURLParameter("fileName",url);
            url = removeURLParameter("documentType",url);
            url = removeURLParameter("models",url);
            url = removeURLParameter("selectedLink",url);
            url = updateURLParameter(url, "selectedLink",selectedLink.id);
            var showManualDownloadUrlStandaloneUrl = generateSecuredAction("sistemaLibraryListComponent",'redirectToLoginForDoc',url, []);
            window.parent.location = showManualDownloadUrlStandaloneUrl;
            window.history.pushState({}, window.document.title, showManualDownloadUrlStandaloneUrl.toString());
            return;
            /*
            var showCadDownloadUrlStandaloneUrl = generateSecuredAction(productConfiguratorComponentId, 'showProductConfiguratorCadDownload', url.url, [this.config.productId, this.getPartNumber()]);
            showCadDownloadUrlStandaloneUrl.searchParams.set('modalProductId', this.config.productId);
            window.parent.location = showCadDownloadUrlStandaloneUrl;
            window.history.pushState({}, window.document.title, showCadDownloadUrlStandaloneUrl.toString());
            return;
             */
        }
    }

    function downloadFile(documentURLToDownload,documentType,currentModel){
        var url = removeURLParameter("action", window.location.href);
        url = removeURLParameter("fileName",url);
        url = removeURLParameter("documentType",url);
        url = removeURLParameter("models",url);
        var fileName = documentURLToDownload;
        if (fileName !== undefined && fileName.toString().indexOf("/") >= 0){
            fileName = fileName.toString().substring(fileName.toString().lastIndexOf("/") +1);
        }
        $.getJSON(url,{action:"download_manual",fileName: fileName,documentType: documentType, models: currentModel})
            .then(function (response) {
                console.log("Download Recorded");
        });
        var baseLink = $("#baseDownloadLink");
        $(baseLink).attr("href",documentURLToDownload);
        $(baseLink).get(0).click();
        $(baseLink).attr("href","");
    }

    function generateSecuredAction(componentId, actionName, currentUrl, actionParams) {
        var url = new URL(currentUrl);
        var keysIterator = url.searchParams.keys();
        var key = keysIterator.next();
        while (key && key.value) {
            if (key.value.indexOf('_hn') === 0 || key.value.indexOf('ajax') === 0) url.searchParams.delete(key.value);
            key = keysIterator.next();
        }
        return secureResourceUrl(url);
    }

    function secureResourceUrl(url) {
        var securedResourceUrl = new URL(url.origin + smc.channelPrefix + '/secured-resource');
        securedResourceUrl.searchParams.set('resource', url.toString().replace(url.origin, ''));
        return securedResourceUrl;
    }

    function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;
        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    }

    function submitSearch() {
        $("#manualsListForm").submit();
    }

</script>