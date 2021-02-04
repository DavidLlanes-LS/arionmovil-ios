//
//  Login.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 10/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack{
                Image("background")
                    .resizable()
                VStack{
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 220, height: 80)
                        .aspectRatio(contentMode: .fit)
                    VStack{
                        VStack(alignment:.leading){
                            TextWithCustomFonts("Usuario", customFont: CustomFont(type: .bold, size: 16),color: .white)
                            CustomTextField(textValue: $viewModel.username, title: "Ingresa tu correo electrónico").keyboardType(.emailAddress)
                        }
                        VStack(alignment:.leading){
                            TextWithCustomFonts("Contraseña", customFont: CustomFont(type: .bold, size: 16),color: .white)
                            SecureTextField(textValue: $viewModel.password, title: "Ingresa tu contraseña")
                        }
                    }
                    .padding()
                    
                    RectangleBtn("Iniciar sesión") {
                        self.viewModel.signIn() { result in
                            if (result == 1) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    .frame(height: 50)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center).padding()
                    
                    Spacer()
                    
                    VStack(spacing:16){
                        SimpleBtn("Crear una cuenta", action: {
                            
                        }, color:Color.white)
                        SimpleBtn("Recupera tu contraaseña", action: {
                            
                        }, color:Color.white)
                    }
                    .padding(.bottom, 16)
                }
            }.navigationBarTitle("Iniciar sesión", displayMode: .inline)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
