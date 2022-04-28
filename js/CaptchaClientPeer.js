
fan.afHcaptcha.CaptchaClientPeer = fan.sys.Obj.$extend(fan.sys.Obj);

fan.afHcaptcha.CaptchaClientPeer.prototype.$ctor = function(self) {}

fan.afHcaptcha.CaptchaClientPeer.prototype.iAmHere = function(self) {
	if (typeof afHcaptcha === "undefined") afHcaptcha = {};
	afHcaptcha.instance = self;
}

fan.afHcaptcha.CaptchaClientPeer.prototype.hasLoaded = function(self) {
	if (typeof afHcaptcha === "undefined") afHcaptcha = {};
	return afHcaptcha.loaded == true;
}

fan.afHcaptcha.CaptchaClientPeer.prototype.doRender = function(self, containerId, fanParams) {
	var params = {};
	if (fanParams != null)
		fanParams.$each(function(b) {
			params[b.key] = b.val;
		});

	var widgetId;
	params.callback = function(response) {
		self.widgetResponses().set(widgetId, response);
	};

	widgetId = hcaptcha.render(containerId, params);
	return widgetId;
}

fan.afHcaptcha.CaptchaClientPeer.prototype.doReset = function(self, widgetId) {
	hcaptcha.reset(widgetId);
}
