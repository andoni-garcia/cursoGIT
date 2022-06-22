<div>
    <!-- ko if: contacts().length === 0    -->
    <@fmt.message key="received.noContacts"/>
    <!-- /ko -->     
    <div class="list-group" style="max-height: 500px; overflow-y: scroll">

     <!-- ko foreach: contacts    -->
        <a href="#" class="list-group-item list-group-item-action" data-bind="click: $parent.selectContact.bind($data, $data), css: { 'active': $parent.selectedContact().id === $data.id }">
            <div class="row pl-2">
                <strong data-bind="text: $data.username" class="mr-10"></strong> 
                <p class="mb-0" data-bind="text: $data.firstName"></p> 
                <p class="mb-0 ml-2" data-bind="text: $data.lastName"></p>
            </div>
            <div class="row pl-2">
                <p data-bind="text: $data.company"></p>
            </div>
        </a>
    <!-- /ko -->     
    </div>
</div>