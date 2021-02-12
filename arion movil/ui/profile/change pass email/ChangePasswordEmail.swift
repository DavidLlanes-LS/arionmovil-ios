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
    var body: some View {
        ZStack{
            Color("background")
            VStack{
                Form{
                    Section(header: TextWithCustomFonts("Cambiar correo",customFont: CustomFont(type: .bold, size: 20))){
                        VStack{
                            TextWithCustomFonts("Modificar el correo de tu cuenta guardando todas tus configuraciones",customFont: CustomFont(type: .light, size: 16)).frame(height:60)
                            CustomTextField(textValue: $newEmail, title: "Escribe tu email").keyboardType(.numberPad)
                        }
                    }
                    Section(header: TextWithCustomFonts("Cambiar contraseña",customFont: CustomFont(type: .bold, size: 20))){
                        CustomTextField(textValue: $newEmail, title: "Escribe tu contraseña actual").keyboardType(.numberPad)
                        CustomTextField(textValue: $newEmail, title: "Escribe nueva contraseña").keyboardType(.numberPad)
                        CustomTextField(textValue: $newEmail, title: "Confirma tu contraseña").keyboardType(.numberPad)
                    }
                }
                RectangleBtn("Guardar"){
                    viewModel.changeProfile(body: ChangeProfileBody(options: "ChangeUserPassword", newEmail: "", currentPassword: "1234567", newPassword: "123456"))
                    
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
