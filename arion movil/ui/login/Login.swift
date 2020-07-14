//
//  Login.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 10/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Login: View {
    @State var email:String = ""
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
            VStack{
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 80)
                    .aspectRatio(contentMode: .fit)
                VStack{
                    VStack(alignment:.leading){
                        TextWithCustomFonts("Usuario", customFont: CustomFont(type: .bold, size: 16),color: .white)
                        CustomTextField(textValue: self.$email, title: "Ingresa tu correo electrónico")
                    }
                    VStack(alignment:.leading){
                        TextWithCustomFonts("Contraseña", customFont: CustomFont(type: .bold, size: 16),color: .white)
                        CustomTextField(textValue: self.$email, title: "Ingresa tu contraseña")
                    }
                }.padding()
                RectangleBtn("Iniciar sesión"){
                    
                }.frame(height:60)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .center).padding()
                Spacer()
                VStack(spacing:16){
                    SimpleBtn("Crear una cuenta",action: {
                        
                    },color:Color.white)
                    SimpleBtn("Recupera tu contraaseña",action: {
                        
                    },color:Color.white)
                }.padding(.bottom, 16)
            }.padding()
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
