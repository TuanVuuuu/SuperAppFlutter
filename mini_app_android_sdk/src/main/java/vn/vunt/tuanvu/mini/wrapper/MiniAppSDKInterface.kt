package vn.vunt.tuanvu.mini.wrapper

import android.app.Application
import android.content.Context

interface MiniAppSDKInterface {
    fun init(application: Application, config: String? = null)
    fun openWebView(context: Context)
}