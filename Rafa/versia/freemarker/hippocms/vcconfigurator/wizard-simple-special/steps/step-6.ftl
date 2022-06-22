<div class="step step-6" data-step="6">
    <div class="row">
                    <!-- ko foreach: cadOptions    -->
                    <div class="col-6 ">
                        <span class="options-cad--name" data-bind="text: $data.name"></span>
                        <div class="cad-download-format-list collapse show options-cad" >
                            <!-- ko foreach: $data.options    -->
                                <div class="form-check">
                                    <input type="radio" name="cad" data-bind="value: $data.key, attr: { id: $data.key }, event: { change: $component.changeCadOption.bind($data, $data.key) }" />
                                    <label data-bind="text: $data.value, attr: { for: $data.key }"></label>
                                </div>
                            <!-- /ko -->
                        </div>
                    </div>
                    <!-- /ko -->
                    
                </div>
</div>