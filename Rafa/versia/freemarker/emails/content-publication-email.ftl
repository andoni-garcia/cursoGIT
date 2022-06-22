<p>Dear editor,<br/>
new content has been published or scheduled in "<b>${data.name}</b>" in the last ${hoursAge} hours.
</p>
<ul>
    <#list data.publishedData as doc>
        <li>
            <#--<a href="${baseUrl}/cms/?1&path=${doc.documentPath}">-->
            ${doc.name} (${doc.documentType}).
            <#if doc.scheduledPublicationDate??>
                Scheduled for ${doc.scheduledPublicationDate?date} at ${doc.scheduledPublicationDate?time}
            <#else>
                Published at ${doc.publicationDate?time}
            </#if>
                in ${doc.readablePath}.
            <#--</a>-->
        </li>
    </#list>
</ul>