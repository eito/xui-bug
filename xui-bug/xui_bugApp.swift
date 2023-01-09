//
//  xui_bugApp.swift
//  xui-bug
//
//  Created by Eric Ito on 1/9/23.
//

import SwiftUI

@main
struct xui_bugApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MainViewModel())
        }
    }
}
