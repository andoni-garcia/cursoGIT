  youtube = function() {
     var tag = document.createElement('script');

     tag.src = "https://www.youtube.com/iframe_api";
     var firstScriptTag = document.getElementsByTagName('script')[0];
     firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
   }

   var player;
   function onYouTubeIframeAPIReady() {
    if (typeof idsArray == 'undefined') {

	} else {
		for (i = 0; i < idsArray.length; i++) {
             player = new YT.Player(idsArray[i].videoDivId, {
               height: '1080',
               width: '1920',
               videoId: idsArray[i].videoID,
               events: {
                 'onReady': onPlayerReady
               },
               playerVars: {
                 'autoplay': 1,
                 'controls': 0,
                 'disablekb': 1,
                 'fs': 0,
                 'loop': 1,
                 'modestbranding': 1,
                 'rel': 0,
                 'mute': 1,
                 'autohide': 1,
                 'playlist': idsArray[i].videoID
               }
             });
        }	
	}  
   }



   function onPlayerReady() {
   }

   youtube();