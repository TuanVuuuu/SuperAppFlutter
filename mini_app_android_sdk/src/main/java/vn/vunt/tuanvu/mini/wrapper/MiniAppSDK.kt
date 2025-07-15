package vn.vunt.tuanvu.mini.wrapper

import android.app.Application
import android.content.Context
import android.content.Intent

object MiniAppSDK : MiniAppSDKInterface {
    private var application: Application? = null
    private var config: String? = null

    override fun init(application: Application, config: String?) {
        this.application = application
        this.config = config
    }

    override fun openWebView(context: Context, url: String) {
        val intent = Intent(context, MiniAppWebViewActivity::class.java)
        intent.putExtra("url", url)
        intent.putExtra("config", config)
        context.startActivity(intent)
    }
}