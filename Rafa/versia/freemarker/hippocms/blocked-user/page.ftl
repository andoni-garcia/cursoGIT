<#include "../../include/imports.ftl">
<#compress>
<#assign c=JspTaglibs ["http://java.sun.com/jsp/jstl/core"] >

<@hst.setBundle basename="eshop"/>
</#compress>
<html>
<head>
</head>
<body>
    <div class="container">
        <h1 class="mt-5"><@fmt.message key="blockedUser.title"/></h1>
        <div class="mt-5"><@fmt.message key="blockedUser.message"/></div>
    </div>
</body>
</html>