//
//  Help.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Help: View {
    var body: some View {
        ZStack{
            Color("background")
            ScrollView{
                VStack(alignment: .leading,spacing:16){
                    TextWithCustomFonts("Centro de contacto",customFont: CustomFont(type: .bold, size: Constants.sizeTextBody))
                    TextWithCustomFonts("Puedes llamarnos a nuestro número de atención a clientes al 33 1234 5678 de lunes a viernes de 09:00 a 18: 00 horas o escribirnos al correo ayuda@gmail.com",customFont: CustomFont(type: .light, size: Constants.sizeTextSecondaryText))
                    TextWithCustomFonts("FAQs",customFont: CustomFont(type: .bold, size: Constants.sizeTextBody))
                    VStack(alignment: .leading, spacing: 8){
                        TextWithCustomFonts("¿Cómo puedo adelantar una canción?",customFont: CustomFont(type: .light, size: Constants.sizeTextBody),color: Color("secondary-background"))
                        TextWithCustomFonts("Lorem ipsom dolor sit amet lorem ipsom dolor sit amet orem ipsom dolor sit amet lorem ipsom dolor sit amet lorem ipsom dolor sit amet. .",customFont: CustomFont(type: .light, size: Constants.sizeTextSecondaryText))
                        TextWithCustomFonts("¿Cómo funcionan las subastas?",customFont: CustomFont(type: .light, size: Constants.sizeTextBody),color: Color("secondary-background"))
                        TextWithCustomFonts("Lorem ipsom dolor sit amet lorem ipsom dolor sit amet orem ipsom dolor sit amet lorem ipsom dolor sit amet lorem ipsom dolor sit amet. .",customFont: CustomFont(type: .light, size: Constants.sizeTextSecondaryText))
                        TextWithCustomFonts("¿Qué son los puntos?",customFont: CustomFont(type: .light, size: Constants.sizeTextBody),color: Color("secondary-background"))
                        TextWithCustomFonts("Lorem ipsom dolor sit amet lorem ipsom dolor sit amet orem ipsom dolor sit amet lorem ipsom dolor sit amet lorem ipsom dolor sit amet. .",customFont: CustomFont(type: .light, size: Constants.sizeTextSecondaryText))
                        TextWithCustomFonts("¿Cómo puedo conseguir puntos?",customFont: CustomFont(type: .light, size: Constants.sizeTextBody),color: Color("secondary-background"))
                        TextWithCustomFonts("Lorem ipsom dolor sit amet lorem ipsom dolor sit amet orem ipsom dolor sit amet lorem ipsom dolor sit amet lorem ipsom dolor sit amet. .",customFont: CustomFont(type: .light, size: Constants.sizeTextSecondaryText))
                        TextWithCustomFonts("¿Dondé puedo usar mi app de Arion móvil?",customFont: CustomFont(type: .light, size: Constants.sizeTextBody),color: Color("secondary-background"))
                        TextWithCustomFonts("Lorem ipsom dolor sit amet lorem ipsom dolor sit amet orem ipsom dolor sit amet lorem ipsom dolor sit amet lorem ipsom dolor sit amet. .",customFont: CustomFont(type: .light, size: Constants.sizeTextSecondaryText))
                    }
                    
                }.padding()
            }.navigationBarTitle(String("Ayuda"))
        }
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
