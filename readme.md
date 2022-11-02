# hCaptcha v0.0.6
---

[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](https://fantom-lang.org/)
[![pod: v0.0.6](http://img.shields.io/badge/pod-v0.0.6-yellow.svg)](http://eggbox.fantomfactory.org/pods/afHcaptcha)
[![Licence: ISC](http://img.shields.io/badge/licence-ISC-blue.svg)](https://choosealicense.com/licenses/isc/)

## Overview

*hCaptcha is a support library that aids Fantom-Factory in the development of other libraries, frameworks and applications. Though you are welcome to use it, you may find features are missing and the documentation incomplete.*

Client and Server code to process hCaptcha responses.

Requires a hCaptcha account to be configured for your domain. See:

* [hCaptcha Docs](https://docs.hcaptcha.com/)
* [hCaptcha Dashboard](https://dashboard.hcaptcha.com/)


## <a name="Install"></a>Install

Install `hCaptcha` with the Fantom Pod Manager ( [FPM](http://eggbox.fantomfactory.org/pods/afFpm) ):

    C:\> fpm install afHcaptcha

Or install `hCaptcha` with [fanr](https://fantom.org/doc/docFanr/Tool.html#install):

    C:\> fanr install -r http://eggbox.fantomfactory.org/fanr/ afHcaptcha

To use in a [Fantom](https://fantom-lang.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afHcaptcha 0.0"]

## <a name="documentation"></a>Documentation

Full API & fandocs are available on the [Eggbox](http://eggbox.fantomfactory.org/pods/afHcaptcha/) - the Fantom Pod Repository.

## Quick Start

Client side code:

    using afHcaptcha::CaptchaClient
    
    ...
    
    siteKey  := "..."    // siteKey = your unique hCaptcha key
    enabled  := true     // enabled = false to disable hCaptcha during dev
    captcha  := captchaClient(siteKey, enabled)
    
    ...
    
    containerId := "divId"  // id of where hCaptcha is to be rendered
    captchaId   := captcha.render(containerId)
    
    ...
    
    response    := captcha.getResponse(captchaId)
    if (response == null)
        Win.cur.alert("If you're a human, complete the captcha!")
    else
        // set a hidden form value to send response to the Server
        doc.elemById("captchaInput").setAttr("value", response)
    

Then when processing form values on the server:

    using afIoc::Inject
    using afBedSheet::HttpRequest
    using afEfanXtra::BeforeRender
    using afHcaptcha::CaptchaServer
    ...
    
    @Inject const HttpRequest    httpReq
    @Inject const CaptchaServer  captcha
    
    @BeforeRender
    Void onBeforeRender() {
        // inject hCaptcha scripts into the page
        captcha.injectJsCaptcha()
    }
    
    Void onProcessForm() {
        // grab the hCaptcha response from the client form
        response := httpReq.body.form["captchaInput"]
    
        // verify it on the hCaptcha server
        success  := captcha.verifyCaptcha(response, false)
        if (success == false)
            throw Err("Captcha failed")
    }
    

