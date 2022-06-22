ko.extenders.toUpperCase = function(target) {
    var result = ko.pureComputed({
        read: target,
        write: function(newValue) {
        	target(newValue.toUpperCase());
        }
    }).extend({ notify: 'always' });
    result(target());
    return result;
};