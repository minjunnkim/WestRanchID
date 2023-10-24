//
//  AddToWalletButton.swift
//  WRID
//
//  Created by Minjun Kim on 8/23/22.
//

import SwiftUI
import PassKit

struct AddToWalletButton: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme

    
    private var button = PKAddPassButton(addPassButtonStyle: PKAddPassButtonStyle.black)
    
    func makeUIView(context: Context) -> PKAddPassButton {
        button.frame = CGRect(x: (UIScreen.main.bounds.width-280)/2, y:150, width: 280, height: 60)
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
