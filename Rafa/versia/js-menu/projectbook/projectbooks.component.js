function ProjectBooksComponent(){
    let self = this;
    let menuItem = document.getElementById('pb-menu-item');

    const updateHasProjectBooks = function(){
        $.ajaxHippo({
            url: hasProjectBooksUrl,
            async: true,
            method: 'POST',
            success: function(res){
                if (res) {
                    $(menuItem).removeClass('hidden');
                }
            },
            error: function(){
            }
        })


    }

    window.onload = updateHasProjectBooks()
}