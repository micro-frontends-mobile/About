//
//  AboutView.swift
//  About
//
//  Created by Dongdong Zhang on 2022/5/9.
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    AboutWebView()
      .ignoresSafeArea()
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
