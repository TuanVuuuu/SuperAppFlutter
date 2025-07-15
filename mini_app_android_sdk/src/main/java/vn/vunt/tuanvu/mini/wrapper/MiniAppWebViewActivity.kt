package vn.vunt.tuanvu.mini.wrapper

import android.app.Activity
import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient

class MiniAppWebViewActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val webView = WebView(this)
        webView.webViewClient = WebViewClient()
        webView.settings.javaScriptEnabled = true
        val url = intent.getStringExtra("url") ?: "http://localhost:8989"
        webView.loadUrl(url)
        setContentView(webView)
    }
} 