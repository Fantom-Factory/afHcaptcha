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
	
	public void iAmHere() { }
	public boolean hasLoaded() { return false; }
	public String doRender(String containerId, Map params) { return ""; }
	public void doReset(String widgetId) { }
}	
