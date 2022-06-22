
<#if channelPrefix == "/en-eu">
    <#assign enGBUrl =  siblingPages["en_GB"].getMount().getChannelInfo().getProperties() />
    <@hst.link var="linkHippo" link=siblingPages["en_GB"]/>
    <#assign linkUrl = linkHippo />
    <#if linkHippo?starts_with("http") == false>
        <#assign linkUrl = "https://www.smc.eu" + linkHippo?replace("/site","") />
    </#if>
    <link rel="canonical" href="${linkUrl}"/>
</#if>