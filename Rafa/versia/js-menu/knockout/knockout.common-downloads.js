/**
 * Global common download utils for Knockout
 * @author Mikel Cano
 */
(function(globalKoDownloads){

    /**
     * Creates a <a href> element with a Url and simulates click
     * @param url Url to generate download
     */
    function generateDownloadFromUrl(url) {
        var element = document.createElement('a');
        element.setAttribute('href', url);
        element.setAttribute('download', url);
        element.style.display = 'none';
        document.body.appendChild(element);
        element.click();
        document.body.removeChild(element);
    }

    /**
     * Creates a new tab to download file
     * Can use for open new tab for navigation but isnt created for that purposes
     * @param url Url to generate download
     * @param newTab To create new tab
     */
    function generateDownloadOpen(url, newTab) {
        if(newTab) {
            window.open(url, '_blank');
        } else {
            window.open(url);
        }
    }

    globalKoDownloads.koDownloadUtils = {
        generateDownloadFromUrl: generateDownloadFromUrl,
        generateDownloadOpen: generateDownloadOpen
    }

})(window);