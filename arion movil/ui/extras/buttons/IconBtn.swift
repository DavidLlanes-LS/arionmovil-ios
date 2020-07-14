//
//  IconBtn.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct IconBtn: View {
    var iconName:String
    var action:()->()
    init(_ iconName:String, action:@escaping ()->()) {
        self.iconName = iconName
        self.action = action
    }
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: iconName).foregroundColor(Color("secondary-background")).font(.title)
        })
    }
}

struct IconBtn_Previews: PreviewProvider {
    static var previews: some View {
        IconBtn("arrow.right.circle"){}
    }
}
