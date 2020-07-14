//
//  Settings.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @State var darkMode: Bool = false
    
    var body: some View {
        Form{
            Toggle(isOn: $darkMode) {
                TextWithCustomFonts("Modo de visualización oscuro")
            }.onReceive([self.darkMode].publisher.first()) { (value) in
                let manager =  UserDefaultManager()
                if self.darkMode{
                    manager.saveThemeMode(themeMode: .dark)
                    UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .dark
                }else{
                    manager.saveThemeMode(themeMode: .light)
                    UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .light
                }
            }
        }.onAppear{
            let usHelper = UserDefaultManager()
            self.darkMode = (usHelper.getThemeMode() == .dark)
        }.navigationBarTitle("Configuraciones")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
