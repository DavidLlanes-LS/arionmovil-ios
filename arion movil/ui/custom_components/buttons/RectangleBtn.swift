//
//  RectangleBtn.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct RectangleBtn: View {
    var text:String
    var action:()->()
    init(_ text:String, action:@escaping ()->()) {
        self.text = text
        self.action = action
    }
    var body: some View {
        Button(action: action,label: {
            RedRectangleText(self.text)
        }).buttonStyle(PlainButtonStyle())
    }
}

struct RectangleBtn_Previews: PreviewProvider {
    static var previews: some View {
        RectangleBtn("aaa"){
            
        }
    }
}
