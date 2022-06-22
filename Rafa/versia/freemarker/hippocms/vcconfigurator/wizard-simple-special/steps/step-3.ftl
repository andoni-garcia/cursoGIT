<div class="step step-3" data-step="3">
    <@fmt.message key="wizardsimplespecial.step3.selectFolder"/>
    <div class="wss-step3-folderstree mt-3 position-relative">
        <smc-favourites-simple-selector params="parentVm: $root, displayComponentStep: 3">
            <@hst.include ref="favourites-folders-simple-selector"/>
        </smc-favourites-simple-selector>
    </div>
</div>