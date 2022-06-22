<div>
    <@fmt.message key="receive.sendStepDescription"/>
     <div class="col-12">
                    <div class="form-check">
                        <label class="form-check-label" for=""><@fmt.message key="mybaskets.description"/></label>
                        <input type="text" class="form-control" data-bind="value: shareBasketDescription, valueUpdate: 'keyup'"/>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <label class="form-check-label" for=""><@fmt.message key="mybaskets.comments"/></label>
                        <input type="text" class="form-control" data-bind="value: shareBasketComments, valueUpdate: 'keyup'"/>
                   </div>
                </div>
</div>