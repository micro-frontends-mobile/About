//
//  AboutWebView.swift
//  About
//
//  Created by Dongdong Zhang on 2022/5/9.
//

import SwiftUI
import WebKit
import Combine

struct AboutWebView: UIViewRepresentable {
  let url: URL
  var webView: WKWebView = WKWebView()
  @Binding var dynamicHeight: CGFloat

  func makeUIView(context: UIViewRepresentableContext<AboutWebView>) -> WKWebView {
    let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
    webView.load(request)

    return webView
  }

  func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<AboutWebView>) {
    let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
    webView.load(request)
  }

  init(url: URL, dynamicHeight: Binding<CGFloat>) {
    self.url = url
    self._dynamicHeight = dynamicHeight
    webView.navigationDelegate = delegate
    webView.scrollView.isScrollEnabled = false
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator {
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()

    var aboutWebView: AboutWebView
    init(_ aboutWebView: AboutWebView) {
      self.aboutWebView = aboutWebView

      self.aboutWebView.delegate.height.sink { _ in
      } receiveValue: { [weak self] height in
        DispatchQueue.main.async {
          self?.aboutWebView.dynamicHeight = height
        }
      }.store(in: &cancellable)
    }
  }

  /// - WebViewDelegate
  var delegate = WebViewDelegate()

  class WebViewDelegate: NSObject, WKNavigationDelegate {
    var height: CurrentValueSubject<CGFloat, Never> = CurrentValueSubject<CGFloat, Never>(0.0)

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      // Remove header from webView
      webView.evaluateJavaScript(jsString) { _, _ in
          self.height.send(webView.scrollView.contentSize.height)
        }
    }

    private var jsString: String {
      // Notice: The below logic should be moved to web.
      let cssString = """
      @media (prefers-color-scheme: dark) { \
        body {color: white; background-color: gray;} \
        } a:link {color: #3c82f6;} a:visited {color: #3c82f6;}
      """
      return """
        document.getElementsByTagName('header')[0].style.display = 'none';
        document.getElementById('about').style = 'font-family: -apple-system;'
        var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);
        """
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
      if navigationAction.navigationType == .linkActivated, let url = navigationAction.request.url, await UIApplication.shared.canOpenURL(url) {
        DispatchQueue.main.async {
          UIApplication.shared.open(url)
        }
        return .cancel
      } else {
        return .allow
      }
    }
  }
}

struct AboutWebView_Previews: PreviewProvider {
  static var dynamicHeight: CGFloat = 0.0
  static var previews: some View {
    AboutWebView(url: URL(string: "https://demo.microfrontends.com/about")!, dynamicHeight: Binding<CGFloat>.init(get: {
      dynamicHeight
    }, set: { height in
      dynamicHeight = height
    }))
  }
}
