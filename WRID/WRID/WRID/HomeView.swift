//
//  HomeView.swift
//  WRID
//
//  Created by Minjun Kim on 8/22/22.
//

import SwiftUI
import GoogleSignIn
import PassKit

struct HomeView: View {
    // 1
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    // 2
    private let user = GIDSignIn.sharedInstance.currentUser
    private var idnum = ""
    
    init() {
        let email: String? = user?.profile?.email
        let nine = email!.index(email!.startIndex, offsetBy: 9)
        let twentyseven = email!.index(email!.startIndex, offsetBy: 27)
        let seven = email!.index(email!.startIndex, offsetBy: 7)
        self.idnum = email![nine...twentyseven] == "my.hartdistrict.org" ? String(email![email!.startIndex...seven]) : "Invalid ID"
    }
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // 3
                    NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(user?.profile?.name ?? "")
                            .font(.headline)
                        
                        Text("ID: " + self.idnum)
                            .font(.caption)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding()
                
                Button(action: viewModel.wallet) {
                    Text("Add WR ID to Apple Wallet")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.08235294117, green: 0.10588235294, blue: 0.36862745098))
                        .cornerRadius(12)
                        .padding()
                }
                    
                
                Spacer()
                
                // 4
                Button(action: viewModel.signOut) {
                    Text("Sign out")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.08235294117, green: 0.10588235294, blue: 0.36862745098))
                        .cornerRadius(12)
                        .padding()
                }
            }
            .navigationTitle("WRID")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct NetworkImage: View {
    let url: URL?
    
    var body: some View {
        if let url = url,
           let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}


