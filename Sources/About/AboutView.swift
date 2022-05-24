//
//  AboutView.swift
//  About
//
//  Created by Dongdong Zhang on 2022/5/9.
//

import SwiftUI
import Env

public struct AboutView: View {
  @State var dynamicHeight: CGFloat = .zero

  public init() {
    _ = Env.initialize()
  }

  public var body: some View {
    ScrollView {
      Text("About Page")
        .font(.largeTitle)

      HStack {
        Text(.init(message))
          .font(Font.system(size: 19))
          .lineSpacing(6)

        Spacer()
      }
      .padding()

      Divider()

      AboutWebView(url: url, dynamicHeight: $dynamicHeight)
        .frame(height: $dynamicHeight.wrappedValue)
    }
    .background(Env.shared.configuration.backgroundColor)
  }

  private var url: URL {
    URL(string: "\(Env.shared.configuration.host)/about")!
  }

  private var message: String {
    """
    This App was created by [zddhub](https://github.com/zddhub) to \
    demonstrate just one way that micro frontends can be implemented \
    on mobile side. \
    \n
    The below content is from Cam Jackson's website. It's been embedded \
    like mobile native.
    """
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
