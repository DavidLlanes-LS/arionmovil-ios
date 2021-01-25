//
//  CustomFonts.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import Foundation


enum CustomFontType:String{
    case bold = "Exo-Bold"
    case semibold = "Exo-SemiBold"
    case light = "Exo-Light"
}

struct CustomFont {
    var type:CustomFontType
    var size:Float
}
