//
//  SecureTextField.swift
//  arion movil
//
//  Created by Daniel Luna on 03/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SecureTextField: View {
    @Binding var textValue:String
    @State var title:String
    var customFont: CustomFont = CustomFont(type: .semibold, size: 16)
    var color: Color = .black
    var body: some View {
        SecureField(self.title, text: self.$textValue)
            .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size))).foregroundColor(self.color)
            .padding()
            .background(Color.white)
            .cornerRadius(4.0)
            .opacity(0.8)
    }
}
