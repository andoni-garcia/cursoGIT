<div id="wss-step8" class="step step-8 position-relative" data-step="8">
    <smc-spinner-inside-element params="loading: generatingZipFile()"></smc-spinner-inside-element>
    <div class="wss-minimal-height" data-bind="visible: generatingZipFile() && !noFile()"></div>
    <div data-bind="visible: !generatingZipFile() && !noFile()">
        <div class="row">
            <div class="col-12 text-center">
                <i class="icon-valid wss-steps-iconsize"></i>
            </div>
        </div>
    </div>
    <div>
        <div class="row">
            <div id="wss-step8-simplespecial-message" class="col-12 text-center">
                <@fmt.message key="wizardsimplespecial.step8.simpleSpecialCreated"/>
            </div>
        </div>
    </div>
    <div data-bind="visible: !generatingZipFile() && !noFile()">
        <div class="row">
            <div class="col-12 text-center">
                <@fmt.message key="wizardsimplespecial.step8.created"/>
            </div>
        </div>
    </div>
    <div data-bind="visible: noFile()">
        <div class="row">
            <div class="col-12 text-center">
                <@fmt.message key="wizardsimplespecial.step8.noCreated"/>
            </div>
        </div>
    </div>
</div>