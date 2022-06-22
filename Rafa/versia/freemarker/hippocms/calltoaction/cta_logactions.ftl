<#if document.logActions?? && document.logActions == true>
    <input type="hidden" id="${document.getCanonicalHandleUUID()}_logRegisterLink" smc-content-statistic-action="CLICK ON COMPONENT" smc-statistic-source="CTA LINK"/>
    <script>
        $(document).ready(function () {
            $("#${document.getCanonicalHandleUUID()}_logRegisterLink").attr("smc-statistic-data1", window.location.href);
            $("#${document.getCanonicalHandleUUID()} a").click(function (e){
                $("#${document.getCanonicalHandleUUID()}_logRegisterLink").attr("smc-statistic-data2", $(e.target).text());
                contentlogAction($("#${document.getCanonicalHandleUUID()}_logRegisterLink"), $("#logActionLink").attr("href"));

            });
        });
    </script>
</#if>