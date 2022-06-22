<#include "../../include/imports.ftl">
<#include "./_functionality-scripts.ftl">
<#setting number_format="computer">
<#assign cardId = "${navigationNode.getNodeId()}">
<#assign cardName = "${navigationNode.getName()}">
<#assign selectedId = '${navigationNode.getSelectedId()!""}'>
<#assign selectedName = '${navigationNode.getSelectedName()!""}'>
<#if navigationNode.getParentNodeId()??>
    <#assign parentNodeId = '${navigationNode.getParentNodeId()}'>
</#if>
<#if navigationNode.getParentSelectionId()??>
    <#assign parentSelectionId = '${navigationNode.getParentSelectionId()}'>
</#if>

<#if navigationNode.getNodes()?? && navigationNode.getNodes()?has_content>
    <div class="options-content row">
        <#list navigationNode.getNodes() as option>
            <#if option?? && option?has_content>
                <div class="col-lg-4 mb-4">
                    <div class="row psf-item--animation mt-3">
                        <div class="col-lg-10 offset-lg-1">
                            <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                <div class="functionality_filter_btn category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                     data-btn="${option.getName()}"
                                     data-node="${option.getNodeId()}"
                                     data-navigation="${cardId}"
                                     data-toggle="collapse"
                                     data-target="#collapse_${cardId}"
                                     data-desc="${option.getDesc()}"
                                     aria-controls="collapse_${cardId}"
                                     role="button"
                                     data-bind="click:handleApplication">
                                    <img src="${option.getImageUrl()}"
                                         alt="${option.getName()}" class="p-4 p-lg-1"/>
                                    <span class="category-tile__image__mask"
                                          data-btn="${option.getName()}"
                                          data-node="${option.getNodeId()}"
                                          data-navigation="${cardId}"
                                          data-desc="${option.getDesc()}"></span>
                                </div>
                                <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                    <h2 class="heading-07 pb-0 mb-1">${option.getName()}</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </#if>
        </#list>
    </div>
<#--    <#if !navigationNode.getProductCategory() ??>-->
<#--        <script>-->
<#--            $(function () {-->
<#--                setTimeout(function () {-->
<#--                    $('#collapse_' + ${cardId}).collapse('show')-->
<#--                    // $('#card_' + config.id + ' .fa-plus').click();-->
<#--                }, 300);-->
<#--            });-->
<#--        </script>-->
<#--    </#if>-->
</#if>
<script>
    $(function () {
        var FunctionalityCardComponent = window.smc.FunctionalityCardComponent;

        var config = {
            cardId: '${cardId}',
            cardName: '${cardName}',
            selectedId: '${selectedId!""}',
            selectedName: '${selectedName!""}',
            parentNodeId: '${parentNodeId!""}',
            parentSelectionId: '${parentSelectionId!""}',
            contentContainer: $('#card_${cardId}')
        };

        var functionalityCardComponent = new FunctionalityCardComponent(config);
        functionalityCardComponent.init();
    });
</script>



