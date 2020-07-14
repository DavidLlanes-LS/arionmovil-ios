//
//  ShopHistoryRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ShopHistoryRow: View {
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                TextWithCustomFonts("Paquete Básico", customFont: CustomFont(type: .bold, size: 16)).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
                TextWithCustomFonts("22/12/2020", customFont: CustomFont(type: .light, size: 22)).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
            }
            TextWithCustomFonts("$100",customFont: CustomFont(type: .bold, size: 18), color: Color("secondary-background"))
        }
    }
}

struct ShopHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        ShopHistoryRow()
    }
}
