function ProfileRepository(){
    var self = this;

	ko.di.register(self,"ProfileRepository");
    ko.di.require({jq : "jQuery"},self);
    
    self.doUpdatePassword = function(password, callback){        
        $.ajaxHippo($.extend({
			type : "POST",
            url : profileUpdatePasswordUrl + '&pwd=' + encodeURIComponent(password),
        },callback));
    }

    self.doDeleteUser = function(callback){
        $.ajaxHippo($.extend({
            type: 'POST',
            url: profileDeleteUrl,
        }, callback));
    }
}