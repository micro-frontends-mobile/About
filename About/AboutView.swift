//
//  AboutView.swift
//  About
//
//  Created by Dongdong Zhang on 2022/5/9.
//

import SwiftUI

struct AboutView: View {
  private let url = "https://demo.microfrontends.com/about"

  var body: some View {
    AboutWebView(url: URL(string: url)!)
      .ignoresSafeArea()
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
