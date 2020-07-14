//
//  FilterButton.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct FilterButton: View {
    var text:String
    var action:()->()
    var body: some View {
        Button(action: self.action, label: {
            TextWithCustomFonts(self.text,customFont: CustomFont(type: .semibold, size: 16),color: Color.white)
                .frame(height:60).frame(minWidth:0,maxWidth: .infinity,alignment: .center)
        }).background(Color("secondary-background"))
        .cornerRadius(3)
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(text: "Hola"){
            
        }
    }
}
