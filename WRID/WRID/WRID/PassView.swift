//
//  PassView.swift
//  WRID
//
//  Created by Minjun Kim on 8/25/22.
//

import SwiftUI
import PassKit
import GoogleSignIn

struct PassView: View {
    let passTypeIdentifier = "pass.com.example.passkit"
    let teamIdentifier = "XXXXXXXXXX"

    var body: some View {
        Button(action: {
            guard let user: GIDGoogleUser = GIDSignIn.sharedInstance()?.currentUser else {
                fatalError("User not signed in")
            }

            let name = user.profile.name ?? "Unknown"
            let email = user.profile.email ?? ""
            let idNumber = String(email.prefix(8))
            let profilePicture = user.profile.imageURL(withDimension: 100)?.absoluteString ?? ""

            let barcodeMessage = "*" + idNumber + "*"
            let barcodeData = barcodeMessage.data(using: String.Encoding.ascii)!
            let barcodeString = barcodeData.map { String(format: "%c", $0) }.joined()

            let passData: [String: Any] = [
                "description": "Virtual ID Card",
                "formatVersion": 1,
                "organizationName": "Example Organization",
                "passTypeIdentifier": passTypeIdentifier,
                "serialNumber": "123456",
                "teamIdentifier": teamIdentifier,
                "barcode": [
                    "format": "PKBarcodeFormatCode39",
                    "message": barcodeString
                ],
                "headerFields": [
                    [
                        "key": "name",
                        "label": "Name",
                        "value": name
                    ],
                    [
                        "key": "idNumber",
                        "label": "ID Number",
                        "value": idNumber
                    ]
                ],
                "backFields": [
                    [
                        "key": "profilePicture",
                        "label": "Profile Picture",
                        "value": profilePicture,
                        "auxiliaryFields": [
                            [
                                "key": "description",
                                "label": "Description",
                                "value": "Profile Picture"
                            ]
                        ]
                    ]
                ]
            ]

            guard let passDataJSON = try? JSONSerialization.data(withJSONObject: passData),
                  let pass = PKPass(data: passDataJSON) else {
                print("Error creating PKPass")
                return
            }

            let passLibrary = PKPassLibrary()
            if passLibrary.containsPass(pass) {
                print("Pass already exists in the library")
                return
            }

            passLibrary.addPasses([pass]) { error in
                if let error = error {
                    print("Error adding pass: \(error.localizedDescription)")
                } else {
                    print("Pass added to the library")
                }
            }
        }) {
            Text("Add to Wallet")
        }
    }
}

