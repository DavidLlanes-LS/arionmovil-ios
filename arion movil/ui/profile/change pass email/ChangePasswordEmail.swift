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
    @State var newEmail:String = ""
    @State var newPassword:String = ""
    @State var verifyPassword:String = ""
    @State var currentPassword:String = ""
    @State var responseMessage:String = ""
    @State var errorVerifyMessage:String = ""
    @State var showAlert = false
    @State var wasSucces = false
    var isAuth = UserDefaults.standard.bool(forKey: Constants.keyIsAuth)
    var body: some View {
        let verifyPasswordBinding = Binding<String>(get: {
                    self.verifyPassword
                }, set: {
                    self.verifyPassword = $0
                    if verifyPassword == newPassword {
                        withAnimation{
                        errorVerifyMessage = ""
                        }
                    }
                })
        let newPasswordBinding = Binding<String>(get: {
                    self.newPassword
                }, set: {
                    self.newPassword = $0
                    if newPassword == verifyPassword {
                        withAnimation{
                        errorVerifyMessage = ""
                        }
                    }
                })

        ZStack{
            Color("background")
            VStack{
                Form{
                    Section(header: TextWithCustomFonts("Cambiar correo",customFont: CustomFont(type: .bold, size: 20))){
                        VStack{
                            TextWithCustomFonts("Modificar el correo de tu cuenta guardando todas tus configuraciones",customFont: CustomFont(type: .light, size: 16)).frame(height:60)
                            RoundedTextField(textValue: $newEmail, title: "Escribe tu nuevo email",textError: "",transparent: true)
                        }
                    }
                    Section(header: TextWithCustomFonts("Cambiar contraseña",customFont: CustomFont(type: .bold, size: 20))){
                        SecureTextField(textValue: $currentPassword, title: "Escribe tu contraseña actual",textError: "",transparent: true)
                        SecureTextField(textValue: newPasswordBinding, title: "Nueva contraseña",textError: "",transparent: true)
                        SecureTextField(textValue: verifyPasswordBinding, title: "Confirmar contraseña",textError: errorVerifyMessage,transparent: true)
                    }
                }.background(Color("background"))
                RectangleBtn("Guardar"){
                    hide_keyboard()
                    var options:String = Constants.changePasswordAndEmailOption
                    if(newEmail.isEmpty)
                    {
                        options = Constants.changePasswordOption
                    }
                    if(newPassword.isEmpty)
                    {
                        options = Constants.changeEmailOption
                    }
                    if newPassword == verifyPassword {
                        errorVerifyMessage = ""
                    viewModel.changeProfile(body: ChangeProfileBody(options: options, newEmail: newEmail, currentPassword: currentPassword, newPassword: newPassword)) {message in
                        wasSucces.toggle()
                        responseMessage = message
                        showAlert.toggle()
                    } onFail: {message in
                        responseMessage = message
                        showAlert.toggle()
                    }}
                    else{
                        withAnimation{
                            errorVerifyMessage = Constants.missmatchPasswordsMsg
                        }
                    }
                    
                    
                    
                }.disabled(!(!currentPassword.isEmpty && ((!newPassword.isEmpty && !verifyPassword.isEmpty) || !newEmail.isEmpty))).frame(width:200,height:40)
                .frame(minWidth:0, maxWidth: .infinity, alignment: .center).padding()
            } .alert(isPresented: $showAlert, content: { Alert(title: Text(String("Atención")), message: Text(String(responseMessage)), dismissButton: .default(Text(String("Aceptar"))) {
                if wasSucces {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) }).navigationBarTitle("Cambiar correo o contraseña").padding(.top)
        }.onAppear{
            if !isAuth{
                responseMessage = "Por favor inicia sesión para poder realizar esta acción"
                wasSucces = true
                showAlert = true
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
