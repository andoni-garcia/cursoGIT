function exportCI() {
    var items = document.getElementsByClassName("ci_checkbox");
    var namesArray = [];

    for (let item of items) {
        if(item.checked) {
            namesArray.push(item.value);
        }
    }

    $.get(
        "/site/smcapi/intranet/communication-images/rest/exportCommunicationImages",
        {'CINames' : namesArray},
        function(data) {
          window.location.href = data;
        }
    );

}