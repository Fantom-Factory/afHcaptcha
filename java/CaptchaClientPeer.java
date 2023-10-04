package fan.afHcaptcha;

import fan.sys.*;
import fan.dom.*;
import fanx.interop.*;

public class CaptchaClientPeer {

	private	CaptchaClient	self;

	public CaptchaClientPeer(CaptchaClient self) {
		this.self = self;
	}

	public static CaptchaClientPeer make(CaptchaClient fan) {
		return new CaptchaClientPeer(fan);
	}

	public void iAmHere(CaptchaClient self) { }
	public boolean hasLoaded(CaptchaClient self) { return true; }
	public String doRender(CaptchaClient self, String containerId, Map params) { return ""; }
	public void doReset(CaptchaClient self, String widgetId) { }
}
