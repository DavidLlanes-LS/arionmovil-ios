//
//  UserDefaultManager.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

enum ThemeMode:String {
    case dark = "dark"
    case light = "light"
}

class UserDefaultManager {
    let defaultU = UserDefaults.standard
    
    func saveThemeMode(themeMode:ThemeMode) {
        defaultU.set(themeMode.rawValue, forKey: "theme")
    }
    
    func getThemeMode() -> ThemeMode{
        let theme =  defaultU.value(forKey: "theme") as? String
        if theme == ThemeMode.dark.rawValue {
            return ThemeMode.dark
        }
        return ThemeMode.light
    }

}
