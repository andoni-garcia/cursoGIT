var Event = Class.extend({
	init: function(name,data){
		if (typeof name !== 'undefined') this.name = name;
		if (typeof data !== 'undefined') this.data = data;
	}
});