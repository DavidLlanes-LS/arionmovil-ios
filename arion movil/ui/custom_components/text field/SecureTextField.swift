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
    var textError:String
    var customFont: CustomFont = CustomFont(type: .semibold, size: 16)
    var color: Color = .black
    var body: some View {
        VStack(alignment: .leading) {
            SecureField(self.title, text: self.$textValue)
                .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size))).foregroundColor(self.color)
                .padding()
                .background(Color.white)
                .cornerRadius(4.0)
                .opacity(0.8)
            if !textError.isEmpty {
                TextWithCustomFonts(
                    textError,
                    customFont: CustomFont(type: .light, size: 15),
                    color: Color("error")
                ).padding(.horizontal)
            }
        }
    }
}
