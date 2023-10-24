//
//  PreView.swift
//  WRID
//
//  Created by Minjun Kim on 8/22/22.
//

import SwiftUI

struct PreView: View {
    
    // 1
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            // 2
            Image("WR LOGO")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Welcome to WRID")
                .fontWeight(.black)
                .foregroundColor(Color(red: 0.08235294117, green: 0.10588235294, blue: 0.36862745098))
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text("Get your West Ranch ID on your \n Apple Wallet now.")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            // 3
            GoogleSignInButton()
                .padding()
                .onTapGesture {
                    viewModel.signIn()
                }
        }
    }
}
