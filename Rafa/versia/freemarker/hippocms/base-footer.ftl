<#include "../include/imports.ftl">
<@hst.link var="subscribe" path="news-and-events/newsletter"/>
<@hst.setBundle basename="skeleton"/>

<div class="main-footer__middle" data-swiftype-index='false' style="background-color: #565656;">
    <div class="main-footer__top" data-swiftype-index='false'>
    		<div class="media-container">
        		<div class="media-list">
        			<@hst.include ref="socialMediaLinks-container"/>
    			</div>
    		</div>
 	</div>	
    	<div class="subscribe-footer">
    		<div>
        		<a class="btn shadow-border-none  btn-primary"href="${subscribe}"><@fmt.message key="footer.subscribe.button" /></a>
        </div>
        <div class="newsletter-info">
        		<p><@fmt.message key="footer.bottom.right" /></p>
        	</div>
    </div>
</div>
 	<@hst.include ref="bottom-menu"/>
</div>
	<@hst.include ref="bottom-sanitary-menu"/>
<#--        <div id="teconsent" class="smc_cookie_toolbar"></div>-->
        <!-- Botón de configuración de cookies de OneTrust - Comienzo -->
        <div id="teconsent" class="smc_cookie_toolbar">
            <div class="smc_cookie_toolbar_button_container">
                <button id="ot-sdk-btn" class="ot-sdk-show-settings">Ajustes de cookies</button>
            </div>
        </div>

        <!-- Botón de configuración de cookies de OneTrust - Finalización -->

        <!-- Inicio de la lista de cookies de OneTrust -->

        <div id="ot-sdk-cookie-policy" class="hidden"></div>

        <!-- Fin de la lista de cookies de OneTrust -->
    </div>
