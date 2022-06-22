<label class="text-muted">
    <input id="check-all" data-bind="checked: selectAll" type="checkbox">&nbsp;
    <span data-bind="visible: selectAll() == false"><@fmt.message key="eshop.selectAll"/></span>
    <span data-bind="visible: selectAll() == true"><@fmt.message key="eshop.unselectAll"/></span>
</label>
