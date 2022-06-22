<!doctype html>
<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<@hst.setBundle basename="ProductToolbar,ProductConfigurator,ETools,eshop"/>
<div class="modal fade show-etools-help-modal show etools-help-modal" id="_showEtoolsHelpModal" role="dialog"
     aria-labelledby="_showEtoolsHelpModalTitle" style="padding-right: 17px; display: block;">
    <div class="modal-dialog modal-xl modal-dialog-centered " role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"
                    id="_showEtoolsHelpModalTitle"><@fmt.message key="etools.summary.askForHelp"/></h5>
                <button type="button" class="close"  data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">

                    <form id="etools-help-contact-form" class="form smc-form">

                        <div class="hidden etools-help-message alert alert-danger etools-help-contact-error"><p id = "help-contact-error" style="color:#D20000"><@fmt.message key="etools.help.askHelpError"/></p></div>
                        <div class="hidden etools-help-message alert alert-danger etools-help-update-contact-error"><p id = "help-update-contact-error" style="color:#D20000"><@fmt.message key="etools.help.contactUpdate.alertError"/></p></div>
                        <div class="hidden etools-help-message alert alert-success etools-help-update-contact-success" role="alert"><@fmt.message key="etools.help.updateSuccess"/></div>
                        <div class="hidden etools-help-message alert alert-success etools-help-contact-success" role="alert"><@fmt.message key="etools.help.askHelpSuccess"/></div>
                        <div class="row">
                            <div class="eforms-field form-group col-lg-11">
                                <label for="contactPerson"><@fmt.message key="etools.help.contactPerson" />:</label>
                                <input type="text" class="form-control" name="contactPerson" id ="help_form_contactPerson"
                                       placeholder="<@fmt.message key="etools.help.contactPerson" />"/>
                            </div>
                            <div class="eforms-field form-group col-lg-1 align-bottom">
                                <button type="button" id="help_form_updateContactButton" class="btn  btn-primary"><@fmt.message key="etools.help.save"/></button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="eforms-field form-group col-lg-12">
                                <strong><@fmt.message key="etools.help.fill.information" />:</strong>
                            </div>
                        </div>
                        <div class="row">
                            <div class="eforms-field form-group col-lg-6">
                                <#--                                <label for="nameSurname"><@fmt.message key="etools.help.name_surname" /> *</label>-->
                                <input type="text" class="form-control required" required name="nameSurname"
                                       id="help_form_nameSurname"
                                       placeholder="<@fmt.message key="etools.help.name_surname" /> *"/>
                            </div>
                            <div class="eforms-field form-group col-lg-6">
                                <#--                                <label for="email"><@fmt.message key="etools.help.email" /> *</label>-->
                                <input type="email" class="form-control required" required name="email"
                                       id="help_form_email" placeholder="<@fmt.message key="etools.help.email" /> *"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="eforms-field form-group col-lg-4">
                                <#--                                <label for="company"><@fmt.message key="etools.help.company" /> *</label>-->
                                <input type="text" class="form-control required" required name="company"
                                       id="help_form_company"
                                       placeholder="<@fmt.message key="etools.help.company" /> *"/>
                            </div>
                            <div class="eforms-field form-group col-lg-4">
                                <#--                                <label for="country"><@fmt.message key="etools.help.country" /> *</label>-->
                                <div class="dropdown smc-select">
                                    <select id="help_form_country" name="country" required value="">
                                        <option value="">-<@fmt.message key="etools.help.country"/>-</option>
                                        <#list countryList as country>
                                            <option value="${country.getCode()}">${country.getDescription()}</option>
                                        </#list>
                                    </select>
                                </div>

                            </div>
                            <div class="eforms-field form-group col-lg-4">
                                <#--                                <label for="phone"><@fmt.message key="etools.help.phone" /> *</label>-->
                                <input type="text" class="form-control required" required name="phone"
                                       id="help_form_phone" placeholder="<@fmt.message key="etools.help.phone" /> *"/>
                            </div>
                        </div>
                        <div class="loading-container loading-container-js"></div>
                        <div class="row">
                            <div class="eforms-field form-group col-lg-12">
                                <strong><@fmt.message key="etools.help.add.comments" /></strong>
                            </div>
                        </div>
                        <div class="row">
                            <div class="eforms-field form-group col-lg-12">
                                <#--                                <label for="yourMessage"><@fmt.message key="etools.help.your.message" /></label>-->
                                <textarea name="yourMessage" id="help_form_yourMessage" class="form-control" cols="40"
                                          rows="6" maxlength="2000"
                                          placeholder="<@fmt.message key="etools.help.your.message" />"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="eforms-field form-group col-lg-12">
                                <strong><@fmt.message key="etools.help.advertisement.text" /></strong>
                            </div>
                        </div>
                        <div class="row">
                            <div class="eforms-field  col-lg-12">
                                <label class="smc-checkbox">
                                    <input type="checkbox" name="acceptCommercial" id = "help_form_acceptCommercial" class=""/>
                                    <span class="smc-checkbox__label">
                                        <@fmt.message key="etools.help.checkbox.label" />
                                    </span>
                                </label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="button_group--left">
                            </div>
                            <div class="button_group--right" id = "help_form_send_container">
                                <button type="button" id="help_form_btn_send"
                                        class="btn btn-primary"><@fmt.message key="eshop.send"/></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>