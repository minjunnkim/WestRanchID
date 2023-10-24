//
//  ContentView.swift
//  WRID
//
//  Created by Minjun Kim on 8/22/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        switch viewModel.state {
        case .signedIn: HomeView()
        case .signedOut: PreView()
        case .walletAdd: PassView()
        }
    }
}
