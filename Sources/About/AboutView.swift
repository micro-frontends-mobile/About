//
//  AboutView.swift
//  About
//
//  Created by Dongdong Zhang on 2022/5/9.
//

import SwiftUI

public struct AboutView: View {
  @State var dynamicHeight: CGFloat = .zero

  public init() {}

  public var body: some View {
    ScrollView {
      Text("About Page")
        .font(.largeTitle)

      Text("The below content from Cam Jackson's website.")
        .font(Font.system(size: 18))
        .font(.body)

      Divider()

      AboutWebView(dynamicHeight: $dynamicHeight)
        .frame(height: $dynamicHeight.wrappedValue)
    }
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
