<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<@hst.setBundle basename="SearchPage,SearchBar"/>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/components/etools/porthole.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<div class="container desktop" data-swiftype-index="false">
    <div style="font-size:10px;margin-bottom:10px">
        <button onclick="GetPDF()">Get PDF</button>
        <button onclick="GetConfig()">Get Config</button>
        <button onclick="GetBOM()">Get BOM</button>
        <div id="SimpleSpecial" style="width:100%;height:60px"></div>
        <div id="ValidConfig" style="width:200px;height:16px"></div>
        <div id="ValidConfig" style="width:200px;height:16px"></div>
        <table id="BOM"></table>
    </div>
    <iframe id="vikFrame" name="vikFrame"
            src="https://etools.smc.at/config/vik/index.html?country=es&language=es"
            width="100%" height="1000px" style="border: 1px solid #ffffff">
    </iframe>
</div>


<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        var windowProxy;
        function GetPDF() {
            var data = new Object();
            // load files per using the following commands:
            // 'getpdf' download of assembly sheet in pdf format
            // 'getxls' download of Excel sheet with bom
            // 'getconfig' download of configuration file
            data.cmd = 'getpdf';
            windowProxy.post(data);
        }
        function GetConfig() {
            var data = new Object();
            // load files per using the following commands:
            // 'getpdf' download of assembly sheet in pdf format
            // 'getxls' download of Excel sheet with bom
            // 'getconfig' download of configuration file
            data.cmd = 'getconfig';
            windowProxy.post(data);
        }
        function GetBOM() {
            var data = new Object();
            data.cmd = 'bom';
            windowProxy.post(data);
        }
        function onMessage(msg) {

            //var data = JSON.parse(msg.data)
            var data = msg.data; // get the data of the message
            if (data.error > 0) { // error exists, contains the error code, otherwise 0 or does not exists
                alert(data.message); // error message
                return;
            }
            switch (data.cmd) { // command from the tool
                case 'ready': // application is ready, everything got loaded
                    // tell the tools that there is someone listening (alternative use "setting")
                    // otherwise communication will not start
                    var data = new Object();
                    data.cmd = 'listening';
                    windowProxy.post(data);
                    login();
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
                    }
                    else {
                        div.innerText = 'Error: ' + data.error + ' ' + data.msg;
                    }
                    break;
                case 'file': // recieve a file - we requested these by the GetPDF() function above
                    window.open(data.filename, '_blank');
                    break;
                case "valid": // react if a config changes from valid to invalid or vice versa
                    var div = document.getElementById('ValidConfig');
                    if (data.valid == true) {
                        div.innerHTML = 'Valid Configuration';
                        div.style.backgroundColor = '#5f5';
                    }
                    else {
                        document.getElementById('BOM').innerHTML = ''; ;
                        div.innerHTML = 'Invalid/incomplete configuration';
                        div.style.backgroundColor = '#f00';
                    }
                    break;
                case 'bom': // receive the BOM
                    var table = document.getElementById('BOM');
                    table.innerHTML = '';
                    data.lines.forEach(function (line) {
                        var tr = document.createElement('tr');
                        var tdIndex = document.createElement('td');
                        tdIndex.innerHTML = line.idx;
                        var tdOC = document.createElement('td');
                        tdOC.innerHTML = line.oc;
                        var tdText = document.createElement('td');
                        tdText.innerHTML = line.txt;
                        var tdQty = document.createElement('td');
                        tdQty.innerHTML = line.qty;
                        tr.appendChild(tdIndex);
                        tr.appendChild(tdOC);
                        tr.appendChild(tdText);
                        tr.appendChild(tdQty);
                        table.appendChild(tr);
                    });
                    break;
                case 'openwindow':
                    window.open(data.link, data.target, data.params);
                    break;
            }
        }

        window.onload = function () {
            windowProxy = new Porthole.WindowProxy('https://etools.smc.at/config/vik/proxy.html', 'vikFrame');
            windowProxy.addEventListener(onMessage);
        };
        function login() {
            var data = new Object(); // prepare data, all property names in lowercase
            data.cmd = 'login';
            // add data here...
            data.username = ''; // keep this field, empty if not used
            data.password = ''; // keep this field, empty if not used
            data.cusid = '12345';
            data.cusname = 'my name';
            data.cusmail = 'myemail@smc.at';
            data.token = '';
            windowProxy.post(data);
        }
    </script>
</@hst.headContribution>