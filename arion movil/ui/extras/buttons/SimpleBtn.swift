//
//  SimpleBtn.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 10/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SimpleBtn: View {
    var text:String
    var action:()->()
    var color = Color("secondary-background")
    init(_ text:String, action:@escaping ()->(), color:Color = Color("secondary-background")) {
        self.text = text
        self.action = action
        self.color = color
    }
    var body: some View {
        Button(action: action, label: {
            Text(text).foregroundColor(color)
        })
    }
}

struct SimpleBtn_Previews: PreviewProvider {
    static var previews: some View {
        SimpleBtn("Test"){
            
        }
    }
}
