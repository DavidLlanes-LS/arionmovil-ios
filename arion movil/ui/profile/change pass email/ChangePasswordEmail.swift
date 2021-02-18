//
//  ChangePasswordEmail.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ChangePasswordEmail: View {
    @StateObject var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    var isAuth = UserDefaults.standard.bool(forKey: Constants.keyIsAuth)
    var body: some View {
 
        ZStack{
            Color("background")
            VStack{
                Form{
                    Section(header: TextWithCustomFonts("Cambiar correo",customFont: CustomFont(type: .bold, size: 20))){
                        VStack{
                            TextWithCustomFonts("Modificar el correo de tu cuenta guardando todas tus configuraciones",customFont: CustomFont(type: .light, size: 16)).frame(height:60)
                            RoundedTextField(textValue: viewModel.newEmailBinding!, title: "Escribe tu nuevo email",textError: viewModel.errorVerifyEmail,transparent: true)
                        }
                    }
                    Section(header: TextWithCustomFonts("Cambiar contraseña",customFont: CustomFont(type: .bold, size: 20))){
                        SecureTextField(textValue: $viewModel.currentPassword, title: "Escribe tu contraseña actual",textError: "",transparent: true)
                        SecureTextField(textValue: viewModel.newPasswordBinding!, title: "Nueva contraseña",textError: viewModel.errorMinimumPassword,transparent: true)
                        SecureTextField(textValue: viewModel.verifyPasswordBinding!, title: "Confirmar contraseña",textError: viewModel.errorVerifyMessage,transparent: true)
                    }
                }.background(Color("background"))
                RectangleBtn("Guardar"){
                    hide_keyboard()
                    viewModel.changeProfile()
                }.disabled(!(!viewModel.newEmail.isEmpty || ((!viewModel.newPassword.isEmpty && !viewModel.verifyPassword.isEmpty) && !viewModel.currentPassword.isEmpty ))).frame(width:200,height:40)
               
                .frame(minWidth:0, maxWidth: .infinity, alignment: .center).padding()
            } .alert(isPresented: $viewModel.showAlert, content: { Alert(title: Text(String("Atención")), message: Text(String(viewModel.responseMessage)), dismissButton: .default(Text(String("Aceptar"))) {
                if viewModel.wasSucces {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) }).navigationBarTitle("Cambiar correo o contraseña").padding(.top)
            
        }.onAppear{
            if !isAuth{
                viewModel.responseMessage = "Por favor inicia sesión para poder realizar esta acción"
                viewModel.wasSucces = true
                viewModel.showAlert = true
            }
        }
    }
    func hide_keyboard()
    {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
   
}

struct ChangePasswordEmail_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordEmail()
    }
}
