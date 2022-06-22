<div class="row pt-0">
  <div class="col-12 p-0">
    <!-- ko foreach:{data:$data.documents} -->
    <div class="row list-items">
      <div class="col-2 col-lg-1">
        <button class="btn btn-secondary btn-list" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="View document">
          <a data-bind="attr: { href: $data.url, 'smc-cmLog-data3': $data.name }"  smc-cmLog-data1= "COMPARISON MAP" smc-cmLog-data2= "PDF" target="_blank" smc-cmLog-action="DOWNLOAD" smc-cmLog-type="FILE">
          	<i class="fas fa-eye" smc-cmLog-action="DOWNLOAD" smc-cmLog-type="FILE" smc-cmLog-data1= "COMPARISON MAP" smc-cmLog-data2= "PDF" data-bind="attr: {'smc-cmLog-data3': $data.name }"></i>
          </a>
        </button>
      </div>
      <div class="col-10 col-lg-11" data-bind="text:$data.name">
      </div>
    </div>
    <!-- /ko -->
  </div>
</div>