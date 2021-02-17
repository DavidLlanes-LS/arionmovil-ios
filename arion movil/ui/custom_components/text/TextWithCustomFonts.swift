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
    public var customFont:CustomFont = CustomFont(type: .light, size: Constants.sizeTextBody)
    public var color:Color = Color.primary
    public var font: Font.TextStyle = .body
    public var underline:Bool = false
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
    init(_ text:String,color:Color, font: Font.TextStyle) {
        self.text = text
        self.color = color
        self.font = font
    }
    init(_ text:String,customFont:CustomFont, color:Color) {
        self.text = text
        self.color = color
        self.customFont = customFont
    }
    init(_ text:String,customFont:CustomFont, color:Color, font: Font.TextStyle) {
        self.text = text
        self.color = color
        self.customFont = customFont
        self.font = font
    }
    init(_ text:String,customFont:CustomFont, font: Font.TextStyle) {
        self.text = text
        self.customFont = customFont
        self.font = font
    }
    init(_ text:String,customFont:CustomFont, color:Color, font: Font.TextStyle, underline:Bool) {
        self.text = text
        self.color = color
        self.customFont = customFont
        self.font = font
        self.underline = underline
    }
    var body: some View {
        if underline {
            Text(text)
                .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size), relativeTo: self.font))
                .underline()
                .foregroundColor(self.color)
        } else {
            Text(text)
                .font(.custom(self.customFont.type.rawValue, size: CGFloat(self.customFont.size), relativeTo: self.font))
                .foregroundColor(self.color)
        }
    }
}

struct TextWithCustomFonts_Previews: PreviewProvider {
    static var previews: some View {
        TextWithCustomFonts("aa", customFont: CustomFont(type:.bold,size:16))
    }
}
