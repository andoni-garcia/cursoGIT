<div class="cct-table mt-2">
    <div class="cct-thead">
        <div class="row">
        <div class="col col-12 col-lg-2"><strong><@fmt.message key="partnumberconvert.reference"/></strong></div>
        <div class="col col-12 col-lg-2"><strong><@fmt.message key="partnumberconvert.date"/></strong></div>
        <div class="col col-12 col-lg-1"><strong><@fmt.message key="partnumberconvert.subsidiary"/></strong></div>
        <div class="col col-12 col-lg-2"><strong><@fmt.message key="partnumberconvert.industryCode"/></strong></div>
        <div class="col col-12 col-lg-2"><strong><@fmt.message key="partnumberconvert.application"/></strong></div>
        <div class="col col-12 col-lg-1"><strong><@fmt.message key="partnumberconvert.series"/></strong></div>
        <div class="col col-12 col-lg-2"><strong><@fmt.message key="partnumberconvert.competitor"/></strong></div>
        <div class="col"><strong></strong></div>
        </div>
    </div>
    <div class="cct-tbody">
        <!-- ko foreach:{data:successStories} -->
        <div class="row tbody-row">
            <div class="col-12 col-lg-2" data-bind="text:$data.reference==null ? 'N/A' : $data.reference">
            </div>
            <div class="col-12 col-lg-2"  data-bind="text:$data.date==null ? 'N/A' : $data.date">
            </div>
            <div class="col-12 col-lg-1" data-bind="text:$data.subsidary==null ? 'N/A' : $data.subsidary">
            </div>
            <div class="col-12 col-lg-2" data-bind="text:$data.industryCode==null ? 'N/A' : $data.industryCode">
            </div>
            <div class="col-12 col-lg-2" data-bind="text:$data.application==null ? 'N/A' : $data.application">
            </div>
            <div class="col-12 col-lg-1" data-bind="text:$data.serie==null ? 'N/A' : $data.serie">
            </div>
            <div class="col-12 col-lg-1" data-bind="text:$data.competitorName==null ? 'N/A' : $data.competitorName">
            </div>
            <div class="col-12 col-lg-1">
                <!-- ko if:$data.url!=null -->
                <button type="button" class="btn btn-secondary btn-addfavorites" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="More information">
                    <a data-bind="attr: { href: $data.url }" target="_blank" ><i class="icon-info-circled"></i></a>
                </button>
                <!-- /ko -->
            </div>
        </div>
        <!-- /ko -->
    </div>
</div>