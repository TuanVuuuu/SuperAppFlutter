package vn.vunt.tuanvu.mini.wrapper

import android.app.Application
import android.content.Context
import android.content.Intent

object MiniAppSDK : MiniAppSDKInterface {
    private var application: Application? = null
    private var config: String? = null
    private var baseUrl: String = "http://localhost:8989"

    override fun init(application: Application, config: String?) {
        this.application = application
        this.config = config
    }

    override fun openWebView(context: Context) {
        val intent = Intent(context, MiniAppWebViewActivity::class.java)
        intent.putExtra("url", baseUrl)
        intent.putExtra("config", config)
        context.startActivity(intent)
    }

    // Optional: expose API to set baseUrl if needed in the future
    fun setBaseUrl(url: String) {
        baseUrl = url
    }
}