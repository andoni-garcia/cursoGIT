<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"] >
<#assign fmt=JspTaglibs ["http://java.sun.com/jsp/jstl/fmt"] >

<@hst.defineObjects />
<#setting locale=hstRequest.requestContext.resolvedMount.mount.locale>
<#global host=hstRequest.requestContext.resolvedMount.mount.virtualHost.name>
<#global lang=.locale?split("_")[0]?lower_case>
<#global country=.locale?split("_")[1]?lower_case>
<#global channelPrefix="/"+.locale?replace('_', '-')?lower_case>
<#global countryNames = {"it_IT": "Itali", "de_DE":"Deutschland"}>

<#import "osudio.ftl" as osudio>
<#include "commons.ftl">