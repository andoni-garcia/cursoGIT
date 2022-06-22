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
    <main id="psfFuntionalitycontenedor">
        <div class="container">
            <h2 class="heading-08 color-blue mt-20">Navigation by Functionality</h2>
            <h1 class="heading-02 heading-main mb-4">Save time and eliminate errors by selecting a recommended product for your functionality</h1>
            <p class="">
                SMC’s expertise is now available in a new navigation system to help you in the design process of your machine by showing typical examples of the most common topics that face design engineers in the daily activity
            </p>
            <!-- Define funtionality -->
            <div class="smc-tabs desktop mt-5">
                <div class="smc-tabs__head">
                    <ul class="nav w-100" role="tablist">
                        <li class="nav-item heading-0a subHeading-0a smc-tabs__head--active">
                            <a class="active"
                            data-toggle="tab"
                            role="tab"
                            aria-selected="true"><span class="psf-steps mr-3">1</span>Define the functionality</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-content">
                    <div id="accordion">
                        <div class="card">
                            <div class="card-header" id="headingOne">
                                <div class="row">
                                    <div class="col-6">
                                         <h5 class="text-secondary">General functionalities</h5>
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
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Movement, Gripping & Clamping"
                                                        data-toggle="collapse"
                                                        data-target="#collapseOne"
                                                        aria-controls="collapseOne"
                                                        role="button"
                                                        data-bind="click:handleApplication">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Movement_Gripping_Clamping.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class="category-tile__image__mask"></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Movement, Gripping & Clamping</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row  psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Pneumatic directional control"
                                                        role="button"
                                                        data-bind="">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Pneumatic_directional_control.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Pneumatic directional control</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Cooling & Temperature Control"
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Cooling_Temperature_Control.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Cooling & Temperature Control</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Regulation & Control"
                                                        role="button"
                                                        data-bind="">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Regulation_Control.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Regulation & Control</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Pumping & Fluid control "
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Pumping_Fluidcontrol.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Pumping & Fluid control </h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Filtration & Purification"
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Filtration_Purification.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Filtration & Purification</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Connection & Piping"
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Connection_Piping.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Connection & Piping</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Measure & Monitor"
                                                        role="button"
                                                        data-bind="">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Measure_Monitor.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Measure & Monitor</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Static Electricity Elimination"
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Static_Electricity_Elimination.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Static Electricity Elimination</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Vacuum Generation & Control"
                                                        role="button"
                                                        data-bind="">
                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Vacuum_Generation_Control.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Vacuum Generation & Control</h2>
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
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Linear movement"
                                                        data-toggle="collapse"
                                                        data-target="#collapseTwo"
                                                        aria-controls="collapseTwo"
                                                        role="button"
                                                        data-bind="click:handleApplication">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Linear_movement.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class="category-tile__image__mask"></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Linear movement</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row  psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Rotary movement" >

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Rotary_movement.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Rotary movement</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Stopping movement">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Stopping_movement.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Stopping movement</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Gripping">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Gripping.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Gripping</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Vacuum circuits">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Clamping.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Clamping</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Lubrication circuits">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Dampening.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-1">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Dampening</h2>
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
                                            Intermediate positioning
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
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-toggle="collapse"
                                                        data-target="#collapseThree"
                                                        aria-controls="collapseThree"
                                                        role="button"
                                                        data-bind="click:handleApplication"
                                                        data-btn="No">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Positioning_No.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-4">
                                                            <span class="category-tile__image__mask"></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">No</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row  psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="1">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Positioning_1.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-4">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">1</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="2 or more" >

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Positioning_2or_more.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-4">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">2 or more</h2>
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
                            <div class="card-header" id="headingFour">
                                <div class="row">
                                    <div class="col-6">
                                        <h5 class="text-secondary">
                                            Lateral load
                                        </h5>
                                    </div>
                                    <div class="col-6 text-right">
                                        <div class="row p-0 m-0">
                                            <div class="col-11 pr-0 mr-0 text-right">
                                                <h5 class="mr-4 font-weight-bold pr-0 mr-0" data-bind="text:applicationLateralLoad"></h5>
                                            </div>
                                            <div class="col-1 ml-0 pl-0">
                                                <span id="btn_collapseFour" style="display: none" class="ml-4 icon-plus-details" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour" role="button" aria-expanded="false">
                                                    <i class="fa fa-plus"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordion">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-toggle="collapse"
                                                        data-target="#collapseFour"
                                                        aria-controls="collapseFour"
                                                        role="button"
                                                        data-bind="click:handleApplication"
                                                        data-btn="No">
                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Lateral_No.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-4">
                                                            <span class="category-tile__image__mask"></span>
                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">No</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row  psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                                                        data-btn="Yes">

                                                        <img src="<@hst.webfile path='/images/psf/funcionalidades/Lateral_Yes.jpg'/>" alt="Combinaciones FRL" class="p-4 p-lg-4">
                                                            <span class=""></span>

                                                        </div>
                                                        <div class="category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Yes</h2>
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
                            <div class="card-header" id="headingFive">
                                <div class="row">
                                    <div class="col-6">
                                        <h5 class="text-secondary">
                                            Output force
                                        </h5>
                                    </div>
                                    <div class="col-6 text-right">
                                        <div class="row p-0 m-0">
                                            <div class="col-11 pr-0 mr-0 text-right">
                                                <h5 class="mr-4 font-weight-bold pr-0 mr-0" data-bind="text:applicationOutpuForce"></h5>
                                            </div>
                                            <div class="col-1 ml-0 pl-0">
                                                <span id="btn_collapseFive" style="display: none" class="ml-4 icon-plus-details" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive" role="button" aria-expanded="false">
                                                    <i class="fa fa-plus"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordion">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Very low force" >
                                                        <div class="psf-category-description__container">
                                                            <div class="psf-category-description__vertical-center">
                                                                <p class="h1 text-uppercase font-weight-bold">~<20 N</p>
                                                            </div>
                                                        </div>
                                                        <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Very low force </h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row  psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Low force"
                                                        role="button"
                                                        data-bind="">
                                                        <div class="psf-category-description__container">
                                                            <div class="psf-category-description__vertical-center">
                                                                <p class="h1 text-uppercase font-weight-bold">20<~<100 N</p>
                                                            </div>
                                                        </div>
                                                        <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Low force</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Medium force"
                                                        role="button"
                                                        data-bind="">
                                                        <div class="psf-category-description__container">
                                                            <div class="psf-category-description__vertical-center">
                                                                <p class="h1 text-uppercase font-weight-bold">100<~<500 N</p>
                                                            </div>
                                                        </div>
                                                        <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Medium force</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="500<~<1000 N - Medium"
                                                        data-toggle="collapse"
                                                        data-target="#collapseFive"
                                                        aria-controls="collapseFive"
                                                        role="button"
                                                        data-bind="click:handleApplication">
                                                        <div class="psf-category-description__container">
                                                            <div class="psf-category-description__vertical-center">
                                                                <p class="h1 text-uppercase font-weight-bold">500<~<1000 N</p>
                                                            </div>
                                                        </div>
                                                        <span class="category-tile__image__mask"></span>

                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Medium force</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Large force "
                                                        role="button"
                                                        data-bind="">
                                                        <div class="psf-category-description__container">
                                                            <div class="psf-category-description__vertical-center">
                                                                <p class="h1 text-uppercase font-weight-bold">1000<~<4000 N</p>
                                                            </div>
                                                        </div>
                                                        <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Large force </h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Large force"
                                                        role="button"
                                                        data-bind="">
                                                        <div class="psf-category-description__container">
                                                            <div class="psf-category-description__vertical-center">
                                                                <p class="h1 text-uppercase font-weight-bold">4000<~<10000 N</p>
                                                            </div>
                                                        </div>
                                                        <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Large force</h2>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-btn="Very large force"
                                                        role="button"
                                                        data-bind="">
                                                        <div class="psf-category-description__container">
                                                            <div class="psf-category-description__vertical-center">
                                                                <p class="h1 text-uppercase font-weight-bold">~>10000 N</p>
                                                            </div>
                                                        </div>
                                                        <span class=""></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Very large force</h2>
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
                            <div class="card-header" id="headingFive">
                                <div class="row">
                                    <div class="col-6">
                                        <h5 class="text-secondary">
                                           Speed
                                        </h5>
                                    </div>
                                    <div class="col-6 text-right">
                                        <div class="row p-0 m-0">
                                            <div class="col-11 pr-0 mr-0 text-right">
                                                <h5 class="mr-4 font-weight-bold pr-0 mr-0" data-bind="text:applicationSpeed"></h5>
                                            </div>
                                            <div class="col-1 ml-0 pl-0">
                                                <span id="btn_collapseSix" style="display: none" class="ml-4 icon-plus-details" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix" role="button" aria-expanded="false">
                                                    <i class="fa fa-plus"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordion">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-4 mb-4">
                                            <div class="row psf-item--animation mt-3">
                                                <div class="col-lg-10 offset-lg-1">
                                                    <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage ">
                                                        <div class="category-tile__image psf-category-tile__image js--LazyImageContainer image-shown"
                                                        data-toggle="collapse"
                                                        data-target="#collapseSix"
                                                        aria-controls="collapseSix"
                                                        role="button"
                                                        data-bind="click:handleApplication"
                                                        data-btn="50<~<1000 mm/s - Normal" >
                                                        <div class="psf-category-description__container">
                                                            <div class="psf-category-description__vertical-center">
                                                                <p class="h1 font-weight-bold">50<~<1000 mm/s</p>
                                                            </div>
                                                        </div>
                                                        <span class="category-tile__image__mask"></span>
                                                        </div>
                                                        <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                                            <h2 class="heading-07 pb-0 mb-1">Normal speed </h2>
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
                        <div class="col-lg-3 col-12 col-md-6 mb-4">
                            <select class="selectpicker w-100" data-live-search="true"  multiple title="Bore size">
                                <option class="w-100" disabled>Ø 32mm</option>
                                <option class="w-100" disabled>Ø 40mm</option>
                                <option class="w-100">Ø 50mm</option>
                                <option class="w-100" disabled>Ø 63mm</option>
                            </select>
                        </div>
                        <div class="col-lg-3 col-12 col-md-6 mb-4">
                            <select class="selectpicker w-100" data-live-search="true" multiple title="Stroke">
                                <option class="w-100" disabled>5mm</option>
                                <option class="w-100" disabled>10mm</option>
                                <option class="w-100">20mm</option>
                                <option class="w-100" disabled>30mm</option>
                                <option class="w-100" disabled>40mm</option>
                                <option class="w-100" disabled>50mm</option>
                                <option class="w-100" disabled>60mm</option>
                                <option class="w-100" disabled>80mm</option>
                                <option class="w-100" disabled>100mm</option>
                                <option class="w-100" disabled>150mm</option>
                                <option class="w-100" disabled>200mm</option>
                            </select>
                        </div>
                        <div class="col-lg-3 col-12 col-md-6 mb-4">
                            <select class="selectpicker w-100" data-live-search="true" multiple title="Cylinder type">
                                <option class="w-100">Standard</option>
                                <option class="w-100" disabled>Double rod</option>
                                <option class="w-100" disabled>Non-rotating</option>
                                <option class="w-100" disabled>With solenoid valve</option>
                            </select>
                        </div>
                        <div class="col-lg-3 col-12 col-md-6 mb-4">
                            <select id="psf-select-action" class="selectpicker w-75" multiple title="Action"data-live-search="true" data-bind=" event:{ change:handleBestItems}">
                                <option class="w-100" disabled>Single acting, Spring return</option>
                                <option class="w-100" disabled>Single acting, Spring extended</option>
                                <option class="w-100">Double acting</option>
                            </select>
                            <span id="btn_collapseParameters"  class="ml-2 circle-icon-plus-details" data-toggle="collapse" data-target="#collapseParameters" aria-expanded="false" aria-controls="collapseParameters" role="button" aria-expanded="false">
                                                    <i class="fa fa-plus"></i>
                                                </span>
                            <!--<a href="#" title="Show more filters" class="mt-2 ssi-filter-btn-show ssi-filter-btn-show-js float-right mr-2"> <i class="fas fa-plus-circle fa-2x blue"></i></a>-->
                        </div>
                    </div>
                    <div id="collapseParameters" class="collapse" aria-labelledby="headingParameters" data-parent="#accordion">
                        <div class="row mt-3">
                            <div class="col-lg-3 mb-4">
                                <select class="selectpicker w-100" multiple data-live-search="true"  title="Magnet">
                                    <option class="w-100" disabled>None</option>
                                    <option class="w-100">Built-in</option>
                                </select>
                            </div>
                            <div class="col-lg-3 mb-4">
                                <select id="psf-select-rodEndThread" class="selectpicker w-100" multiple data-live-search="true"  title="Rod end thread" data-bind=" event:{ change:handleBestItems2}">
                                    <option class="w-100" disabled>Male</option>
                                    <option class="w-100">Female</option>
                                </select>
                            </div>
                            <div class="col-lg-3 mb-4">
                                <select disabled class="selectpicker w-100" data-live-search="true"  title="Cushion">
                                    <option class="w-100" disabled>Cushion 1</option>
                                    <option class="w-100" disabled>Cushion 2</option>
                                </select>
                            </div>
                            <div class="col-lg-3 mb-4">
                                <select disabled class="selectpicker w-75" data-live-search="true"  title="ISO dimensions">
                                    <option class="w-100" disabled>ISO dimensions 1</option>
                                    <option class="w-100" disabled>ISO dimensions 2</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-lg-3 mb-4">
                                <select disabled class="selectpicker w-100" data-live-search="true"  title="Auto switch mounting">
                                    <option class="w-100" disabled>None</option>
                                    <option class="w-100" disabled>Built-in</option>
                                </select>
                            </div>
                            <div class="col-lg-3 mb-4">
                                <select disabled class="selectpicker w-100" data-live-search="true"  title="Dimensions/shape">
                                    <option class="w-100" disabled>Shape 1</option>
                                    <option class="w-100" disabled>Shape 2</option>
                                </select>
                            </div>
                            <div class="col-lg-3 mb-4">
                                <select disabled class="selectpicker w-100" data-live-search="true"  title="Mounting">
                                    <option class="w-100" disabled>Mounting 1</option>
                                    <option class="w-100" disabled>Mounting 2</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-lg-10 mb-4">
                            <input class="form-control" type="text" id="" placeholder="Type in your search term">
                        </div>
                        <div class="col-lg-2">
                            <button class="w-100 btn btn-secondary btn-secondary--blue-border align-self-center ssi-filter-btn-all ssi-filter-btn-all-js ml-1">Show All</button>
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
                    <!--<p>The following buttons are related to the scheme above, please click on each of them to select the items you need. Do not forget to click on the summary button to see the complete list of items and work with it!</p>-->
                     <div class="row mb-5">
                        <div class="col-12">
                            <div class="psf-summary-container">
                                <div class="row">
                                    <div class="col-12 text-center">
                                        <button class="btn btn-primary compare-product-button mt-10 mt-sm-0 ml-0 ml-lg-2" disabled id="btn_summary" data-bind="click:handleSummary">
                                            Summary
                                            <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                                            <i class="fa fa-list-alt"></i>
                                        </button>
                                        <button class="btn btn-primary compare-product-button mt-10 mt-sm-0 ml-0 ml-lg-4" disabled id="btn_addBasket">
                                            Add to basket
                                            <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                                            <i class="fa fa-shopping-cart"></i>
                                        </button>
                                        <button class="btn btn-outline-primary compare-product-button mt-10 mt-sm-0 ml-0 ml-lg-4" disabled id="btn_disabled_dowload">
                                            Download
                                            <i class="fade-icon__icon icon-download"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" id="spares-accessories-result-container">
                        <div class="col-12" >
                            <table id="table_id" class="table table-striped table-bordered order-column psf-table" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>
                                            <!--<input type="checkbox" dclass="form-check-input" data-bind="attr: { id:'check_'+$data.partNumber, disabled:$data.isDisabled}">-->
                                        </th>
                                        <th style="width:8%;"></th>
                                        <th>Part number</th>
                                        <th>Product description</th>
                                        <th>Delivery time</th>
                                        <th>price</th>
                                    </tr>
                                </thead>
                                <tbody data-bind="dataTablesForEach : {
                                                    data: aplicationItems,
                                                    options: {
                                                        columnDef: [
                                                            {
                                                                orderable: false,
                                                                targets: 0
                                                            }
                                                        ],
                                                        language : {
                                                            zeroRecords: ''
                                                        },
                                                        order: [],
                                                        columns: [
                                                            { orderable: false },
                                                            { orderable: false },
                                                            { orderable: true },
                                                            { orderable: true },
                                                            { orderable: true },
                                                            { orderable: true }
                                                        ],
                                                        searching: false,
                                                        paging: false,
                                                        info:false
                                                    }
                                                }">
                                    <tr>
                                        <td>
                                            <input type="checkbox" class="form-check-input ml-1" data-bind="attr: { id:'check_'+Partnumber, disabled:IsDisabled},click:$parent.handleCheckboxItem">
                                        </td>
                                        <td style="width:8%;">
                                        <img class="psf-img w-100"  data-bind="attr:{src:Image}" alt="SMC SERIE" style="border-radius: 8%;">
                                        </td>
                                        <td data-bind="text:Partnumber"></td>
                                        <td data-bind="text:Description"></td>
                                        <td data-bind="text:Delivery"></td>
                                        <td data-bind="text:Price"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Best items adapted to you -->
        </div>
    </main>
</div>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/productssolutionsfinder/ProductsSolutionsFinderByFuntionalityViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<script>
$(document).ready( function () {
    /*var table=$('#table_id').DataTable({
        "columnDefs": [
            { "orderable": false, "targets": 0 }
        ],
        "language" : {
            "zeroRecords": " "
        },
        "order": [],
        "columns": [
            { "orderable": false },
            { "orderable": false },
            { "orderable": true },
            { "orderable": true },
            { "orderable": true },
            { "orderable": true }
        ],
        "searching": false,
        "paging": false,
        "info":false
    } );*/
} );
</script>