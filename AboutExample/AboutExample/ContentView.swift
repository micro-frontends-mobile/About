//
//  ContentView.swift
//  AboutExample
//
//  Created by Dongdong Zhang on 2022/5/21.
//

import SwiftUI
import About
import Env

struct ContentView: View {
  init() {
    _ = Env.initialize()
  }
  var body: some View {
      AboutView()
      .background(Env.shared.configuration.backgroundColor)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
