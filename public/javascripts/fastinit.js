var FastInit = {
	done : false,
	onload : function() {
		if (FastInit.done) return;
		FastInit.done = true;
		FastInit.actions.each(function(func) {
			func();
		})
	},
	actions : $A([]),
	addOnLoad : function() {
		for(var x = 0; x < arguments.length; x++) {
			var func = arguments[x];
			if(!func || typeof func != 'function') continue;
			FastInit.actions.push(func);
		}
	}
}
if (/WebKit|khtml/i.test(navigator.userAgent)) {
	var _timer = setInterval(function() {
        if (/loaded|complete/.test(document.readyState)) {
            clearInterval(_timer);
            delete _timer;
            FastInit.onload();
        }
	}, 10);
}
if (document.addEventListener) {
	document.addEventListener('DOMContentLoaded', FastInit.onload, false);
	FastInit.legacy = false;
}
Event.observe(window, 'load', FastInit.onload);