//
//  TextWithCustomFonts.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct TextWithCustomFonts: View {
    public var text:String
    public var customFont:CustomFont = CustomFont(type: .light, size: 16)
    public var color:Color = Color.primary
    init(_ text:String) {
        self.text = text
    }
    init(_ text:String,customFont:CustomFont) {
        self.text = text
        self.customFont = customFont
    }
    init(_ text:String,color:Color) {
        self.text = text
        self.color = color
    }
    init(_ text:String,customFont:CustomFont, color:Color) {
        self.text = text
        self.color = color
        self.customFont = customFont
    }
    var body: some View {
        Text(text)
            .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size)))
            .foregroundColor(self.color)
    }
}

struct TextWithCustomFonts_Previews: PreviewProvider {
    static var previews: some View {
        TextWithCustomFonts("aa", customFont: CustomFont(type:.bold,size:16))
    }
}
