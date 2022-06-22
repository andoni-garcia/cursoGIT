<#assign queryParam=query!""/>
<@hst.link var="ppListMain" siteMapItemRefId="priceproposallist" fullyQualified=true />
<@hst.link var="linkSearch"/>

    <form action="${linkSearch}" class="row">
        <div class="col-lg-8 col-sm-8 mb-3">
            <input class="form-control" type="search"
                   placeholder="<@fmt.message key="pp.placeholder_search"/>"
                   name="query"
                   value="${queryParam}">
            <#if page?has_content><input type="hidden" name="page" value="${page}"></#if>
            <#if pageSize?has_content><input type="hidden" name="pageSize" value="${pageSize}"></#if>
            <#if sortField?has_content><input type="hidden" name="sortField" value="${sortField}"></#if>
            <#if sortOrder?has_content><input type="hidden" name="sortOrder" value="${sortOrder}"></#if>

            <div class="results-list list-reset"></div>
        </div>

        <div class="col-lg-2 col-sm-4 mb-3 align-self-end">
            <button type="submit" class="btn btn-primary w-100">
                <span><@fmt.message key="pp.button.search"/></span>
            </button>
        </div>
        <div class="col-lg-2 col-sm-4 mb-3 align-self-end">
                <a id="reset" href="${ppListMain}"
                   class="btn btn-primary w-100">
                    <@fmt.message key="pp.button.showall"/></a>
        </div>
    </form>


