var windowProxy;

function OpenConfiguration() {
    var data = new Object();
    data.cmd = 'open';
    data.name = 'seriesD';
    data.params = [];
    data.params.push('Size=40');
    data.params.push('Thread=F');
    data.params.push('Port=02');
    postPortholeMessage(data);
    $("#ffrl3D").show();
}

function GetPDF() {
    var data = new Object();
    // load files per using the following commands:
    // 'getpdf' download of assembly sheet in pdf format
    // 'getxls' download of Excel sheet with bom
    // 'getconfig' download of configuration file
    data.cmd = 'getpdf';
    postPortholeMessage(data);
}

function GetConfig() {
    var data = new Object();
    // load files per using the following commands:
    // 'getpdf' download of assembly sheet in pdf format
    // 'getxls' download of Excel sheet with bom
    // 'getconfig' download of configuration file
    data.cmd = 'getconfig';
    postPortholeMessage(data);
}

function getBOMXLS() {
    var data = new Object();
    data.cmd = 'getxls';
    postPortholeMessage(data);
}

function getCAD() {
    var data = new Object();
    data.cmd = 'getfiles';
    data.cad = 1;
    data.cadparam = 'BMP2D';
    postPortholeMessage(data);
}

function getProductDocumentation() {
    var data = new Object();
    data.cmd = 'getfiles';
    data.docs = 1;
    postPortholeMessage(data);
}

function getCfgImage() {
    var data = new Object();
    data.cmd = 'getfiles';
    data.img = 1;
    postPortholeMessage(data);
}

function getBOM() {
    var data = new Object();
    data.cmd = 'bom';
    postPortholeMessage(data);
}

function emptyBOM() {
    $("#BOM").html("Complete a configuration");
    hideDetails();
}

// function setBomTimeout() {
//     setTimeout(function() {
//         getBOM();
//         setBomTimeout();
//     }, 5000);
// }

// setBomTimeout();

function showMessageOver3D() {
    var data = new Object();
    data.cmd = 'showmessage';
    data.header = 'Message Header';
    data.text = 'Message text';
    postPortholeMessage(data);
}

function loadSession() {
    let currentURL = new URL(window.location.href);
    let urlSearchData = currentURL.searchParams.get("sessionId");
    let session = urlSearchData ? urlSearchData : '';
    let country = window.smc.country || 'eu';
    let language = window.smc.language || 'en';

    $("#ffrl3D").attr("src", "https://etoolstest.smc.at/config/frl3d/index.html?view=embedded&id=" + session + "&country=" + country + "&language=" + language);
}

function applyCustomStyles() {
    var head = $("#ffrl3D").contents().find("head");
    var css = '<style type="text/css">' +
        '.webSmallButton{background-color: green;}; ' +
        '</style>';
    $(head).append(css);
}

function listenToConfigurationChanges() {
    var data = new Object();
    data.cmd = 'listening';
    postPortholeMessage(data);
}

function getImage() {
    var data = new Object();
    data.cmd = 'getimage';
    postPortholeMessage(data);
}

function uploadConfigFromFile(file) {
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function () {
        let fileBase64 = reader.result.split("base64,")[1];
        var data = new Object();
        data.cmd = 'upload';
        data.mode = 'base64';
        data.file = fileBase64;
        postPortholeMessage(data);
    };
    reader.onerror = function (error) {
        console.log('Error: ', error);
    };
    $("#fileOriginal").val("");
}

function onMessage(msg) {
    console.log("[eTools] Iframe message received --> ", msg);

    //var data = JSON.parse(msg.data)
    var data = msg.data; // <--- we are now sending json objects, offers more flexibility
    if (data.error > 0) { // error exists, contains the error code, otherwise 0 or does not exists
        // alert(data.message); // error message
        return;
    }
    switch (data.cmd) { // command from the tool
        case 'ready': // tool is ready and accepts communication
            // document.getElementById('sID').innerHTML = data.session;
            let currentURL = new URL(window.location.href);
            currentURL.searchParams.set("sessionId", data.session);
            window.history.replaceState({}, window.document.title, currentURL.toString());
            listenToConfigurationChanges();
            // configure the look and feel of the tool
            var settings = {};
            settings.cmd = 'settings';
            settings.style = {};
            settings.style.theme = 'light';
            // settings.style.view = 'embedded';
            settings.style.view = 'flat';
            settings.sidebar = 1;
            postPortholeMessage(settings);
            // login();
            if ($("#validConfig").is(":visible")) {
                getBOM();
            }
            break;
        // cmd: openwindow
        // link: link to web resource
        // target: target window (null, _blank etc)
        // params: null or style of new window
        case 'openwindow':
            window.open(data.link, data.target, data.params);
            break;
        case 'createsisp':
            var div = document.getElementById('SimpleSpecial');
            div.innerHTML = '';
            if (data.error == 0) {
                var sisp = document.createElement('a');
                sisp.innerHTML = data.simplespecial;
                sisp.href = data.location + data.files.configuration;
                sisp.target = '_blank';
                var assembly = document.createElement('a');
                assembly.innerHTML = 'Assembly Sheet';
                assembly.href = data.location + data.files.assemblysheet;
                assembly.target = '_blank';
                var xls = document.createElement('a');
                xls.innerHTML = 'Excel Sheet';
                xls.href = data.location + data.files.excelbom;
                xls.target = '_blank';
                div.appendChild(sisp);
                div.appendChild(document.createElement('br'));
                div.appendChild(assembly);
                div.appendChild(document.createElement('br'));
                div.appendChild(xls);
            } else {
                div.innerText = 'Error: ' + data.error + ' ' + data.msg;
            }
            break;
        case 'file': // recieve a file - we requested these by the GetPDF() function above
            if (window.etoolsHelpRequested) {
                window.eToolsFileUrl = data.filename;
            }
            else {
                window.open(data.filename, '_blank');
            }
            break;
        case "valid": // react if a config changes from valid to invalid or vice versa
            if (data.valid == true) {
                $("#invalidConfig").hide();
                $("#validConfig").show();
                $("#free_configuration_tab").removeClass("disabled");
                $("#cylinder-info-container__partnumber_switch").prop("disabled", false);
                getBOM();
            } else {
                document.getElementById('BOM').innerHTML = '';
                $("#validConfig").hide();
                $("#invalidConfig").show();
                $("#free_configuration_tab").addClass("disabled");
                $("#cylinder-info-container__partnumber_switch").prop("disabled", true);
                hideDetails();
                emptyBOM();
            }
            break;
        case 'bom': // receive the BOM
            var table = document.getElementById('BOM');
            $("#BOM").html("");
            table.innerHTML = '';
            window.partNumberList = [];
            data.lines.forEach(function (line) {
                window.partNumberList.push(line.oc);
                var tr = document.createElement('tr');
                var tdIndex = document.createElement('td');
                tdIndex.innerHTML = line.idx;
                var tdOC = document.createElement('td');
                tdOC.innerHTML = line.oc;
                var tdText = document.createElement('td');
                tdText.innerHTML = line.txt;
                var tdQty = document.createElement('td');
                tdQty.innerHTML = line.qty;
                var priceTableElement = document.createElement('td');
                tr.appendChild(tdIndex);
                tr.appendChild(tdOC);
                tr.appendChild(tdText);
                tr.appendChild(tdQty);
                tr.appendChild(priceTableElement);

                table.appendChild(tr);

                $(priceTableElement).attr("id", "price_" + line.oc);

                loadPrice(line.oc);

            });
            break;
        case "image":
            $("#summaryImage").prop("src", data.image);
            break;

    }
}

$(document).ready(function () {
    windowProxy = new Porthole.WindowProxy('https://etools.smc.at/config/vik/proxy.html', 'ffrl3D');
    windowProxy.addEventListener(onMessage);
    loadSession();
    $("#free_configuration_tab").click(function () {
        getBOM();
        hideDetails();
        getImage();
        window.smc.standardStockedItemsComponent.init();
    });
    listenToConfigurationChanges();
    focus();
    const listener = window.addEventListener('blur', () => {
        if (document.activeElement === document.querySelector('iframe')) {
            console.log('clicked on iframe')
            hideDetails();
            if (!$("#validConfig").is(":visible") && !$("#invalidConfig").is(":visible")) {
                //triggering valid check
                // let $cbAutoAddYBracketsI = $("#cbAutoAddYBracketsI");
                // if ($cbAutoAddYBracketsI.length > 0) {
                //     $cbAutoAddYBracketsI.click();
                //     $cbAutoAddYBracketsI.click();
                // }
                getBOM();
            }
        }
        window.removeEventListener('blur', listener);
    });
});

function newProject() {
    var data = {}; // prepare data, all property names in lowercase
    data.cmd = 'new';
    data.silent = false; // if silent = true config does not show a "save as" dialog
    postPortholeMessage(data);
}

function login() {
    var data = {}; // prepare data, all property names in lowercase
    data.cmd = 'login';
    // add data here...
    data.username = ''; // keep this field, empty if not used
    data.password = ''; // keep this field, empty if not used
    data.cusid = '12345';
    data.cusname = 'my name';
    data.cusmail = 'myemail@smc.at';
    data.token = '';
    postPortholeMessage(data);
}

function loadPrice(partNumber) {
    var data = {
        componentId: this.id,
        productId: 11111,
        partNumber: partNumber
    };
    var url = smc.etools.urls.getErpInfo;
    var $container = $("#price_" + partNumber);
    $.get(url, data)
        .then(function (response) {
            console.log(response);
            $container.html(response.listPrice);
        })
        .catch(function () {
            console.log("error obtaining price");
        });
}

function toggleTheme() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    if ($("#toggleTheme").attr("value") == "light") {
        settings.style.theme = 'dark';
        $("#toggleTheme").attr("value", "dark");
    } else if ($("#toggleTheme").attr("value") == "dark") {
        settings.style.theme = 'eu-emc';
        $("#toggleTheme").attr("value", "eu-emc");
    } else {
        settings.style.theme = 'light';
        $("#toggleTheme").attr("value", "light");
    }
    postPortholeMessage(settings);
}

function toggleView() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    if ($("#toggleView").attr("value") == "embedded") {
        settings.style.view = '';
        $("#toggleView").attr("value", "");
    } else if ($("#toggleView").attr("value") == "") {
        settings.style.view = 'tabs';
        $("#toggleView").attr("value", "tabs");
    } else if ($("#toggleView").attr("value") == "tabs") {
        settings.style.view = 'flat';
        $("#toggleView").attr("value", "flat");
    } else {
        settings.style.view = 'embedded';
        $("#toggleView").attr("value", "embedded");
    }
    postPortholeMessage(settings);
}

function resetView() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    settings.style.btns = new Object();
    if ($("#toggleReset").attr("value") == "0") {
        settings.style.btns.reset = 1;
        $("#toggleReset").attr("value", "1");
    } else {
        settings.style.btns.reset = 0;
        $("#toggleReset").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function toggleTransparent() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    settings.style.btns = new Object();
    if ($("#toggleTransparent").attr("value") == "0") {
        settings.style.btns.transparent = 1;
        $("#toggleTransparent").attr("value", "1");
    } else {
        settings.style.btns.transparent = 0;
        $("#toggleTransparent").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function toggleFloor() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    settings.style.btns = new Object();
    if ($("#toggleFloor").attr("value") == "0") {
        settings.style.btns.floor = 1;
        $("#toggleFloor").attr("value", "1");
    } else {
        settings.style.btns.floor = 0;
        $("#toggleFloor").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function toggleDimensions() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    settings.style.btns = new Object();
    if ($("#toggleDimensions").attr("value") == "0") {
        settings.style.btns.dimensions = 1;
        $("#toggleDimensions").attr("value", "1");
    } else {
        settings.style.btns.dimensions = 0;
        $("#toggleDimensions").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function toggleTheme2() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    settings.style.btns = new Object();
    if ($("#toggleTheme2").attr("value") == "0") {
        settings.style.btns.theme = 1;
        $("#toggleTheme2").attr("value", "1");
    } else {
        settings.style.btns.theme = 0;
        $("#toggleTheme2").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function toggleAr() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    settings.style.btns = new Object();
    if ($("#toggleAr").attr("value") == "0") {
        settings.style.btns.ar = 1;
        $("#toggleAr").attr("value", "1");
    } else {
        settings.style.btns.ar = 0;
        $("#toggleAr").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function toggleStyle() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    settings.style.btns = new Object();
    if ($("#toggleStyle").attr("value") == "0") {
        settings.style.btns.style = 1;
        $("#toggleStyle").attr("value", "1");
    } else {
        settings.style.btns.style = 0;
        $("#toggleStyle").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function toggleTags() {
    var settings = new Object();
    settings.cmd = 'settings';
    settings.style = new Object();
    settings.style.btns = new Object();
    if ($("#toggleTags").attr("value") == "0") {
        settings.style.btns.tags = 1;
        $("#toggleTags").attr("value", "1");
    } else {
        settings.style.btns.tags = 0;
        $("#toggleTags").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function toggleSidebar() {
    var settings = new Object();
    settings.cmd = 'settings';
    if ($("#toggleSidebar").attr("value") == "0") {
        settings.sidebar = 1;
        $("#toggleSidebar").attr("value", "1");
    } else {
        settings.sidebar = 0;
        $("#toggleSidebar").attr("value", "0");
    }
    postPortholeMessage(settings);
}

function postPortholeMessage(message) {
    console.log("[eTools] Sending message to iframe --> ", message);
    windowProxy.post(message);
}


