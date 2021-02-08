//
//  CustomTextField.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 07/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var textValue:String
    @State var title:String
    var customFont: CustomFont = CustomFont(type: .semibold, size: 16)
    var color: Color = .black
    var body: some View {
        VStack {
            TextField(self.title, text: self.$textValue)
                .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size))).foregroundColor(self.color)
                .padding()
                .background(Color.white)
                .cornerRadius(4.0)
                .opacity(0.8)
        }
    }
}
