<#include "../include/imports.ftl">
<#setting number_format="computer">

<div class="modal fade refresh-data-modal show" id="refresh-data-modal" tabindex="-1" role="dialog"
     aria-labelledby="_showDetailsModalTitle" style="padding-right: 17px; display: none;">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="refresh-data-modal-title">
                    <@fmt.message key="refreshdata.refreshdata" />
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="modal-body__content">
                    <b>
                        <@fmt.message key="refreshdata.serieslevelinformation" />:
                    </b>
                    <#if !(node.getType() == "SERIE") >
                        <div class="radio">
                            <label><input type="radio" name="refreshDataModalInput" value="PARAMETRIC_SEARCH"
                                          checked>
                                <@fmt.message key="refreshdata.parametricsearch" />
                            </label>
                        </div>
                    </#if>
                    <div class="radio">
                        <label><input type="radio" name="refreshDataModalInput" value="NODE_INFORMATION">
                            <@fmt.message key="refreshdata.nodeinformation" />
                        </label>
                    </div>
                    <div class="radio">
                        <label><input type="radio" name="refreshDataModalInput"
                                      value="NODE_INFORMATION_AND_DESCENDANT">
                            <@fmt.message key="refreshdata.nodeinformationdescendants" />
                        </label>
                    </div>
                    <#if node.getType() == "SERIE" >
                        <div class="radio">
                            <label><input type="radio" name="refreshDataModalInput" value="PRODUCT_SELECTION">
                                <@fmt.message key="refreshdata.productselection" />
                            </label>
                        </div>
                        <div id="product-level-options" style="display: none;">
                            <b>
                                <@fmt.message key="refreshdata.productlevelinformation" />:
                            </b>
                            <div class="radio">
                                <label><input type="radio" name="refreshDataModalInput"
                                              value="PRODUCT_NODE_INFORMATION">
                                    <@fmt.message key="refreshdata.nodeinformation" />
                                </label>
                            </div>
                        </div>
                    </#if>
                    <input type="hidden" id="productId" name="productId" value=""/>

                    <div class="modal-footer text-right clearfix">
                        <button id="refresh-data-modal-confirm-btn" type="button"
                                class="btn btn-outline-primary">
                            <@fmt.message key="refreshdata.confirm" />
                            <#--                                Confirm-->
                        </button>
                        <button id="refresh-data-modal-cancel-btn" type="button"
                                class="btn btn-primary" data-dismiss="modal" aria-label="Close">
                            <@fmt.message key="refreshdata.cancel" />
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/refresh-data.component.js"/>"></script>
</@hst.headContribution>

<script type="text/javascript">
    var refreshDataLiteral;
    var refreshingDataLiteral;
    var lastFailureCauseLiteral;
    $(document).ready(function () {
        var RefreshDataComponent = window.smc.RefreshDataComponent;
        var config = {
            productId: "${refreshId}",
            $modalConfirmButton: $('#refresh-data-modal-confirm-btn'),
            $refreshDataModal: $('#refresh-data-modal'),
        };
        refreshDataLiteral = "<@fmt.message key="refreshdata.refreshdata" />";
        refreshingDataLiteral = "<@fmt.message key="refreshdata.refreshingdata" />";
        lastFailureCauseLiteral = "<@fmt.message key="refreshdata.lastfailurecause" />";
        var refreshDataComponent = new RefreshDataComponent(config);
        refreshDataComponent.init();

    });
</script>