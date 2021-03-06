//
//  SimpleBtn.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SimpleunderlineBtn: View {
    var text:String
    var action:()->()
    init(_ text:String, action:@escaping ()->()) {
        self.text = text
        self.action = action
    }
    var body: some View {
        Button(action: action, label: {
            TextWithCustomFonts(text, customFont: CustomFont(type: .light, size: Constants.sizeTextBody), color: Color("secondary-background"), font: .body, underline: true)
        })
    }
}

struct SimpleunderlineBtn_Previews: PreviewProvider {
    static var previews: some View {
        SimpleunderlineBtn("Ver todo"){
            
        }
    }
}
