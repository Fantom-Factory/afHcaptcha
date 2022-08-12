using web::WebClient
using util::JsonInStream

** (Service) - 
** To edit or view your hCaptcha account, visit `https://dashboard.hcaptcha.com/`.
** 
const class CaptchaServer {
	const Log		log			:= typeof.pod.log
	
	** The endpoint URL that tokens are verified against.
	const Uri		verifyUrl	:= `https://hcaptcha.com/siteverify`
	
	** The secretKey for the account.
	const Str		secretKey
	
	** The siteKey to verify against.
	const Str		siteKey
	
	** Disable for local dev.
	const Bool		enabled		:= true
	
	new make(|This| f) { f(this) }
	
	Uri captchaJsUrl() {
		`https://js.hcaptcha.com/1/api.js?render=explicit&onload=afHcaptchaOnLoadCallback`
	}

	Str	captchaJsFunc() {
		"""function afHcaptchaOnLoadCallback() { 
		    if (typeof afHcaptcha === "undefined") afHcaptcha = {};
		    afHcaptcha.loaded = true;
		    if (afHcaptcha.instance != null)
		        afHcaptcha.instance.onLoad();
		   }"""
	}
	
	** Inject hCaptcha scripts into the page.
	Void injectJsCaptcha(Obj htmlInjector) {
		if (!enabled) return
		htmlInjector->injectScript->withScript(captchaJsFunc)
		htmlInjector->injectScript->fromExternalUrl(captchaJsUrl)->async->defer
	}

	** If not enabled, pass '<fail>' to mimic a failure.
	Bool verifyCaptcha(Str? response, Bool checked := true) {
		resp := null as Str:Obj?
		
		if (response?.trimToNull == null)
			return !checked ? false : throw Err("No hCaptcha given")

		if (enabled) {
			json := WebClient(verifyUrl).postForm([
				"secret"	: secretKey,
				"response"	: response ?: "",
				"sitekey"	: siteKey,
			]).resStr
			resp = JsonInStream(json.in).readJson

		} else {
			resp = ["success" : response != "<fail>"]
			if (response == "<error>")
				resp["error-codes"] = "afHcaptcha-test-error"
			log.info("hCaptcha Stub - " + (resp["success"] ? "Success!" : "Fail") + " - $response")
		}

		errorCodes := resp["error-codes"]
		if (errorCodes != null && errorCodes != "invalid-or-already-seen-response")
			// generally error-codes mean I've done something wrong and the request / token is invalid
			// Bad hCaptcha response - [missing-input-secret]
			// https://docs.hcaptcha.com/#siteverify-error-codes-table
			throw Err("Bad hCaptcha response - ${errorCodes}")
		
		success := resp["success"]
		if (!success && checked)
			throw Err("hCaptcha failed")
		return success
	}
}
