<#include "../include/imports.ftl">

<#-- @ftlvariable name="query" type="java.lang.String" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->



<div class="container">
    <br>
    <h2 class="heading-07">Your GDPR tools</h2>
    <br>
    <div class="info-box info-box--blue">
		<div class="info-box__head">
            <h2 class="heading-07">Right of access to personal data</h2>
        </div>
        <div class="info-box__body text-01">
            <div class="cta-box-list">
                <div class="cta-box">
                    <a href="/gdpr/visitorinfo" target='_blank' class="btn btn-secondary mr-10">Personal Data Access Request.</a>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="csrf-token"/>
    <div class="info-box info-box--blue">
        <div class="info-box__head">
            <h2 class="heading-07">Right to be forgotten</h2>
        </div>
        <div class="info-box__body text-01">
            <div class="cta-box-list">
                <div class="cta-box">
                    <button id="remove-data-button" onclick="removePersonalDataAPI()" class="btn btn-secondary mr-10">Personal Data Forgotten Request.</button>
                </div>
            </div>
        </div>
    </div>
    <div id="thankyou-message" style="display:none">
        <h2 class="heading-07">You have been forgotten</h2>
    </div>
</div>

<script>
    function removePersonalDataAPI(){
        $.ajax({
            url: '/gdpr/visitorinfo',
            type: 'DELETE',
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token',  $("#csrf-token").val())
            },
            success: function(response) {
                $.removeCookie('cookieconsent_status', { path: '/' });
                $.removeCookie('activelyAcceptedCookies', { path: '/' });
                $.removeCookie('productsAddedCookie-custom', { path: '/' });
                $.removeCookie('productsAddedCookie-default', { path: '/' });
                $("#thankyou-message").show();
            }
        });
    }
</script>


