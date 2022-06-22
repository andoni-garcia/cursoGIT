<#include "../../include/imports.ftl">
<@hst.link var="linkForCredentials"/>
<#if linkForCredentials?contains("intranet")>
    <#include "../intranet/intranet-credentials.ftl">
</#if>
<@hst.setBundle basename="SearchPage,SearchBar,ParametricSearch"/>
<#if jsonInString?? && jsonInString?has_content>
    <div class="container">
        <div id="root-filter">
            <form name = "manualsListForm" id = "manualsListForm" class="row">
<#--                <#if securedFiles?? && securedFiles == true >-->
<#--                    SECURED FILES ONLY-->
<#--                </#if>-->
                <div class="form-group col-md-10">
                    <@hst.include ref="search-bar" >
                        <div class="input-group search-bar-input-container" id ="manual-search-container">
                            <input class="form-control query" id="query" name="query" type="text" placeholder="<@fmt.message key="searchbar.input.placeholder" />" value="${hstRequestContext.servletRequest.getParameter("query")}"/>
                            <span id ="searchbutton" class="icon-search" onclick ="javascript:submitSearch();"></span>
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
                    <button type ="button" class="btn btn-primary btn-full " onclick="javascript:resetManual('100');"><@fmt.message key="psearch.reset" /></button>
                    <a id ="hrefReload" class ="btn btn-primary btn-full hidden" href = "${pageUrlReset}" ><@fmt.message key="psearch.reset" /></a>
                </div>
                <input id ="pageSize" name="pageSize" type = "text" class="hidden" value ="${pageable.pageSize}" />
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
                                    <div class="col-md-4 text-center mt-10 mt-lg-0 d-none d-sm-block" >
                                        <@fmt.message key="search.searchresult.paging.display"/>
                                        <#if pageable.pageSize == 10 >
                                            <span data-section='product_catalogue' class="changelen" data-len="10" href="#">10</span> |
                                        <#else>
                                            <@hst.renderURL var="pageUrl10">
                                                <@hst.param name="page" value="1"/>
                                                <@hst.param name="pageSize" value="10"/>
                                                <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                            </@hst.renderURL>
                                            <a data-section='product_catalogue' class="changelen" data-len="10" href="${pageUrl10}" onmousedown="javascript:resetManual('10');">10</a> |
                                        </#if>
                                        <#if pageable.pageSize == 20 >
                                            <span data-section='product_catalogue' class="changelen" data-len="20" href="#">20</span> |
                                        <#else>
                                            <@hst.renderURL var="pageUrl20">
                                                <@hst.param name="page" value="1"/>
                                                <@hst.param name="pageSize" value="20"/>
                                                <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                            </@hst.renderURL>
                                            <a data-section='product_catalogue' class="changelen" data-len="20" href="${pageUrl20}" onmousedown="javascript:resetManual('20');">20</a> |
                                        </#if>
                                        <#if pageable.pageSize == 50 >
                                            <span data-section='product_catalogue' class="changelen" data-len="50" href="#">50</span> |
                                        <#else>
                                            <@hst.renderURL var="pageUrl50">
                                                <@hst.param name="page" value="1"/>
                                                <@hst.param name="pageSize" value="50"/>
                                                <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                            </@hst.renderURL>
                                            <a data-section='product_catalogue' class="changelen" data-len="50" href="${pageUrl50}" onmousedown="javascript:resetManual('50');">50</a> |
                                        </#if>
                                        <#if pageable.pageSize == 100 >
                                            <span data-section='product_catalogue' class="changelen" data-len="100" href="#">100</span>
                                        <#else>
                                            <@hst.renderURL var="pageUrl100">
                                                <@hst.param name="page" value="1"/>
                                                <@hst.param name="pageSize" value="100"/>
                                                <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                            </@hst.renderURL>
                                            <a data-section='product_catalogue' class="changelen" data-len="100" href="${pageUrl100}" onmousedown="javascript:resetManual('100');">100</a>
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
                                    <span id="searchResultText" class="search-query"> "${hstRequestContext.servletRequest.getParameter("query")}" </span>
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

            <div id="root">
                <form  class="row">
                </form>
            </div>
            <div class="manual-pagination-container pagination-container align-items-center">
                <#include "../../include/pagination_manuals.ftl">
            </div>

    </div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
    <div id="js--contentLister" style="display:none">${jsonInString}</div>
<#elseif editMode>
    <div>
        <img src="<@hst.link path='/images/essentials/catalog-component-icons/news-list.png'/>"> Click to edit Manuals Component
    </div>
</#if>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/react-with-addons.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/react-dom.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/content-lister.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/jquery.tablesorter.js"/>"></script>
</@hst.headContribution>

<script>

    function checkDownloadAfterLogin() {
        var currentUrl = window.location.href;
        var url = new URL(currentUrl);
        var docUrl = url.searchParams.get("documentUrl");
        if (docUrl !== null && docUrl !== undefined && docUrl !== "") {
            var globalConfig = window.smc;
            if (globalConfig.isAuthenticated){
                window.open(docUrl,'_blank').focus();;
            }
            url.searchParams.delete("documentUrl");
            window.history.pushState({}, window.document.title, url.toString());
        }
    }

    $(function() {
        $('.content-lister__resultsTable').addClass('tabla-descargas');
        $("#root form").addClass("hidden");

        $.each($('.tabla-descargas th span'), function (index, value) {
            $('.tabla-descargas td:nth-child(' + (index + 1) + ') ').attr('data-column-title', $(value).html());
        });

        $.each($('.tabla-descargas a'), function () {
            $(this).addClass("force-download");
            var currentHref = $(this).attr("href");
            $(this).attr("download",currentHref.toString().substring(currentHref.toString().lastIndexOf("/")+1));
        });

        checkDownloadAfterLogin();
    });

    function resetManual(newPageSize){
        $(".query").val('');
        $("#query").val('');
        $("#pageSize").val(newPageSize);
        var resetLocation = $("#hrefReload").attr("href").split("?")[0];
        window.location.href = resetLocation;
    }

    function submitSearch() {
        $("#manualsListForm").submit();
    }

</script>


<#if securedFiles?? && securedFiles == true && !isAuthenticated >
    <@hst.headContribution category="htmlBodyEnd">
        <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/manuals/secured-files.component.js"/>"></script>
    </@hst.headContribution>
    <script>
        $(function () {
            var SecuredFilesComponent = window.smc.SecuredFilesComponent;
            var config = {};
            var securedFilesComponent = new SecuredFilesComponent(config);
            securedFilesComponent.init();
        });
    </script>
</#if>