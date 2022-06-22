  <!-- modal to import file -->
<div class="modal fade" id="modal-fav-import" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="favourites.importModal.title"/></h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div id="error-dialog-import" class="alert alert-danger m-2" hidden> </div>
            <div class="modal-body">
                <span><@fmt.message key="favourites.importModal.mssg1"/></span>
                <br>
                <ul>

                    <li> <@fmt.message key="favourites.importModal.column1"/> </li>
                    <li> <@fmt.message key="favourites.importModal.column2"/> </li>
                    <li> <@fmt.message key="favourites.importModal.column3"/> </li>
                    <li> <@fmt.message key="favourites.importModal.column4"/> </li>
                    <li> <@fmt.message key="favourites.importModal.column5"/> </li>
                    
                </ul>
                <span><@fmt.message key="favourites.importModal.mssg2"/></span>
            </div>
            <div class="modal-footer">
                <button type="button" id="btn-return" class="btn mb-1" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                <form id="importForm" enctype="multipart/form-data" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}" method="post" >
                    <div class="">
                        <label for="importBasket" class=" action-item">
                            <button type="button" id="btn-submit" class="btn btn-primary" data-dismiss=""><@fmt.message key="eshop.importFromFile"/></button>
                        </label>
                        <input data-bind="event: { change: uploadFile.bind($data)}" type="file" name="file_input" id="importFavourites" style="display:none;" accept=".xls,.xlsx">
                    </div>
                </form>    
            </div>
        </div>
    </div>
</div>