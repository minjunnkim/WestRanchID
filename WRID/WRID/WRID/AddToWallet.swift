//
//  AddToWallet.swift
//  WRID
//
//  Created by Minjun Kim on 8/23/22.
//

import PassKit

final class AddToWallet: UIViewController {
    //private let passView = PassView()
    
    private var pass = PKPass()
    
    func add(idnum: String) {
        print(idnum)
        let filePath = Bundle.main.path(forResource: "StoreCard", ofType: "pkpass")
        let pkfile : NSData = NSData(contentsOfFile: filePath!)!

        do {
            pass = try PKPass(data: pkfile as Data)
            let vc = PKAddPassesViewController(pass: pass)
            self.present(vc!, animated: true)
        }
        catch {
            print("something went wrong!")
        }
    }
}
