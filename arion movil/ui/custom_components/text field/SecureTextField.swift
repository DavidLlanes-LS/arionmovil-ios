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
    @State var eyeString:String = "eye.fill"
    @State var hide:Bool = true
    var textError:String
    var transparent:Bool
    @State var showText:Bool = false
    var customFont: CustomFont = CustomFont(type: .semibold, size: Constants.sizeTextFormControls)
    var color: Color = Color("title")
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                HStack{
                    if !showText
                    {
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
                HStack{
                    Spacer()
                    Button(action:{
                        self.showText.toggle()
                        withAnimation{
                        eyeString = !showText ? "eye.fill":"eye.slash.fill"
                        }
                    }){
                        Image(systemName: eyeString)
                            .foregroundColor(Color.secondary)
                    }
                    Spacer().frame(width:10)
                }
            }
            
            if !textError.isEmpty {
                TextWithCustomFonts(
                    textError,
                    customFont: CustomFont(type: .semibold, size: 15),
                    color: Color("error")
                ).padding(.horizontal)
            }
        }
    }
}
