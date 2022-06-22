<#include "../../etools-helpModal-component/etools-helpModal-component-macro.ftl">

<@etoolsHelpModal boxTitle="eToolsHelpModal" renderMode="from-ssi-series" product="" id="etoolsHelpModal_" />

<div id="documentationContainer">
    <div class="row">
        <div class="col-12">
            <h2 class="heading-08 color-blue mt-20"><@fmt.message key="etools.documentation"/></h2>
        </div>
    </div>
    <button class="btn btn-primary" onclick="GetPDF()">PDF</button>
    <button class="btn btn-primary" onclick="getCAD()">Download CAD</button>
</div>
<div id="summaryContainer">
    <div class="row">
        <div class="col-12">
            <h2 class="heading-08 color-blue mt-20"><@fmt.message key="etools.summary"/></h2>
        </div>
    </div>
    <img id="summaryImage" src="" width="550px"></img>
    <#include "_etools-frl-summary-table-content.ftl">
    <div>
        <div>BOM:</div>
        <table id="BOM">
        </table>
    </div>
</div>

<style>
    #BOM td {
        padding: 10px;
    }
</style>
