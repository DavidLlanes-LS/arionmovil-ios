//
//  Profile.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var appSettings: AppHelper
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("background")
                VStack{
                   ProfileImage()
                       .frame(width: 200, height: 200)
                   TextWithCustomFonts("David Pacheco",customFont: CustomFont(type: .bold, size: 16), color: Color("two-gray"))
                   Rectangle()
                       .frame(width: 200, height: 0.5)
                       .background(Color("two-gray")).padding(.bottom, 32)
                   List{
                       NavigationLink(destination: CreditCards()){
                           TextWithCustomFonts("Método de pago",customFont: CustomFont(type: .bold, size: 18), color: Color("title"))
                       }
                       NavigationLink(destination: ShopHistory(), label: {
                           TextWithCustomFonts("Historial de compras",customFont: CustomFont(type: .bold, size: 18), color: Color("title")).frame(height:40)
                       })
                       NavigationLink(destination: ChangePasswordEmail(), label: {
                           TextWithCustomFonts("Cambiar correo o contraseña",customFont: CustomFont(type: .semibold, size: 18), color: Color("title")).frame(height:40)
                       })
                       NavigationLink(destination: Settings(), label: {
                           TextWithCustomFonts("Configuraciones",customFont: CustomFont(type: .bold, size: 18), color: Color("title")).frame(height:40)
                       })
                       NavigationLink(destination: Help(), label: {
                           TextWithCustomFonts("Ayuda",customFont: CustomFont(type: .bold, size: 18), color: Color("title")).frame(height:40)
                       })
                    
                       
                       }.padding()
                   
                   RectangleBtn("Cerrar sesión", action: {
                       
                   }).frame(width:200, height:40).padding()
               }
                .onAppear() {
                    appSettings.showCurrentSong = false
                }
            }
           .navigationBarTitle("Perfil", displayMode: .inline)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
