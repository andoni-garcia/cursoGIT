<@hst.setBundle basename="CylinderConfigurator"/>
<div class="modal fade mb-5 mb-xl-0 sscw_modal" id="createCustomerAliasModal" role="dialog" data-swiftype-index="false" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="cylinderConfigurator.createCustomerAlias"/></h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <section class="">
                    <div class="hidden sscw-message-error"><p id = "alias-error-message" style="color:#D20000"></p></div>
                    <article class="px-4 sscw__alias" id="sscw__alias">
                        <div class="row mb-4 sscw__alias__content">
                            <div class="col-12">
                                <strong class="sscw__alias__title"><@fmt.message key="cylinderConfigurator.assignAlias"/></strong>
                            </div>
                            <div class="col-12">
                                <form class="sscw__alias__form mt-4">
                                    <div class="sscw__info_table">
                                        <div class="sscw__info_table__title">
                                            <@fmt.message key="cylinderConfigurator.simpleSpecialReference"/>:
                                        </div>
                                        <div class="sscw__info_table__value" id ="sscw__info_table__simple_special_code">

                                        </div>
                                        <div class="sscw__info_table__title">
                                            <@fmt.message key="cylinderConfigurator.customerCode"/>:
                                        </div>
                                        <div class="sscw__info_table__value" id ="sscw__info_table__customer_code">
                                        </div>
                                        <div class="sscw__info_table__title">
                                            <@fmt.message key="cylinderConfigurator.customerName"/>:
                                        </div>
                                        <div class="sscw__info_table__value"  id ="sscw__info_table__customer_name">
                                        </div>
                                        <div class="sscw__info_table__title">
                                            <label for="alias" class="d-block mb-2">
                                                <span class="d-block mb-2"><@fmt.message key="cylinderConfigurator.alias"/></span>
                                            </label>
                                        </div>
                                        <div class="sscw__info_table__value">
                                            <input type="text" name="alias" id="alias" value="" placeholder="<@fmt.message key="cylinderConfigurator.typeAliasNumber"/>" class="form-control">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </article>
                </section>
            </div>
            <div class="modal-footer">
                <div class="button_group--left">
                    <button type="button" id="btn-alias-return" class="btn btn-secondary btn-secondary--blue-border" data-dismiss="modal"><@fmt.message key="cylinderConfigurator.cancel"/></button>
                </div>
                <div class="button_group--right">
                    <button type="button" id="btn-alias-finish" class="btn btn-primary"><@fmt.message key="cylinderConfigurator.accept"/></button>
                </div>
            </div>
        </div>
    </div>
</div>

<#--<script type="text/javascript">-->
<#--    function showAliasModal(){-->
<#--        var confirm = $("#createCustomerAliasModal");-->
<#--        confirm.modal('show');-->
<#--        $("#_showDetailsModal .modal-dialog").removeClass("hidden");-->
<#--    }-->

<#--    $(document).ready(function () {-->
<#--        $("#showAliasModalButton").click(function() {-->
<#--            showAliasModal();-->
<#--        });-->

<#--        $("#btn-alias-finish").click(function () {-->
<#--            if ($("#alias").val().trim() !== ""){-->
<#--                $("#configuration_details__alias__value").text($("#alias").val().trim());-->
<#--                var confirm = $("#createCustomerAliasModal");-->
<#--                confirm.modal('hide');-->
<#--            }-->
<#--        });-->
<#--    });-->
<#--</script>-->
