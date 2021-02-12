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
    @State var newEmail:String = ""
    @State var newPassword:String = ""
    @State var verifyPassword:String = ""
    @State var currentPassword:String = ""
    var body: some View {
        ZStack{
            Color("background")
            VStack{
                Form{
                    Section(header: TextWithCustomFonts("Cambiar correo",customFont: CustomFont(type: .bold, size: 20))){
                        VStack{
                            TextWithCustomFonts("Modificar el correo de tu cuenta guardando todas tus configuraciones",customFont: CustomFont(type: .light, size: 16)).frame(height:60)
                            CustomTextField(textValue: $newEmail, title: "Escribe tu email")
                        }
                    }
                    Section(header: TextWithCustomFonts("Cambiar contraseña",customFont: CustomFont(type: .bold, size: 20))){
                        CustomTextField(textValue: $currentPassword, title: "Escribe tu contraseña actual")
                        CustomTextField(textValue: $newPassword, title: "Escribe nueva contraseña")
                        CustomTextField(textValue: $verifyPassword, title: "Confirma tu contraseña")
                    }
                }
                RectangleBtn("Guardar"){
                    viewModel.changeProfile(body: ChangeProfileBody(options: "ChangeUserPassword", newEmail: "", currentPassword: currentPassword, newPassword: newPassword))
                    
                }.frame(width:200,height:40)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .center).padding()
            }.navigationBarTitle("Cambiar correo o contraseña").padding(.top)
        }
    }
}

struct ChangePasswordEmail_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordEmail()
    }
}
