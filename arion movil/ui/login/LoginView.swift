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
    @State var navigationToRegister = false
    @EnvironmentObject var appSettings: AppHelper
    @State var navigationToRecoverPass = false
    @State var message = ""
    
    var alert: Alert {
        Alert(title: Text(String("Atención")), message: Text(String(message)), dismissButton: .default(Text(String("Cerrar"))) {
        })
    }
    @State var showAlert = false
    
    var body: some View {
        ZStack{
            NavigationLink(destination: SignUpView(), isActive: self.$navigationToRegister) {
                Spacer().fixedSize()
            }
            NavigationLink(
                destination: RecoverPasswordView(),
                isActive: self.$navigationToRecoverPass) {
                Spacer().fixedSize()
            }
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
                        TextWithCustomFonts(
                            "Usuario",
                            customFont:
                                CustomFont(type: .bold, size: Constants.sizeTextCaption),
                            color: .white, font: .caption
                        )
                        RoundedTextField(
                            textValue: $viewModel.username,
                            title: "Ingresa tu correo electrónico",
                            textError: viewModel.errorUsername
                            ,transparent:false
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    }
                    VStack(alignment:.leading){
                        TextWithCustomFonts(
                            "Contraseña",
                            customFont:
                                CustomFont(type: .bold, size: Constants.sizeTextCaption),
                            color: .white, font: .caption
                        )
                        SecureTextField(
                            textValue: $viewModel.password,
                            title: "Ingresa tu contraseña",
                            textError: viewModel.errorPassword
                            ,transparent:false
                        )
                    }
                }
                .padding()
                
                RectangleBtn("Iniciar sesión") {
                    if self.viewModel.isFormValid() {
                        self.viewModel.signIn() { result, error in
                            if result != nil {
                                switch result {
                                case -1: do {
                                    message = "El usuario y/o contraseña son incorrectos"
                                    self.showAlert = true
                                    break
                                }
                               
                                case 1 : do {
                                    
                                    self.presentationMode.wrappedValue.dismiss()
                                    appSettings.isLoged = true
                                    
                                }
                                case 2: do {
                                    message = "El usuario y/o contraseña son incorrectos"
                                    self.showAlert = true
                                    break
                                }
                                
                                default:
                                    message = "Ocurrió un error inesperado"
                                    self.showAlert = true
                                    break
                                }
                            } else if (error != nil) {
                                message = "El usuario y/o contraseña son incorrectos"
                                showAlert = true
                            }
                        }
                    }
                }
                .disabled(viewModel.disableButton())
                .frame(height: 40)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center).padding()
                
                Spacer()
                
                VStack(spacing:16){
                    SimpleBtn("Crear una cuenta", action: {
                        self.navigationToRegister = true
                    }, color:Color.white)
                    SimpleBtn("Recupera tu contraseña", action: {
                        self.navigationToRecoverPass = true
                    }, color:Color.white)
                }
                .padding(.bottom, 16)
            }
        }
        .alert(isPresented: $showAlert, content: { alert })
        .navigationBarTitle(String("Inicia sesión"), displayMode: .inline)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
