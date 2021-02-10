//
//  ErrorTextField.swift
//  arion movil
//
//  Created by Daniel Luna on 08/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct RoundedTextField: View {
    @Binding var textValue:String
    @State var title:String
   
    var textError:String
    @State var transparent:Bool 
    var customFont: CustomFont = CustomFont(type: .semibold, size: 16)
    var color: Color = Color("title")
   
    var body: some View {
        VStack(alignment: .leading) {
            TextField(self.title, text: self.$textValue)
                .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size))).foregroundColor(self.color)
                .padding()
                .background(!transparent ? Color("background"): Color("background_text"))
                .cornerRadius(4.0)
                .opacity(0.8)
            if !textError.isEmpty {
                TextWithCustomFonts(
                    textError,
                    customFont: CustomFont(type: .light, size: 14),
                    color: Color("error")
                ).padding(.horizontal)
            }
                
        }
    }
}
