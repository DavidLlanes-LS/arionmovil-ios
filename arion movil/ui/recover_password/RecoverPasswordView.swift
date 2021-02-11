//
//  RecoverPasswordView.swift
//  arion movil
//
//  Created by Daniel Luna on 09/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct RecoverPasswordView: View {
    @State var email: String = ""
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
            VStack {
                TextWithCustomFonts("Ingresa el correo electrónico ligado a la cuenta. Te enviaremos un email con instrucciones para restablecer tu contraseña.", color: .white)
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "Correo electrónico",
                        customFont:
                            CustomFont(type: .bold, size: 16),
                        color: .white
                    )
                    RoundedTextField(textValue: $email, title: "Correo electrónico", textError: "", transparent:false)
                        .padding(.vertical, 32)
                }
                RectangleBtn("Enviar") {
                    
                }.frame(height: 40)
            }
            .padding()
        }.navigationBarTitle(String("Recuperar contraseña"), displayMode: .inline)
    }
}

struct RecoverPassword_Previews: PreviewProvider {
    static var previews: some View {
        RecoverPasswordView()
    }
}
