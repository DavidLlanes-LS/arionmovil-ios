//
//  RedRectangleNavLink.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct RedRectangleText: View {
    var text:String
    init(_ text:String) {
        self.text = text
    }
    var body: some View {
        TextWithCustomFonts(self.text, customFont: CustomFont(type: .semibold, size: Constants.sizeTextFormControls), color: Color.white).frame(minWidth:0,maxWidth: .infinity,minHeight:0 ,maxHeight: .infinity, alignment: .center)
            .background(Color("secondary-background")).cornerRadius(5)
    }
}

struct RedRectangleText_Previews: PreviewProvider {
    static var previews: some View {
        RedRectangleText("Hola")
    }
}
