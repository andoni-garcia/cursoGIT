<#include "../../include/imports.ftl">
<#include "./_functionality-scripts.ftl">

<div class="modal fade functionality-modal show" id="functionality-modal" tabindex="-1" role="dialog"
     aria-labelledby="_showDetailsModalTitle" style="padding-right: 17px; display: none;">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="functionality-modal-title"><@fmt.message key="functionality.modal.title"/></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="modal-body__content">
                    <p><@fmt.message key="functionality.modal.body"/></p>
                    <input type="hidden" id="nodeid" name="nodeid" value=""/>
                    <input type="hidden" id="nodename" name="nodename" value=""/>
                    <input type="hidden" id="navigationnode" name="navigationnode" value=""/>
                    <div class="modal-footer text-right clearfix">
                        <button id="functionality-confirm-btn" type="button" class="btn btn-outline-primary"><@fmt.message key="functionality.modal.confirm"/></button>
                        <button id="functionality-cancel-btn" type="button" class="btn btn-primary"><@fmt.message key="functionality.modal.cancel"/></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
    });
</script>