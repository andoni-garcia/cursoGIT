<div id="wss-step1" class="step step-1" data-step="1">
    <!-- ko if: !$component.versioningState() -->
    <div class="row">
        <div class="form-group col-lg-6 col-xl-3">
            <label for="wss-customer-number" class="control-label"><@fmt.message key="eshop.customerNumber"/></label>
            <input data-bind="value: $component.customerNumber, valueUpate: afterkeydown, submit: getFilteredCustomers.bind($data)" type="text" class="form-control wss-title-steps-inputs" id="wss-customer-number" placeholder="Type a customer number">
        </div>
        <div class="form-group col-lg-6 col-xl-3">
            <label for="wss-customer-name" class="control-label"><@fmt.message key="eshop.customerName"/></label>
            <input data-bind="value: $component.customerName, valueUpate: afterkeydown, submit: getFilteredCustomers.bind($data)" type="text" class="form-control wss-title-steps-inputs" id="wss-customer-name" placeholder="Type a customer name">
        </div>
        <div class="form-group wss-title-steps-button-div col-lg-6 col-xl-3">
            <button class="btn btn-primary" data-bind="click: getFilteredCustomers.bind($data)"><@fmt.message key="eshop.search"/></button>
        </div>
        <div class="form-group wss-title-steps-button-div col-lg-6 col-xl-3">
            <button class="btn btn-primary" data-bind="click: reset.bind($data)"><@fmt.message key="eshop.reset"/></button>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col"><@fmt.message key="eshop.customerNumber"/></th>
                        <th scope="col"><@fmt.message key="eshop.customerName"/></th>
                        <th scope="col">
                            <div><@fmt.message key="users.address"/></div>
                            <div><@fmt.message key="users.zip"/></div>
                        </th>
                    </tr>
                </thead>
            </table>
        </div>
        <div class="col-12 wss-step1-table-scroll">
            <table class="table table-hover">
                <smc-spinner-inside-element params="loading: loadingData()"></smc-spinner-inside-element>
                <tbody>
                    <!-- ko if: showError() -->
                    <tr>
                        <td colspan="3">
                            <!-- ko if: errorType() == 6 -->
                            <@fmt.message key="wizardsimplespecial.customersList.tooManyResults"/>
                            <!-- /ko -->
                            <!-- ko if: errorType() != 6 -->
                            <@fmt.message key="wizardsimplespecial.customersList.errorSearching"/>
                            <!-- /ko -->
                        </td>
                    </tr>
                    <!-- /ko -->
                    <!-- ko if: !showError() -->
                    <!-- ko if: listOfCustomers().length == 0 -->
                    <tr>
                        <td><@fmt.message key="wizardsimplespecial.customersList.noCustomers"/></td>
                    </tr>
                    <!-- /ko -->
                    <!-- ko if: listOfCustomers().length > 0 -->
                    <!-- ko foreach: listOfCustomers -->
                    <tr data-bind="click: $component.selectCustomer.bind($data, $data), css: {'wss-step1-table-selected': $data.active()}">
                        <th scope="row" data-bind="text: $data.customer.number"></th>
                        <td data-bind="text: $data.customer.name"></td>
                        <td>
                            <div data-bind="text: $data.address.name"></div>
                            <div data-bind="text: $data.address.zip"></div>
                        </td>
                    </tr>
                    <!-- /ko -->
                    <!-- /ko -->
                    <!-- /ko -->
                </tbody>
            </table>
        </div>
    </div>
    <!-- /ko -->
    <!-- ko if: $component.versioningState() -->
    <smc-wss-versioning params="rootVm: $root, parentVm: $component">
        <#include "versioning.ftl">
    </smc-wss-versioning>
    <!-- /ko -->
</div>