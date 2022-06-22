<div>
    <h4> <@fmt.message key="share.sendTitle"/></h4>
    <div class="row pl-5">
        <strong><@fmt.message key="share.receiver"/>  </strong>
        <p data-bind="text: $data.selectedContact().firstName" class="ml-3">  </p>
        <p data-bind="text: $data.selectedContact().lastName" class="ml-1"></p>
        <p data-bind="text: '(' + $data.selectedContact().username + ')'" class="ml-1"></p>
    </div>
    <div class="row pl-5">
        <strong> <@fmt.message key="share.description"/> </strong>
        <p data-bind="text: $data.shareBasketDescription()" class="ml-3"></p>
    </div>
    <div class="row pl-5">
        <strong> <@fmt.message key="mybaskets.comments"/>  </strong>
        <p data-bind="text: $data.shareBasketComments()" class="ml-3">  </p>
    </div>
</div>