<#include "_accessories-modal_links.ftl">
<script type="text/javascript">
    var smc = window.smc || {};
    smc.isAuthenticated = ${isAuthenticated?c};
    smc.accesoryModal = smc.accesoryModal || {};
    smc.accesoryModal.urls = {
        getAccessoryDetail: document.getElementById('getAccessoryDetailLink').href,
        hasAccessoryDetail: document.getElementById('hasAccessoryDetailLink').href
    };
</script>