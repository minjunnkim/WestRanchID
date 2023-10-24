//
//  WRIDApp.swift
//  WRID
//
//  Created by Minjun Kim on 8/22/22.
//

import SwiftUI
import FirebaseCore
import Firebase
import GoogleSignIn
@main
struct WRIDApp: App {
    @StateObject var viewModel = AuthenticationViewModel()

    init() {
        setupAuthentication()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension WRIDApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
