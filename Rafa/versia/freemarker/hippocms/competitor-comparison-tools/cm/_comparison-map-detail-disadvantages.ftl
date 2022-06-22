<!-- Disadvantages -->
<div class="row">
    <div class="col-12 pl-0">
    <!-- ko if:$data.disadvantages!=null && $data.disadvantages.length>0 -->
    <!-- ko foreach:{data:$data.disadvantages} -->
     <!-- Disadvantage -->
    <div class="row pl-0 pr-0 ml-0 mr-0 mb-1">
        <div class="col-12">
            <strong data-bind="text:$data.disadvantage"></strong>
            <p class="mb-0" data-bind="text:$data.detail==''|| $data.detail==null ? 'Not available' : $data.detail"></p>
        </div>
        <div class="col-12">
            <p class="mb-0"><span class="mr-1 text-danger"><i class="fa fa-times-circle mr-1" aria-hidden="true"></i><@fmt.message key="comparisonmap.countermeasure"/>:</span><span data-bind="text:$data.countermeasure=='' || $data.countermeasure==null ? 'Not available' : $data.countermeasure,attr: {class:$data.countermeasure=='' || $data.countermeasure==null? 'text-secondary':''}"></span></p>
        </div>
    </div>
    <!-- /Disadvantage -->
    <!-- /ko -->
    <!-- /ko -->
    <!-- ko if:$data.disadvantages.length==0 || $data.disadvantages==null-->
    <div class="row pl-0 pr-0 ml-0 mr-0 mb-3">
        <div class="col-12">
            <p class="text-secondary">Not availables</p>
        </div>
    </div>
    <!-- /ko -->
    </div>
</div>
<!-- /Disadvantages -->