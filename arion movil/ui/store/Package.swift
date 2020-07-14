//
//  Package.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Package: View {
    var body: some View {
        HStack{
            HStack{
                TextWithCustomFonts("Básico",customFont: CustomFont(type: .bold, size: 16), color: Color("secondary-background")).frame(width:60)
                TextWithCustomFonts("- 20 Créditos",customFont: CustomFont(type: .semibold, size: 16), color: Color("light-gray")).frame(minWidth:0,maxWidth: .infinity, alignment: .leading)
                TextWithCustomFonts("$50",customFont: CustomFont(type: .bold, size: 16), color: Color("title")).frame(width:60).frame(width:40)
            }.padding()
        }.background(Color("gray-background"))
    }
}

struct Package_Previews: PreviewProvider {
    static var previews: some View {
        Package()
        .environment(\.colorScheme, .dark)
    }
}
