<div class="container desktop etools-container" data-swiftype-index="false">
    <div>
        <div id="divForm" style="display: none;">
            <form id="loadProjectFileForm">
                <input type="file" name="myFile" id="fileOriginal">
                <input type="submit" value="Open file*" id="fileSubmit">
            </form>
        </div>
        <p class="alert alert-info text-center">
            <span><@fmt.message key="etools.loadconfiguration"/>
                <a href="#" onclick="" id="etoolsSubmitFileButton"> <strong><@fmt.message key="etools.clickhere"/> </strong></a></span>
        </p>
        <span id="invalidConfig" style="padding: 10px 8px; border: 2px solid #FF191F;
    border-radius: 6px; display: none;">Invalid/incomplete configuration</span>
        <span id="validConfig" style="padding: 10px 8px; border: 2px solid #0BDF00;
    border-radius: 6px; display: none;">Valid Configuration</span>


        <button class="btn btn-primary" onclick="GetConfig()">Save Project</button>
        <span id="SimpleSpecial" style="width:200px;height:60px;margin:0 10px"></span>
    </div>
    <iframe id="ffrl3D" name="ffrl3D"
            src="https://etoolstest.smc.at/config/frl3d/index.html?view=embedded&country=${country}&language=${lang}"
            width="100%" height="560px" style="border: 1px solid #ffffff; display: block;">
    </iframe>
</div>

<div class="hidden" data-swiftype-index='false'>
    <a id="getErpInfoUrl" class="hidden" href="<@hst.resourceURL resourceId='getErpInfo'/>"></a>
</div>

<script type="text/javascript">
    var smc = window.smc || {};
    smc.isAuthenticated = ${isAuthenticated?c};
    smc.etools = smc.etools || {};
    smc.etools.urls = {
        getErpInfo: document.getElementById('getErpInfoUrl').href
    };
    window.partNumberList = [];


    $(document).ready(function () {
        var loadProjectFileForm = document.getElementById('loadProjectFileForm');
        $(loadProjectFileForm).submit(function () {
            //get file here
            var file = this.elements.fileOriginal.files[0];

            var fileReader = new FileReader();
            fileReader.onload = function (e) {
                file.content = e.target.result;
                $(document).trigger('smc.productConfiguratorComponent.loadProjectFile', file);
            };
            fileReader.readAsText(file);
            return false;
        });

        var fileOriginal = document.getElementById('fileOriginal');
        if (fileOriginal) {
            fileOriginal.onchange = onChange;
        }

        function onChange(e) {
            if (!$(fileOriginal).val()) {
                return;
            }
            var splits = $(fileOriginal).val().split("\\");
            var uploadedFile = splits [splits.length - 1];
            if (uploadedFile.substring(uploadedFile.length - 4) === uploadedFile.substring(0, 4) && uploadedFile.substring(0, 4) === "frl3") {
                $("#fileSubmit").click();
            }
        }

        $("#etoolsSubmitFileButton").click(function () {
            $(fileOriginal).click();
        });
    });
</script>

<style>
    .etools-container .btn-primary {
        margin: 10px;
    }

    #BOM td {
        padding: 10px;
    }

    .idbl_hto__content__addtobasketbar {
        display: none;
    }

</style>