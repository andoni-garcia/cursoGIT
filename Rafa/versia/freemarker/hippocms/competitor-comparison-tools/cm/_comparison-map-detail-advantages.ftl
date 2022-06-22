<!-- Advantages -->
<div class="row">
    <div class="col-12 pl-0">
        <!-- ko if:$data.advantages!=null && $data.advantages.length>0 -->
        <!-- ko foreach:{data:$data.advantages} -->
        <!-- Advantage -->
        <div class="row pl-0 pr-0 ml-0 mr-0 mb-1">
            <div class="col-12">
                <strong data-bind="text:$data.title"></strong>
                <p class="mb-0" data-bind="text:$data.description=='' || $data.description==null ? 'Not available' : $data.description"></p>
            </div>
            <div class="col-12">
                <p class="mb-0"><span class="mr-1 text-success"><i class="fa fa-check-circle mr-1" aria-hidden="true"></i><@fmt.message key="partnumberconvert.benefit"/>:</span><span data-bind="text:$data.benefit=='' || $data.benefit==null? 'Not available' : $data.benefit,attr: {class:$data.benefit=='' || $data.benefit==null? 'text-secondary':''}"></span></p>
            </div>
        </div>
        <!-- /Advantage -->
        <!-- /ko -->
        <!-- /ko -->
        <!-- ko if:$data.advantages.length==0 || $data.advantages==null-->
        <div class="row pl-0 pr-0 ml-0 mr-0 mb-3">
            <div class="col-12 pl-0">
                <p class="text-secondary">Not availables</p>
            </div>
        </div>
        <!-- /ko -->
    </div>
</div>
<!-- /Advantages -->