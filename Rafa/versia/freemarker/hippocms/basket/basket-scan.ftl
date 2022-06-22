<@hst.setBundle basename="scan"/>
<div class="modal" id="livestream_scanner">
    <div class="modal-dialog bsk-scan-modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="row w-100">
                    <div class="col-10" data-swiftype-index="false">
                        <h5 class="modal-title" data-swiftype-index="false"><@fmt.message key="title"/></h5>
                    </div>
                    <div class="col-2">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="modal-body" style="position: static">
                <video class="bsk-scan-video" id="bsk-scan-video" width="100%" height="100%"></video>
                <div class="bsk-scan-overlay">
                    <span></span>
                </div>
                <div class="error mt-5 ml-3 mr-3"></div>
            </div>
            <div class="modal-footer bsk-scan-modal-footer">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/adapter-latest.js"/>"></script>
<script type="text/javascript" src="https://unpkg.com/@zxing/library@latest/umd/index.min.js"></script>
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/basket/BasketScanTool.js"/>"></script>
<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/components/basket/basket-scan.css"/>" type="text/css"/>