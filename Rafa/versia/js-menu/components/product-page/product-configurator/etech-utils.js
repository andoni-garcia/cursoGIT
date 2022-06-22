//IE polyfill entries
if (!Object.entries) {
    Object.entries = function( obj ){
        var ownProps = Object.keys( obj ),
            i = ownProps.length,
            resArray = new Array(i); // preallocate the Array
        while (i--)
            resArray[i] = [ownProps[i], obj[ownProps[i]]];

        return resArray;
    };
}
// Updates configurator options with a given list of parameters map
function updateEtechConfigurator(config) {
    console.log("updateEtechConfigurator()", config);
    var oDomains = undefined;
    if (window.oDomains !== null && window.oDomains !== undefined){
        oDomains = window.oDomains;
    }
    if (oDomains) {
        var configValues = Object.entries(config);
        var domains = oDomains.domains;
        for (var element in domains) {
            var domain = domains[element];

            configValues.forEach(function (value) {
                var configValue = value[1];
                var configCode = value[0];
                if (domain.code === configCode) {
                    console.log("updateEtechConfigurator() - Found " + domain.code);
                    configValueInDomain(configValue, domain);
                } else {
                    // Check if splitted code equals value
                    var splittedCode = domain.code.split(',');
                    if (splittedCode.length > 1) {
                        splittedCode.forEach(function (code) {
                            if (code === configCode) {
                                console.log("updateEtechConfigurator() - Found " + code);
                                configValueInDomain(configValue, domain);
                            }
                        });
                    }
                }
            });
        }

    }
}

function configValueInDomain(configValue, domain) {
    console.log("updateEtechConfigurator() - Config value to check", configValue);

    // Configurable domain found
    console.log("updateEtechConfigurator() - Configurable domain found", domain.did, domain.code, configValue);

    var members = domain.members;
    for (var element in members) {
        var member = members[element];
        if (domain.dtype === 'D_INTEGER_RANGE') {
            if (getEtechConfigValues()[domain.did] !== configValue) {
                console.log("updateEtechConfigurator() - Configurable member must be changed", member.id, configValue);
                // View ranges to obtain member id
                oDomains.setDomain(domain.did, member.id, Domain.UserSet, configValue);
                $("input[name$=" + domain.did + "]").val(configValue);
                $('select[name^=dom_]').first().trigger('change');
            } else {
                console.log("updateEtechConfigurator() - Configurable member not changed", member.id, configValue);
            }
        } else {
            if (configValue === member.code) {
                // Configurable domain found
                console.log("updateEtechConfigurator() - Configurable member found", member.id, configValue);
                var defaultOptionChecked = ($("#dom_"+domain.did+" option[selected='']").val() === "" || $("#dom_"+domain.did+" option[selected='']").val() === "&middot;" );
                if (getEtechConfigValues()[domain.did] !== configValue || defaultOptionChecked ) {
                    console.log("updateEtechConfigurator() - Configurable member must be changed", member.id, configValue);

                    oDomains.setDomain(domain.did, member.id, Domain.UserSet);
                    $('select[name=dom_' + domain.did + ']').val(member.id);
                    $('select[name=dom_' + domain.did + ']').trigger('change');
                } else {
                    console.log("updateEtechConfigurator() - Configurable member not changed", member.id, configValue, member);
                }
            } else {
                // Check if splitted configValue equals member code
                var splittedMemberCode = member.code.split(',');

                if (splittedMemberCode.length > 1) {
                    splittedMemberCode.forEach(function (memberCode) {
                        if (configValue === memberCode) {
                            console.log("updateEtechConfigurator() - Configurable member found", member.id, memberCode);
                            var defaultOptionChecked = ($("#dom_"+domain.did+" option[selected='']").val() === "" || $("#dom_"+domain.did+" option[selected='']").val() === "&middot;" );
                            if (getEtechConfigValues()[domain.did] !== memberCode || defaultOptionChecked ) {
                                console.log("updateEtechConfigurator() - Configurable member must be changed", member.id, memberCode);

                                oDomains.setDomain(domain.did, member.id, Domain.UserSet);
                                $('select[name=dom_' + domain.did + ']').val(member.id);
                                $('select[name=dom_' + domain.did + ']').trigger('change');
                            } else {
                                console.log("updateEtechConfigurator() - Configurable member not changed", member.id, memberCode, member);
                            }
                        }
                    });
                }
            }
        }
    }
}

function updateEtechConfiguratorValue(domainCode, valueCode) {
    if (domainCode === undefined || valueCode === undefined) {
        return;
    }

    console.log("updateEtechConfiguratorValue()", domainCode, valueCode);
    var oDomains = undefined;
    if (window.oDomains !== null && window.oDomains !== undefined){
        oDomains = window.oDomains;
    }
    if (oDomains) {
        var domains = oDomains.domains;

        for (var element in domains) {
            var domain = domains[element];

            if (domain.code === domainCode) {
                configValueInDomain(valueCode, domain);
            }
        }

    }
}

function getEtechConfigValues() {
    var configValues = {};
    var partArray = oDomains.getPartNumber();

    var partBlock = '';
    var formattedStroke = "";
    for (var i=0; i<partArray.length; i++) {
        var oDom = oDomains.cpcarray[i];
        if(oDom.dtype !== 'D_CONSTANT' && oDom.label !== '-' && oDom.label !== '-X' && oDom.label !== '(' && oDom.label !== ')' && oDom.label !== ',') {
            partBlock = partArray[i];
            if (oDom.hasSelection()) {
                try {
                    partBlock = DomInputValProcessor(oDom);
                    if (partBlock === "") {
                        partBlock = partArray[i];
                    }
                    if (oDom.code === 'STROKE' || oDom.code === 'STROKEA' || oDom.code === 'STROKEB') {
                        formattedStroke = partBlock;
                    }
                } catch (myexcept) {
                }
            }

            configValues[oDom.did] = '' + partBlock;
        }
    }

    return configValues;
}

function decomposeFilters(filters) {
    var decomposedFilters = [];

    filters.forEach(function(value) {
        var filterKeys = value.code.split(',');
        var filterValues = value.value.split(',');

        filterKeys.forEach(function(key) {
            console.log(key);
            filterValues.forEach(function(value) {
                var filterValue = {};
                filterValue.code = key;
                filterValue.value = value;

                decomposedFilters.push(filterValue);
            });
        });
    });

    return decomposedFilters;
}