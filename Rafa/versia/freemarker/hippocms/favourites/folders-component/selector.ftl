<#include "../../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#assign spring=JspTaglibs["http://www.springframework.org/tags"] />

<@hst.setBundle basename="eshop"/>

<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>

<#if isAuthenticated>
<div class="modal fade multi-step" id="favouritesFoldersModal" role="dialog" data-swiftype-index='false'>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title step-1" data-step="1"><@fmt.message key="favourites.selectFolder"/></h4>
                <h4 class="modal-title step-2" data-step="2"><@fmt.message key="favourites.createFolder"/></h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body step step-1">
                <div class="favourite-folders-tree">
                    <smc-spinner-inside-element params="loading: loadingFolders()"></smc-spinner-inside-element>
                    <ul class="treeview nopadding">
                    <!-- ko foreach: folders -->
                        <li>
                            <input type="radio" name="selectorFolderId" data-bind="checked: $root.selectedFolderId, value: folderId"/>&nbsp;
                            <a class="a-ko" data-bind="text: name(), click: $root.setSelected.bind($data, folderId)">
                                <i class="fas fa-folder"></i>
                            </a>
                            <span data-bind="text: numFavouriteElements()"></span>
                        </li>
                            <!-- ko if: childrenFolders().length > 0 -->
                                <ul>
                                    <!-- ko foreach: childrenFolders -->
                                    <li>
                                        <input type="radio" name="selectorFolderId" data-bind="checked: $root.selectedFolderId, value: folderId"/>&nbsp;
                                        <a class="a-ko" data-bind="text: name(), click: $root.setSelected.bind($data, folderId)">
                                            <i class="fas fa-folder"></i>
                                        </a>
                                        <span data-bind="text: numFavouriteElements()"></span>
                                    </li>
                                    <!-- /ko -->
                                </ul>
                            <!-- /ko -->
                    <!-- /ko -->
                    </ul>
                </div>
            </div>
            <div class="modal-body step step-2">
                <div class="row">
                    <div class="col-6">
                        <label><@fmt.message key="favourites.folder"/></label>
                        <select class="form-control" data-bind="value: $root.selectInputParentFolder">
                        <option value=""><@fmt.message key="favourites.selector.root"/></option>
                        <!-- ko foreach: folders -->
                        <option data-bind="text: name, value: folderId"></option>
                        <!-- /ko -->
                        </select>
                    </div>
                    <div class="col-6">
                        <label><@fmt.message key="favourites.nameForFolder"/></label>
                        <input class="form-control" id="folder-name" type="text" data-bind="value: $root.boxInputFolderName, valueUpdate:'keyup'">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="btn-create-fvfl" class="btn btn-secondary step step-2" data-bind="click: $root.sendEvent.bind($data, '#favouritesFoldersModal', 1, true)"><@fmt.message key="eshop.back"/></button>
                <button type="button" id="btn-create-fvfl" class="btn btn-primary step step-1 mr-auto" data-bind="click: $root.sendEvent.bind($data, '#favouritesFoldersModal', 2)"><@fmt.message key="favourites.createFolder"/></button>
                <button type="button" id="btn-return-fvfl" class="btn btn-secondary" data-bind="click: $root.closeWithoutSave.bind($data)"><@fmt.message key="eshop.cancel"/></button>
                <button type="button" id="btn-submit-fvfl" class="btn btn-primary step step-1" data-bind="click: $root.closeWithSave.bind($data)"><@fmt.message key="favourites.addToFolder"/></button>
                <button type="button" id="btn-submit-fvfl" class="btn btn-primary step step-2" data-bind="click: $root.createFolderSelector.bind($data)"><@fmt.message key="favourites.create.btn"/></button>
            </div>
        </div>
    </div>
</div>

<@hst.resourceURL var="favouritesFoldersServerListUrl" resourceId="GET"/>
<@hst.resourceURL var="favouritesFoldersServerAddUrl" resourceId="ADD"/>
<@hst.resourceURL var="favouritesFoldersServerUpdateUrl" resourceId="UPDATE"/>
<@hst.resourceURL var="favouritesFoldersServerDeleteUrl" resourceId="DELETE"/>

<@hst.headContribution category="htmlHead">
<script>

    var favouritesFoldersServerListUrl;
    var favouritesFoldersServerAddUrl;
    var favouritesFoldersServerUpdateUrl;
    var favouritesFoldersServerDeleteUrl;

	var favouritesFoldersViewModel;

    var addedFolderMsg = (typeof addedFolderMsg === 'undefined') ? '<@fmt.message key="eshop.favourites.folderAdded"/>' : addedFolderMsg;


</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/favourites/Folder.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/favourites/FavouritesFoldersRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/favourites/FavouritesFoldersViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
<script type="text/javascript">

    $(document).ready(function(){

        favouritesFoldersServerListUrl = '${favouritesFoldersServerListUrl}';
        favouritesFoldersServerAddUrl = '${favouritesFoldersServerAddUrl}';
        favouritesFoldersServerUpdateUrl = '${favouritesFoldersServerUpdateUrl}';
        favouritesFoldersServerDeleteUrl = '${favouritesFoldersServerDeleteUrl}';

        favouritesFoldersViewModel = new FavouritesFoldersViewModel();

        var favouritesFoldersModalDom = document.getElementById("favouritesFoldersModal")
        ko.applyBindings(favouritesFoldersViewModel, favouritesFoldersModalDom);

    });

</script>
</@hst.headContribution>
</#if>