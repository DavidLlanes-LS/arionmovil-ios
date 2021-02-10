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
    @State var navigationToRecoverPass = false
    
    var alert: Alert {
        Alert(title: Text(String("Atención")), message: Text(String("El usuario y/o contraseña son incorrectos")), dismissButton: .default(Text(String("Cerrar"))) {
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
                                CustomFont(type: .bold, size: 16),
                            color: .white
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
                            customFont: CustomFont(type: .bold, size: 16),
                            color: .white
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
                                    self.showAlert = true
                                    break
                                }
                                case 1: do {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                default: break
                                }
                            } else if (error != nil) {
                                showAlert = true
                            }
                        }
                    }
                }
                .disabled(viewModel.disableButton())
                .frame(height: 50)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center).padding()
                
                Spacer()
                
                VStack(spacing:16){
                    SimpleBtn("Crear una cuenta", action: {
                        self.navigationToRegister = true
                    }, color:Color.white)
                    SimpleBtn("Recupera tu contraaseña", action: {
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
