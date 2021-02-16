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
    @State var banerDate = BannerData(title: "", detail: "", type: .info)
    var userName = UserDefaults.standard.string(forKey: Constants.keyUserName)
    @State var navigationToLogin: Bool = false
    @State var showBanner: Bool = false
    var isAuth = UserDefaults.standard.bool(forKey: Constants.keyIsAuth)
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("background")
                VStack(alignment:.center){
                    NavigationLink(destination: LoginView(), isActive: self.$navigationToLogin) {
                    }
                   ProfileImage()
                       .frame(width: 200, height: 200)
                    //Image("playlist_filled").offset(x:50,y:-165)
                    if userName != nil {
                        
                        TextWithCustomFonts(userName!,customFont: CustomFont(type: .bold, size: 16), color: Color("two-gray")).animation(.default)
                    }
                   
                   List{
                    
                       NavigationLink(destination: CreditCards()){
                        
                           TextWithCustomFonts("Método de pago",customFont: CustomFont(type: .bold, size: 18), color: Color("title"))
                        
                       }.listRowBackground(Color("background"))
                       NavigationLink(destination: ShopHistory(), label: {
                        
                           TextWithCustomFonts("Historial de compras",customFont: CustomFont(type: .bold, size: 18), color: Color("title")).frame(height:40)
                        
                       }).listRowBackground(Color("background"))
                       NavigationLink(destination: ChangePasswordEmail(), label: {
                        
                           TextWithCustomFonts("Cambiar correo o contraseña",customFont: CustomFont(type: .bold, size: 18), color: Color("title")).frame(height:40)
                        
                       }).listRowBackground(Color("background"))
                       NavigationLink(destination: Settings(), label: {
                        
                           TextWithCustomFonts("Configuraciones",customFont: CustomFont(type: .bold, size: 18), color: Color("title")).frame(height:40)
                        
                       }).listRowBackground(Color("background"))
                       NavigationLink(destination: Help(), label: {
                        
                           TextWithCustomFonts("Ayuda",customFont: CustomFont(type: .bold, size: 18), color: Color("title")).frame(height:40)
                        
                       }).listRowBackground(Color("background"))
                            
                       }
                    if isAuth {
                        
                        RectangleBtn("Cerrar sesión", action: {
                            banerDate.title = "Haz cerrado sesión"
                            showBanner = true
                         let defaults = UserDefaults.standard
                         defaults.removeObject(forKey: Constants.keyIsAuth)
                        defaults.removeObject(forKey: Constants.keyCookie)
                         defaults.removeObject(forKey: Constants.keyUserId)
                         
                         UserDefaults.standard.set("", forKey: Constants.keyCookie)
                         appSettings.userCredits = 0
                            appSettings.isLoged = false
                        }).frame(width:200, height:40).padding()
                    }
                    else{
                        
                            RectangleBtn("Iniciar sesión", action: {
                                navigationToLogin = true
                            }).frame(width:200, height:40).padding()
                       
                    }
                  
                }.banner(data: $banerDate, show: $showBanner)
                .onAppear() {
                    if isAuth{
                    if appSettings.isLoged{
                        banerDate.title = "Bienvenido \(userName!)"
                        showBanner = true
                        appSettings.isLoged = false
                    }}
                    appSettings.showCurrentSong = false
                }.onDisappear{
                    showBanner = false
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
