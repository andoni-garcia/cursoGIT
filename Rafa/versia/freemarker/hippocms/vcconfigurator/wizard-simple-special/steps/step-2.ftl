<div id="wss-step2" class="step step-2 wss-minimal-height position-relative" data-step="2">
    <!-- ko if: !loadingData() -->
    <div class="row">
        <div class="col-12 text-center">
            <!-- ko if: error() == null -->
            <i class="icon-valid wss-steps-iconsize"></i>
            <!-- /ko -->
            <!-- ko if: error() != null -->
            <i class="icon-invalid wss-steps-iconsize"></i>
            <!-- /ko -->
        </div>
    </div>
    <div class="row">
        <div id="wss-step2-message" class="col-12">
            <!-- ko if: error() == null -->
            <@fmt.message key="wizardsimplespecial.createsimplespecial.success"/>
            <!-- /ko -->
            <!-- ko if: error() != null -->
            <@fmt.message key="wizardsimplespecial.createsimplespecial.error"/>
            <!-- /ko -->
        </div>
    </div>
    <!-- /ko -->
    <!-- ko if: loadingData() -->
    <smc-spinner-inside-element params="loading: true"></smc-spinner-inside-element>
    <!-- /ko -->
</div>