//
//  AuthenticationViewModel.swift
//  WRID
//
//  Created by Minjun Kim on 8/22/22.
//

import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    
    // 1
    enum SignInState {
        case signedIn
        case signedOut
        case walletAdd
    }
    
    // 2
    @Published var state: SignInState = .signedOut
    
    func wallet() {
        self.state = .walletAdd
    }
    
    func signIn() {
        // 1
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn() { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        }
        else {
            // 2
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // 3
            let configuration = GIDConfiguration(clientID: clientID)
            
            // 4
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            // 5
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        // 1
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        // 2
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        // 3
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.state = .signedIn
            }
        }
    }
    
    func signOut() {
        // 1
        GIDSignIn.sharedInstance.signOut()
        
        do {
            // 2
            try Auth.auth().signOut()
            
            state = .signedOut
        }
        catch {
            print(error.localizedDescription)
        }
    }

}

