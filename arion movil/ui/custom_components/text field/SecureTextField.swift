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
    @State var hide:Bool = true
    var textError:String
    var transparent:Bool
    var customFont: CustomFont = CustomFont(type: .semibold, size: Constants.sizeTextFormControls)
    var color: Color = Color("title")
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                HStack{
                if hide{
                    SecureField(self.title, text: self.$textValue)
                        .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size))).foregroundColor(self.color)
                        .padding()
                        .background(!transparent ? Color("background"):Color("background_text"))
                        .cornerRadius(4.0)
                        .opacity(0.8)
                }
                else{
                    TextField(self.title, text: self.$textValue)
                        .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size))).foregroundColor(self.color)
                        .padding()
                        .background(!transparent ? Color("background"):Color("background_text"))
                        .cornerRadius(4.0)
                        .opacity(0.8)
                }
                   
                }
                if !hide{
                HStack{
                    Spacer()
                    Image(systemName: self.hide ? "eye.fill":"eye.slash.fill").foregroundColor(Color.secondary).onTapGesture {
                        withAnimation{
                            hide.toggle()
                            
                        }
                    }
                    Spacer().frame(width:10)
                }
            }
            }
          
            if !textError.isEmpty {
                TextWithCustomFonts(
                    textError,
                    customFont: CustomFont(type: .light, size: Constants.sizeTextCaption),
                    color: Color("error")
                ).padding(.horizontal)
            }
        }
    }
}
