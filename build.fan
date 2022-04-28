using build::BuildPod

class Build : BuildPod {

	new make() {
		podName = "afHcaptcha"
		summary = "Client and Server code to process hCaptcha challenges"
		version = Version("0.0.1")

		meta = [
			"pod.dis"		: "hCaptcha",
			"repo.tags"		: "web",
			"repo.public"	: "true",
			"repo.internal"	: "true",
			"afIoc.module"	: "afHcaptcha::CaptchaModule"
		]

		depends = [
			// ---- Fantom Core -----------------
			"sys          1.0.73 - 1.0",
			"dom          1.0.73 - 1.0",
			"web          1.0.73 - 1.0",
			"util         1.0.73 - 1.0",
		]

		srcDirs = [`fan/`]
		resDirs = [`doc/`]
		jsDirs  = [`js/`]
	}
}
