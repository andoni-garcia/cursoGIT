<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<@hst.setBundle basename="SearchPage,SearchBar"/>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/components/etools/porthole.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/components/etools/etools.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<div class="container desktop etools-container" data-swiftype-index="false">
    <div>
        <button class="btn btn-primary" onclick="newProject()">New Project</button>
        <button class="btn btn-primary" onclick="OpenConfiguration()">Open D 40-F02</button>
        <button class="btn btn-primary" onclick="GetPDF()">PDF</button>
        <button class="btn btn-primary" onclick="GetConfig()">Save Project</button>
        <button class="btn btn-primary" onclick="loadSession()">Load Session</button>
        <button class="btn btn-primary" onclick="applyCustomStyles()">Custom Styles</button>

        <button class="btn btn-primary" onclick="getBOM()">Load BOM</button>
        <button class="btn btn-primary" onclick="getBOMXLS()">BOM XLS</button>
        <button class="btn btn-primary" onclick="getCAD()">Download CAD</button>
        <button class="btn btn-primary" onclick="getProductDocumentation()">Product Documentation</button>
        <button class="btn btn-primary" onclick="getCfgImage()">Image</button>

        <button class="btn btn-primary" onclick="showMessageOver3D()">Show message</button>
        <button class="btn btn-primary" onclick="listenToConfigurationChanges()">Listen to CFG changes</button>
        <span id="sID" style="width:200px;height:12px;margin:0 10px"></span>
        <span id="ValidConfig" style="width:200px;height:12px;margin:0 10px"></span>
        <span id="SimpleSpecial" style="width:200px;height:60px;margin:0 10px"></span>
    </div>
    <div>
        <div>BOM:</div>
        <table id="BOM">
        </table>
    </div>
    <iframe id="ffrl3D" name="ffrl3D"
            src="https://etoolstest.smc.at/config/frl3d/index.html?view=embedded&country=${country}&language=${lang}"
            width="100%" height="1000px" style="border: 1px solid #ffffff; display: block;">
    </iframe>

    <label>Style Controls</label>
    <div>
        <button class="btn btn-primary" id="toggleTheme" onclick="toggleTheme()" value="light">Toggle theme</button>
        <button class="btn btn-primary" id="toggleView" onclick="toggleView()" value="">Toggle view</button>
        <button class="btn btn-primary" id="resetView" onclick="resetView()" value="0">Reset View</button>
        <button class="btn btn-primary" id="toggleTransparent" onclick="toggleTransparent()" value="0">Toggle Transparent</button>
        <button class="btn btn-primary" id="toggleFloor" onclick="toggleFloor()" value="0">Toggle Floor</button>
        <button class="btn btn-primary" id="toggleDimensions" onclick="toggleDimensions()" value="0">Toggle Dimensions</button>
        <button class="btn btn-primary" id="toggleTheme2" onclick="toggleTheme2()" value="0">Toggle Theme</button>
        <button class="btn btn-primary" id="toggleAr" onclick="toggleAr()" value="0">Toggle Ar</button>
        <button class="btn btn-primary" id="toggleStyle" onclick="toggleStyle()" value="0">Toggle Style</button>
        <button class="btn btn-primary" id="toggleTags" onclick="toggleTags()" value="0">Toggle Tags</button>
<#--        <button class="btn btn-primary" id="toggleSidebar" onclick="toggleSidebar()" value="0">Toggle Sidebar</button>-->

    </div>

</div>

<div class="hidden" data-swiftype-index='false'>
    <a id="getErpInfoUrl" class="hidden" href="<@hst.resourceURL resourceId='getErpInfo'/>"></a>
</div>

<script type="text/javascript">
    var smc = window.smc || {};
    smc.isAuthenticated = ${isAuthenticated?c};
    smc.etools = smc.etools || {};
    smc.etools.urls = {
        getErpInfo: document.getElementById('getErpInfoUrl').href
    };
</script>

<style>
    .etools-container .btn-primary {
        margin: 10px;
    }

    #BOM td {
        padding: 10px;
    }
</style>
