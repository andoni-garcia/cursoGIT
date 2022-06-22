/*
 * Copyright (c) 2018. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

var ProductCatalogue = (function () {

	var _conf = {
		fovElement: '.product-catalogue__list',
    tiles: '.product-catalogue .product-catalogue__list > li',
    tileTitle: '.product-catalogue-item__title',
    wordsInTitles: '.product-catalogue-item__title > span'
	};

  var tileW, tilesNr;
  var marginSize = 20;

	return {

    init: function() {

      tilesNr = $(_conf.tiles).length;
      this.addSpansToTitles();
      ProductCatalogue.renderColumns( ProductCatalogue.decideHowManyColumns() );
      $(window).on('resize', function() {
        ProductCatalogue.renderColumns( ProductCatalogue.decideHowManyColumns() );
      });
      $("#product-sales-information").on('hidden.bs.modal',  function() {
        ProductCatalogue.renderColumns( ProductCatalogue.decideHowManyColumns() );
      });
      ProductCatalogue.renderColumns( ProductCatalogue.decideHowManyColumns() )
    },

    renderColumns: function(columnsNr) {

      if( $(window).innerWidth() <992) {
        columnsNr = 1;
      }
      
      tileW = this.getTileWidth(columnsNr);

      $(_conf.tiles).css({
        'width': tileW,
        'margin-right': '20px'
      });
      var id;
      var i;
      var n = Math.floor(tilesNr/columnsNr);
      for(i=0;i<n;i++) {
        $($(_conf.tiles)[(i*(columnsNr)+columnsNr-1)]).css('margin-right', 0);
      }
    },

    getTileWidth: function(columnsNr) {
      var fovWidth = $(_conf.fovElement).innerWidth();
      var margW = (columnsNr-1) * marginSize;
      return Math.floor((fovWidth - margW)/columnsNr);
    },

    probeWidths: function() {
      var tw = {};
      for(var i=2;i<6;i++) {
        tw[i] = (this.getTileWidth(i) - 110);
      }
      return tw;
    },

    addSpansToTitles: function(callback) {
      var newText;
      for(var i=0;i<tilesNr;i++) {
        newText = this.getSpannedText(
          ($(_conf.tileTitle)[i].innerHTML).trim()
        );
        $(_conf.tileTitle)[i].innerHTML = newText;
      }
      if(callback) {
        callback();
      }
    },

    getSpannedText: function(toBeSpanned) {
      if (toBeSpanned !== undefined && toBeSpanned.indexOf("<span>") === -1) {
        var splittedText = (toBeSpanned.split(' '));
        var n = splittedText.length;
        var resultText = '';
        for(var i=0;i<n;i++) {
          resultText += '<span>'+splittedText[i]+' </span>';
        }
        return resultText;
      }
      return toBeSpanned;
    },

    getLongestWordWidth: function() {
      var wordsNr = $(_conf.wordsInTitles).length;
      var longestWord = 0;
      var newL;

      for(var i=0; i<wordsNr; i++) {
        newL = $($(_conf.wordsInTitles)[i]).innerWidth();
        longestWord = longestWord < newL ? newL : longestWord;
      }
      return longestWord;
    },

    decideHowManyColumns: function() {
      var tw = this.probeWidths();
      var longest = this.getLongestWordWidth();
      var ret = 2;
      if( longest < tw['5']) {
        ret = 4;
      } else if( longest < tw['4']) {
        ret = 4;
      } else if( longest < tw['3']) {
        ret = 3;
      }
      return ret;
    }

	};

}());