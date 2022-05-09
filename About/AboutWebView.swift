//
//  AboutWebView.swift
//  About
//
//  Created by Dongdong Zhang on 2022/5/9.
//

import SwiftUI
import WebKit

struct AboutWebView: UIViewRepresentable {
  let url = URL(string: "https://demo.microfrontends.com/about")!
  var webView: WKWebView = WKWebView()

  func makeUIView(context: UIViewRepresentableContext<AboutWebView>) -> WKWebView {
    let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
    webView.load(request)

    return webView
  }

  func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<AboutWebView>) {
    let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
    webView.load(request)
  }

  init() {
    webView.navigationDelegate = delegate
  }

  /// - WebViewDelegate
  lazy var delegate = WebViewDelegate()

  class WebViewDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      // Remove header from webView
      webView.evaluateJavaScript(
        """
        document.getElementsByTagName('header')[0].style.display = 'none';
        document.getElementById('about').style = 'font-family: -apple-system;'
        """)
    }
  }
}

struct AboutWebView_Previews: PreviewProvider {
  static var previews: some View {
    AboutWebView()
  }
}
