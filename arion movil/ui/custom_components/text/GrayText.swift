//
//  GrayText.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct GrayText: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .font(.custom("Exo", size: 16))
        .fontWeight(.bold)
        .foregroundColor(Color("title-row"))
        .frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
    }
}

struct GrayText_Previews: PreviewProvider {
    static var previews: some View {
        GrayText()
    }
}
