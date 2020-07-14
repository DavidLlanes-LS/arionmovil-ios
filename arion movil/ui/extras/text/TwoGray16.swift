//
//  TwoGray16.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct TwoGray16Bold: View {
    var title:String
    init(_ title:String) {
        self.title = title
    }
    var body: some View {
        Text(title)
        .font(.custom("Exo", size: 16))
        .foregroundColor(Color("two-gray"))
        .frame(minWidth:0,maxWidth: .infinity,alignment: .center)
    }
}

struct TwoGray16_Previews: PreviewProvider {
    static var previews: some View {
        TwoGray16Bold("Hola")
    }
}
