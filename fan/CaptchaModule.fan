
@NoDoc	// advanced use only
internal const class CaptchaModule {
	
	Str:Obj nonInvasiveIocModule() {
		[
			"services"	: [
				[
					"id"		: CaptchaServer#.qname,
					"type"		: CaptchaServer#,
					"scopes"	: ["root"],
					"builder"	: |Obj scope->Obj| {
						configSrc	:= scope->serviceById("afIocConfig::ConfigSource")
						enabled		:= configSrc->get("afHcaptcha.enabled",		Bool#)
						verifyUrl	:= configSrc->get("afHcaptcha.verifyUrl",	Uri#)
						siteKey		:= configSrc->get("afHcaptcha.siteKey",		Str#)
						secretKey	:= configSrc->get("afHcaptcha.secretKey",	Str#)
						return CaptchaServer {
							it.enabled		= enabled
							it.verifyUrl	= verifyUrl
							it.secretKey	= secretKey
							it.siteKey		= siteKey
						}
					}
				]
			],

			"contributions" : [
				[
					"serviceId"	: "afIocConfig::FactoryDefaults",
					"key"		: "afHcaptcha.enabled",
					"value"		: false
				],
				[
					"serviceId"	: "afIocConfig::FactoryDefaults",
					"key"		: "afHcaptcha.verifyUrl",
					"value"		: `https://hcaptcha.com/siteverify`
				],
				[
					"serviceId"	: "afIocConfig::FactoryDefaults",
					"key"		: "afHcaptcha.siteKey",
					"value"		: "XXXX"
				],
				[
					"serviceId"	: "afIocConfig::FactoryDefaults",
					"key"		: "afHcaptcha.secretKey",
					"value"		: "XXXX"
				]
			]
		]
	}
}
