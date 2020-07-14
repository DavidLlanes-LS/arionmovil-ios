//
//  CreditCardRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct CreditCardRow: View {
    var body: some View {
        VStack{
            VStack(alignment:.leading, spacing:32){
                TextWithCustomFonts("Tarjeta guardada",customFont: CustomFont(type: .bold, size: 16),color: Color.white)
                HStack(spacing:22){
                    HStack(spacing:8){
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                    }
                    HStack(spacing:8){
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                    }
                    HStack(spacing:8){
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                        TextWithCustomFonts("*",customFont: CustomFont(type: .semibold, size: 22),color: .white)
                    }
                    HStack(spacing:8){
                        TextWithCustomFonts("3",customFont: CustomFont(type: .bold, size: 22),color: .white)
                        TextWithCustomFonts("2",customFont: CustomFont(type: .bold, size: 22),color: .white)
                        TextWithCustomFonts("1",customFont: CustomFont(type: .bold, size: 22),color: .white)
                        TextWithCustomFonts("1",customFont: CustomFont(type: .bold, size: 22),color: .white)
                    }
                }.frame(minWidth:0, maxWidth: .infinity)
                
                TextWithCustomFonts("12/25",customFont: CustomFont(type: .semibold, size: 20),color: .white)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                }.padding()
        }.background(Color("gray-lightgray")).cornerRadius(10)
    }
}

struct CreditCardRow_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardRow()
    }
}
