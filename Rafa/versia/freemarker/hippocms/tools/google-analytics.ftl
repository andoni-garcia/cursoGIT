<#include "../../include/imports.ftl">
<#if (channelinfo?? && channelinfo.properties.googleanalytics?has_content) >
    <!-- Google Analytics async script -->
    <script>
        window.ga=window.ga||function(){(ga.q=ga.q||[]).push(arguments)};ga.l=+new Date;
        ga('create', '${channelinfo.properties.googleanalytics}', 'auto');
        ga('send', 'pageview');
    </script>
    <script async src='https://www.google-analytics.com/analytics.js'></script>
    <!-- End Google Analytics -->
</#if>