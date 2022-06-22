
<#assign queryParam=query!""/>
<#assign queryParam2=queryCP!""/>

<@hst.link var="linkSearch"/>
<@hst.link var="distributorsMain" siteMapItemRefId="distributorsmain" fullyQualified=true />

<form action="${linkSearch}" class="row">
	<div class="col-lg-4 col-sm-8 mb-3">
		<input class="form-control" type="search"
			   placeholder="<@fmt.message key="search.searchbar.input.placeholder.title"/>"
			   name="query"
			   value="${queryParam}">
		<#if page?has_content><input type="hidden" name="page" value="${page}"></#if>
		<#if pageSize?has_content><input type="hidden" name="pageSize" value="${pageSize}"></#if>
		<#if sortField?has_content><input type="hidden" name="sortField" value="${sortField}"></#if>
		<#if sortOrder?has_content><input type="hidden" name="sortOrder" value="${sortOrder}"></#if>

		<div class="results-list list-reset"></div>
	</div>
	
	<div class="col-lg-4 col-sm-8 mb-3">
		<input class="form-control" type="search"
			   placeholder="<@fmt.message key="search.searchbar.input.placeholder.postalcode"/>"
			   name="queryCP"
			   value="${queryParam2}">
		<#if page?has_content><input type="hidden" name="page" value="${page}"></#if>
		<#if pageSize?has_content><input type="hidden" name="pageSize" value="${pageSize}"></#if>
		<#if sortField?has_content><input type="hidden" name="sortField" value="${sortField}"></#if>
		<#if sortOrder?has_content><input type="hidden" name="sortOrder" value="${sortOrder}"></#if>

		<div class="results-list list-reset"></div>
	</div>

	<div class="col-lg-2 col-sm-4 mb-3 align-self-end">
		<button type="submit" class="btn btn-primary w-100">
			<span><@fmt.message key="psearch.search"/></span></a>
		</button>
	</div>
	<div class="col-lg-2 col-sm-4 mb-3 align-self-end">
        <a id="reset" href="${distributorsMain}"
            class="btn btn-primary w-100">
            <span><@fmt.message key="psearch.reset"/></span></a>
    </div>
</form>


