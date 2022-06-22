
                <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
                    <div class="simple-collapse__head">
                        <h2 class="heading-06 heading-semi-light">NEXT <@fmt.message key="CreateCustomConfigScratch"/></h2>
                    </div>
                    <div class="simple-collapse__body">


                        <div class="simple-collapse__bodyInner p-0">
                            <div id="" class="container_12">

                                <div class="row mb-3" style="">
                                    <div class="col-12 h4 mt-4">1. <@fmt.message key="ManyfoldType"/> <a href="${s3bucket}valve-configurator/${.locale}/JSY_Manifold_Types.pdf" target="_blank"><i id="manifoldInfo" class="fas fa-info-circle"></i></a></div>

                                     <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                            
                                                <span id="m_ip40" class="manyfold selSeriesElement sprite ip67 active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="PluginType"/></p>
                                            </a>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                            
                                                <span id="m_ip67" class="manyfold selSeriesElement sprite ip40 active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="NonPlugin"/></p>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3" style="">
                                    <div class="col-12 h4 mt-4">2. <@fmt.message key="PipingRedirection"/> <a href="${s3bucket}valve-configurator/${.locale}/JSY_Piping_redirection.pdf" target="_blank"><i id="pipingInfo" class="fas fa-info-circle"></i></a></div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="p_side" class="piping selSeriesElement sprite side active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="sidePorted"/></p>
                                            
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="p_bottom" class="piping selSeriesElement sprite bottom noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="bottomPorted"/></p>

                                        </div>
                                    </div>
                                    
                                </div>

                                <div class="row mb-3">
                                    <div class="col-12 h4 mt-4">3. <@fmt.message key="connectionType"/></div>
                                    <div class="col-12 h5 mt-4"><@fmt.message key="parallelConection"/> <a href="${s3bucket}valve-configurator/${.locale}/JSY_Connection_type_Parallel_wiring.pdf" target="_blank"><i id="parallelConnectionInfo" class="fas fa-info-circle"></i></a></div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                            <span id="c_dsub" class="connection selSeriesElement sprite dsub active"></span>
                                            <p class="m-0 p-2"><@fmt.message key="option.DSub"/></p>
                                        </div>
                                    </div>
                                    
                                    <!-- option
                                    -->
                                    <#if vcJsyInteriorEnabled>
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="c_flatribbon" class="connection selSeriesElement sprite flatribbon active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Flat"/></p>
                                            
                                        </div>
                                    </div>
                                    </#if>
                                    <!-- option 
                                    -->
                                    <#if vcJsyInteriorEnabled>
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="c_terminalblock" class="connection selSeriesElement sprite terminalblock active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Terminal"/></p>
                                        </div>
                                    </div>
                                    </#if>
                                    <!-- option 
                                    -->
                                    <#if vcJsyInteriorEnabled>
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="c_leadwire" class="connection selSeriesElement sprite leadwire active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Lead"/></p>
                                        </div>
                                    </div>
                                    </#if>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-12 h5 mt-4"><@fmt.message key="serialInterface"/> <a href="${s3bucket}valve-configurator/${.locale}/JSY_Connection_types_Serial_wiring.pdf" target="_blank"><i id="serialConnectionInfo" class="fas fa-info-circle"></i></a></div>
                                    <!-- option 
                                    -->
                                    <#if vcJsyInteriorEnabled>
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="c_ex120" class="connection selSeriesElement sprite ex120 active"></span>
                                                <p class="m-0 p-2">EX120</p>
                                        </div>
                                    </div>
                                    </#if>
                                    <!-- option -->
                                    <#if vcJsyInteriorEnabled>
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="c_ex250" class="connection selSeriesElement sprite ex250 active"></span>
                                                <p class="m-0 p-2">EX250</p>
                                        </div>
                                    </div>
                                    </#if>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="c_ex260" class="connection selSeriesElement sprite ex260 active"></span>
                                                <p class="m-0 p-2">EX260</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="c_ex600" class="connection selSeriesElement sprite ex600 active"></span>
                                                <p class="m-0 p-2">EX600</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2 d-none">
                                        <div class="select-option active">
                                                <span id="c_blank" class="connection selSeriesElement sprite blank active"></span>
                                                <p class="m-0 p-2">Blank</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-12 h4 mt-4">4. <@fmt.message key="solenoidValveSize"/> <a href="${s3bucket}valve-configurator/${.locale}/JSY_Optimum_actuation_size_chart_of_air_cylinder.pdf" target="_blank"><i id="valveInfo" class="fas fa-info-circle"></i></a></div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="v_sy1000" class="valve selSeriesElement sprite sy1000 noactive"></span>
                                                <p class="m-0 p-2">1000</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="v_sy3000" class="valve selSeriesElement sprite sy3000 noactive"></span>
                                                <p class="m-0 p-2">3000</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="v_sy5000" class="valve selSeriesElement sprite sy5000 noactive"></span>
                                                <p class="m-0 p-2">5000</p>
                                        </div>
                                    </div>
                                </div>
								<form id="form-selseries" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}" method="post">
                                    <input id="idGroup" name="idGroup" value="defaultValue" type="hidden">
                                    <input id="serie" name="serie" value="defaultValue" type="hidden">
                                    <span class="btn btn-primary noactive mt-4 mb-4" id="boton"><@fmt.message key="createCustomConfiguration"/></span>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>


	
