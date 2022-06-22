<#macro customModal htmlId="modal-component" title="" message="" primaryButton="" secondaryButton="" cancelButton="" haveSecondary=true haveCancel=false>
<div class="modal fade" id="${htmlId}" role="dialog" data-swiftype-index='false'>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">${title}</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
              <span class="modal-message">${message}</span>
            </div>
            <div class="modal-footer">
                <#if haveCancel><button type="button" id="btn-cancel" class="btn btn-secondary" data-dismiss="modal">${cancelButton}</button></#if>
                <#if haveSecondary><button type="button" id="btn-return" class="btn" data-dismiss="modal">${secondaryButton}</button></#if>
                <button type="button" id="btn-submit" class="btn btn-primary" data-dismiss="modal">${primaryButton}</button>
            </div>
        </div>
    </div>
</div>
</#macro>