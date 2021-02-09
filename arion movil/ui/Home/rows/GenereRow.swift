//
//  GenereRow.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 02/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct GenereRow: View {
    var name = ""
    var artist = ""
    var funct:() -> ()
    @Binding var navigateLogin:Bool
    var isAuth = UserDefaults.standard.bool(forKey: Constants.keyIsAuth)
    @State var showAlert: Bool = false
    init(name:String,artist:String, navigateLogin:Binding<Bool>,funct:@escaping ()->()) {
        self.name = name
        self.artist = artist
        self.funct = funct
        _navigateLogin = navigateLogin
    }
    @State var logo:String = "playlist_unfilled"
    var body: some View {
        HStack {
            VStack(alignment:.leading){
                TextWithCustomFonts(self.name, customFont: CustomFont(type: .bold, size: 15))
                TextWithCustomFonts(self.artist, customFont: CustomFont(type: .light, size: 14))



            }

            Spacer()
            Button(action: {
                logo = "playlist_filled"
                showAlert = true
            }, label: {
                Image(logo)

            })

        }.buttonStyle(PlainButtonStyle()).alert(isPresented: $showAlert, content: {
            if (isAuth) {
                return Alert(
                    title:Text(String("Atención").capitalized),
                    message: Text(String("¿Quieres agregar esta canción a la fila por un costo de 10 créditos?")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                    secondaryButton: .default(Text(String("Aceptar").capitalized)) {
                            funct()
                    }
                )
            } else {
                return Alert(
                    title:Text(String("Inicia sesión para continuar")),
                    message: Text(String("Iniciar sesión o crear una cuenta para poder realizar esta acción.")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                    secondaryButton: .default(Text(String("Aceptar").capitalized)) {
                        navigateLogin = true
                    }
                )
            }
        }).background(Color("background"))
    }
}

struct GenereRow_Previews: PreviewProvider {
    @State static var nav = false
    static var previews: some View {
        GenereRow(name: "sfsdfdsfds", artist: "sdfsddfdsf",navigateLogin: $nav){}
    }
}
