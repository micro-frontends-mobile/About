//
//  AboutWebView.swift
//  About
//
//  Created by Dongdong Zhang on 2022/5/9.
//

import SwiftUI
import WebKit

struct AboutWebView: UIViewRepresentable {
  let url: URL
  var webView: WKWebView

  func makeUIView(context: UIViewRepresentableContext<AboutWebView>) -> WKWebView {
    let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
    webView.load(request)

    return webView
  }

  func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<AboutWebView>) {
    let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
    webView.load(request)
  }

  init(url: URL) {
    self.url = url
    webView = WKWebView()
    webView.navigationDelegate = delegate
  }

  /// - WebViewDelegate
  lazy var delegate = WebViewDelegate(webView)

  class WebViewDelegate: NSObject, WKNavigationDelegate {
    var webView: WKWebView

    init(_ webView: WKWebView) {
      self.webView = webView
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      // Remove header from webview
      webView.evaluateJavaScript("document.getElementsByTagName('header')[0].style.display = 'none'")
    }
  }
}
