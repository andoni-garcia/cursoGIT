<#include "../../include/imports.ftl">
<#include "./_products-solution-finder-scripts.ftl">
<@hst.actionURL var="actionURL"/>

<@hst.headContribution category="htmlHead">
	<script>
		var actionUrl;
	</script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
	<script type="text/javascript">
		$(document).ready(function(){
			actionUrl = "${actionURL}";
            console.log(actionUrl)
    });
    </script>
</@hst.headContribution>
<div class="smc-main-container">
    <main id="psfApplicationcontenedor">
        <div class="container">
            <h2 class="heading-08 color-blue mt-20">Navigation by Application</h2>
            <h1 class="heading-02 heading-main mb-4">Save time and eliminate errors by selecting a recommended circuit for your application</h1>
            <p class="">
                SMC’s expertise is now available in a new navigation system to help you in the design process of your machine by showing typical examples of the most common topics that face design engineers in the daily activity
            </p>
            <!-- Define application -->
            <div class="smc-tabs desktop mt-5">
                <div class="smc-tabs__head">
                    <ul class="nav w-100" role="tablist">
                        <li class="nav-item heading-0a subHeading-0a smc-tabs__head--active">
                            <a class="active"
                            data-toggle="tab"
                            role="tab"
                            aria-selected="true"><span class="psf-steps mr-3">1</span>Define the application</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-content">
                    <div id="accordion">
                        <div class="card">
                            <div class="card-header" id="headingOne">
                                <div class="row">
                                    <div class="col-6">
                                         <h5 class="text-secondary">General applications</h5>
                                    </div>
                                    <div class="col-6 text-right">
                                        <div class="row p-0 m-0">
                                            <div class="col-11 pr-0 mr-0 text-right">
                                                <h5 class="mr-4 font-weight-bold pr-0 mr-0" data-bind="text:applicationGeneral"></h5>
                                            </div>
                                            <div class="col-1 ml-0 pl-0">
                                                <span class="ml-4 icon-plus-details" data-toggle="collapse" data-target="#collapseOne" aria-controls="collapseOne" role="button" aria-expanded="false">
                                                    <i class="fa fa-plus"></i>
                                                </span>
                                           </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="General Circuits"
                                                        data-toggle="collapse"
                                                        data-target="#collapseOne"
                                                        aria-controls="collapseOne"
                                                        role="button"
                                                        data-bind="click:handleApplication">

                                                        <img src="<@hst.webfile path='/images/psf/circuitElectric.svg'/>" alt="Combinaciones FRL" class="">
                                                            <span class="category-tile__image__mask"></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">General circuits</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row  psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Pneumatic actuation"
                                                        role="button"
                                                        data-bind="">

                                                        <img src="<@hst.webfile path='/images/psf/pneumatic.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Pneumatic actuation</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Safety pneumatic circuits"
                                                        role="button"
                                                        data-bind="">

                                                        <img src="<@hst.webfile path='/images/psf/safetyPneumatic.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Safety pneumatic actuation</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Gripping applications"
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/gripping.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Gripping applications</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Sensing & monitoring"
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/measure.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Sensing & monitoring</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Cooling applications"
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/cool.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Cooling applications</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingTwo">
                                <div class="row">
                                    <div class="col-6">
                                        <h5 class="text-secondary">
                                            A bit more in detail
                                        </h5>
                                    </div>
                                    <div class="col-6 text-right">
                                        <div class="row p-0 m-0">
                                            <div class="col-11 pr-0 mr-0 text-right">
                                                <h5 class="mr-4 font-weight-bold pr-0 mr-0" data-bind="text:applicationDetail"></h5>
                                            </div>
                                            <div class="col-1 ml-0 pl-0">
                                                <span id="btn_collapseTwo" style="display: none" class="ml-4 icon-plus-details" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" role="button" aria-expanded="false">
                                                    <i class="fa fa-plus"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="General pneumatic circuits"
                                                        data-toggle="collapse"
                                                        data-target="#collapseTwo"
                                                        aria-controls="collapseTwo"
                                                        role="button"
                                                        data-bind="click:handleApplication">

                                                        <img src="<@hst.webfile path='/images/psf/pneumaticCircuits.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class="category-tile__image__mask"></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">General pneumatic circuits</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row  psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Water circuits" >

                                                        <img src="<@hst.webfile path='/images/psf/waterCircuits.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Water circuits</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="High pressure air circuits">

                                                        <img src="<@hst.webfile path='/images/psf/preassureAir.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">High pressure air circuits</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Nitrogen circuits">

                                                        <img src="<@hst.webfile path='/images/psf/nitrogeno.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Nitrogen circuits</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Vacuum circuits">

                                                        <img src="<@hst.webfile path='/images/psf/vaccumCircuits.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Vacuum circuits</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Lubrication circuits">

                                                        <img src="<@hst.webfile path='/images/psf/lubricationCircuits.svg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Lubrication circuits</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingThree">
                                <div class="row">
                                    <div class="col-6">
                                        <h5 class="text-secondary">
                                             Air purity class ISO8573-1:2010
                                        </h5>
                                    </div>
                                    <div class="col-6 text-right">
                                        <div class="row p-0 m-0">
                                            <div class="col-11 pr-0 mr-0 text-right">
                                                <h5 class="mr-4 font-weight-bold pr-0 mr-0" data-bind="text:applicationConditions"></h5>
                                            </div>
                                            <div class="col-1 ml-0 pl-0">
                                                <span id="btn_collapseThree" style="display: none" class="ml-4 icon-plus-details" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" role="button" aria-expanded="false">
                                                    <i class="fa fa-plus"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --large js--LazyImageContainer image-shown"
                                                        data-btn="Lubrication circuits">
                                                            <img src="<@hst.webfile path='/images/psf/WaterDroplets-sin.jpg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Water droplets removed air</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row  psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --large js--LazyImageContainer image-shown"
                                                        data-btn="Dry air with temperature drop">
                                                            <img src="<@hst.webfile path='/images/psf/WaterDroplets-sin.jpg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Dry air with temperature drop</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --large js--LazyImageContainer image-shown"
                                                        data-btn="2, 4, 3 - Dry air for pneumatic use"
                                                        data-toggle="collapse"
                                                        data-target="#collapseThree"
                                                        aria-controls="collapseThree"
                                                        role="button"
                                                        data-bind="click:handleApplication">
                                                            <img src="<@hst.webfile path='/images/psf/DryAirForPneum-sin.jpg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class="category-tile__image__mask"></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Dry air for pneumatic use</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --large js--LazyImageContainer image-shown"
                                                        data-btn="Dry air C">
                                                            <img src="<@hst.webfile path='/images/psf/DryCleanAir-1-sin.jpg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Dry & clean air</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --large js--LazyImageContainer image-shown"
                                                        data-btn="Dry & clean air">
                                                            <img src="<@hst.webfile path='/images/psf/DryCleanAir-2-sin.jpg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Dry & clean air</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-10 mx-auto">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --large js--LazyImageContainer image-shown"
                                                        data-btn="Low dew point clean air">
                                                            <img src="<@hst.webfile path='/images/psf/LowDew-sin.jpg'/>" alt="Combinaciones FRL" class="p-md-5 p-lg-1">
                                                            <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Low dew point clean air</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Define application -->
            <!-- Define the additional parameters of suitable products -->
            <div class="smc-tabs desktop mt-5" style="display:none" id="container_additionalParameters">
                <div class="smc-tabs__head">
                    <ul class="nav w-100" role="tablist">
                        <li class="nav-item heading-0a subHeading-0a smc-tabs__head--active">
                            <a class="active"
                            data-toggle="tab"
                            role="tab"
                            aria-selected="true"><span class="psf-steps mr-3">2</span>Define the additional parameters of suitable products</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-content" >
                    <div class="row">
                        <div class="col-lg-6 col-12 mb-4">
                            <select class="selectpicker w-100" multiple data-live-search="true"  title="Flow rate" data-bind=" event:{ change:handleBestItems}">
                                <option class="w-100" disabled>12m³/h (200 Nl/min)</option>
                                <option  class="w-100" disabled>24m³/h (400 Nl/min)</option>
                                <option  class="w-100" disabled>36m³/h (600 Nl/min)</option>
                                <option  class="w-100" disabled>65m³/h (1000 Nl/min)</option>
                                <option  class="w-100">80m³/h (1300 Nl/min)</option>
                                <option  class="w-100" disabled>120m³/h (2000 Nl/min)</option>
                            </select>
                        </div>
                        <div class="col-lg-6 col-12">
                            <div class="product-catalogue-tile product-catalogue-tile--smallImage ">
                                <div class="category-tile__image js--LazyImageContainer image-shown">
                                    <img src="<@hst.webfile path='/images/psf/itemApplication.png'/>" class="w-50" alt="Electric Actuators" width="50%">
                                    <span class="category-tile__image__mask"></span>
                                </div>
                                <div class="category-tile__text text-01 pb-0 mb-0">
                                    <h2 class="heading-07 pb-0 mb-1">System description</h2>
                                    <div class="description">
                                        <ul class="pb-0 mb-0">
                                            <li>General pneumatic equipment</li>
                                            <li>General painting</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Define the additional parameters of suitable products -->
            <!-- Best items adapted to you -->
            <div class="smc-tabs desktop mt-5" style="display:none" id="container_bestItems">
                <div class="smc-tabs__head">
                    <ul class="nav w-100" role="tablist">
                        <li class="nav-item heading-0a subHeading-0a smc-tabs__head--active">
                            <a class="active"
                            data-toggle="tab"
                            role="tab"
                            aria-selected="true"><span class="psf-steps mr-3">3</span>And now the items that best adapts to you</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-content">
                    <p>The following buttons are related to the scheme above, please click on each of them to select the items you need. Do not forget to click on the summary button to see the complete list of items and work with it!</p>
                    <div class="row">
                        <div class="col-12">
                            <div class="psf-summary-container">
                                <div class="row">
                                    <div class="col-12 text-center">
                                        <div class="d-inline-block">
                                            <button class="btn btn-outline-primary" data-btn="A" data-bind="click:handleItemAdapted">
                                               <span class="h3"> A</span>
                                            </button>
                                            <span class="psf-check" id="check--a" style="display:none"</span>
                                        </div>
                                        <span class="p-2"><i class="fa fa-plus"></i></span>
                                        <div class="d-inline-block">
                                            <button  data-btn="B" data-bind="click:handleItemAdapted" class="btn btn-outline-primary">
                                               <span class="h3">B</span>
                                            </button>
                                            <span class="psf-check" id="check--b" style="display:none"></span>
                                        </div>
                                        <span class="p-2"><i class="fa fa-plus"></i></span>
                                        <div class="d-inline-block">
                                            <button  data-btn="C" data-bind="click:handleItemAdapted" class="btn btn-outline-primary">
                                               <span class="h3"> C</span>
                                            </button>
                                            <span class="psf-check" id="check--c" style="display:none"></span>
                                        </div>
                                        <div class="d-inline-block mr-3 ml-3 mb-5 mb-lg-0">
                                            <span class="h3">
                                                <i class="fa fa-arrow-right"></i>
                                            </span>
                                        </div>
                                        <button class="btn btn-primary compare-product-button mt-10 mt-sm-0 ml-2" disabled id="btn_disabled" data-bind="click:handleSummary">
                                            Summary
                                            <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                                            <i class="fa fa-list-alt"></i>
                                        </button>
                                        <button class="btn btn-primary compare-product-button mt-10 mt-sm-0 ml-4" >
                                            Add to basket
                                            <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                                            <i class="fa fa-shopping-cart"></i>
                                        </button>
                                        <button class="btn btn-outline-primary compare-product-button mt-10 mt-sm-0 ml-4" disabled id="btn_disabled_dowload">
                                            Download
                                            <i class="fade-icon__icon icon-download"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- ko if:aplicationItems().length> 0 -->
                    <div class="row">
                        <div class="col-12">
                            <div class="row d-block accordion spares-accessories-result-container" id="spares-accessories-result-container">
                                <div class="col-lg-12 mt-5">
                                    <div class="psf-table">
                                        <div class="psf-thead">
                                            <div class="row">
                                                <div class="col-12 col-md-1 pr-0">
                                                    <div class="custom-control custom-checkbox text-left">
                                                    <!-- ko if:isSummary() -->
                                                   <!--<input type="checkbox" class="form-check-input" id="select_all">-->
                                                    <!-- /ko -->
                                                    </div>
                                                </div>
                                                <div class="col-12 col-md-2 pl-lg-0">
                                                </div>
                                                <div class="col-12 col-md-2 p-lg-0"><strong>Part number</strong></div>
                                                <div class="col-12 col-md-3 p-md-0 p-lg-0"><strong>Product description</strong></div>
                                                <div class="col-12 col-md-2 p-md-0 p-lg-0"><strong>Price</strong></div>
                                                <div class="col-12 col-md-2 p-md-0 p-lg-0"><strong>Delivery</strong></div>
                                            </div>
                                        </div>
                                        <div class="psf-tbody">
                                            <!-- ko foreach:{data: aplicationItems} -->
                                            <div class="row tbody-row">
                                                <!-- ko if:$data.summary==1-->
                                                <div class="col-12 col-md-1 pr-0">
                                                    <div class="custom-control custom-checkbox text-left">
                                                        <button class="btn btn-outline-primary">
                                                            <span class="h3"> A</span>
                                                        </button>
                                                    </div>
                                                </div>
                                                <!-- /ko -->
                                                <!-- ko if:$data.summary==2 -->
                                                <div class="col-12 col-md-1 pr-0">
                                                    <div class="custom-control custom-checkbox text-left">
                                                        <button class="btn btn-outline-primary">
                                                            <span class="h3"> B</span>
                                                        </button>
                                                    </div>
                                                </div>
                                                <!-- /ko -->
                                                <!-- ko if:$data.summary==3 -->
                                                <div class="col-12 col-md-1 pr-0">
                                                    <div class="custom-control custom-checkbox text-left">
                                                        <button class="btn btn-outline-primary">
                                                            <span class="h3"> C</span>
                                                        </button>
                                                    </div>
                                                </div>
                                                <!-- /ko -->
                                                <!-- ko if:$data.summary==0 -->
                                                <div class="col-12 col-md-1 pr-0">
                                                    <div class="custom-control custom-checkbox text-left">
                                                        <input type="checkbox" dclass="form-check-input" data-bind="attr: { id:'check_'+$data.partNumber, disabled:$data.isDisabled},click:$parent.handleCheckboxItem">
                                                    </div>
                                                </div>
                                                <!-- /ko -->
                                                <div class="col-12 col-md-2">
                                                    <figure class="mb-1 cct-list-figure">
                                                        <img class="cm-row-img psf-img" data-bind="attr:{src: $data.image}" alt="SMC SERIE"  width="60%">
                                                    </figure>
                                                </div>
                                                <div class="col-12 col-md-2 pl-lg-0 text-uppercase" data-bind="text:$data.partNumber"></div>
                                                <div class="col-12 col-md-3 p-lg-0" data-bind="text:$data.description"></div>
                                                <div class="col-12 col-md-2 p-lg-0" data-bind="text:$data.price"></div>
                                                <div class="col-12 col-md-2 p-lg-0" data-bind="text:$data.delivery"></div>
                                            </div>
                                             <!-- /ko -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /ko -->
                </div>
            </div>
            <!-- /Best items adapted to you -->
        </div>
    </main>
</div>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/productssolutionsfinder/ProductsSolutionsFinderByApplicationViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>