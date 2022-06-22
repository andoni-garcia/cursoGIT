<#include "../../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#assign spring=JspTaglibs["http://www.springframework.org/tags"] />

<@hst.setBundle basename="eshop"/>

<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>

<#if isAuthenticated>

<div class="mt-3" data-bind="visible: isShowingComponent()">
    <smc-spinner-inside-element params="loading: loadingFolders()"></smc-spinner-inside-element>
    <div data-bind="visible: !($component.creatingNewFolder())">
        <div class="row">
            <div class="col-12">
                <div>
                    <ul class="treeview nopadding">
                    <!-- ko foreach: folders -->
                        <li>
                            <input type="radio" name="selectorFolderId" data-bind="checked: $component.selectedFolderId, value: folderId"/>&nbsp;
                            <a class="a-ko" data-bind="text: name(), click: $component.setSelected.bind($data, folderId)">
                                <i class="fas fa-folder"></i>
                            </a>
                            <span data-bind="text: numFavouriteElements()"></span>
                        </li>
                            <!-- ko if: childrenFolders().length > 0 -->
                                <ul>
                                    <!-- ko foreach: childrenFolders -->
                                    <li>
                                        <input type="radio" name="selectorFolderId" data-bind="checked: $component.selectedFolderId, value: folderId"/>&nbsp;
                                        <a class="a-ko" data-bind="text: name(), click: $component.setSelected.bind($data, folderId)">
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
        </div>
    </div>
</div>

<div class="m-4" data-bind="visible: $component.creatingNewFolder() == true">
    <div class="row">
        <div class="col-6">
            <label><@fmt.message key="favourites.folder"/></label>
            <select class="form-control" data-bind="value: $component.selectInputParentFolder">
            <option value=""><@fmt.message key="favourites.selector.root"/></option>
            <!-- ko foreach: folders -->
            <option data-bind="text: name, value: folderId"></option>
            <!-- /ko -->
            </select>
        </div>
        <div class="col-6">
            <label><@fmt.message key="favourites.nameForFolder"/></label>
            <input class="form-control" id="folder-name" type="text" data-bind="value: $component.boxInputFolderName, valueUpdate:'keyup'">
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
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/components/ko.comp.favouritesfolders.simple.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
<script type="text/javascript">

    $(document).ready(function(){

        favouritesFoldersServerListUrl = (typeof favouritesFoldersServerListUrl === 'undefined') ? '${favouritesFoldersServerListUrl}' : favouritesFoldersServerListUrl;
        favouritesFoldersServerAddUrl =  (typeof favouritesFoldersServerAddUrl === 'undefined') ? '${favouritesFoldersServerAddUrl}' : favouritesFoldersServerAddUrl;
        favouritesFoldersServerUpdateUrl = (typeof favouritesFoldersServerUpdateUrl === 'undefined') ? '${favouritesFoldersServerUpdateUrl}' : favouritesFoldersServerUpdateUrl;
        favouritesFoldersServerDeleteUrl = (typeof favouritesFoldersServerDeleteUrl === 'undefined') ? '${favouritesFoldersServerDeleteUrl}' : favouritesFoldersServerDeleteUrl;

    });

</script>
</@hst.headContribution>
</#if>