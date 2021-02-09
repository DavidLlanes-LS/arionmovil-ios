//
//  CreditCardRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
struct CreditCardRow: View {
    var card:CreditCard
    init(card:CreditCard) {
        self.card = card
    }
    var body: some View {
        VStack{
            VStack(alignment:.leading, spacing:32){
                TextWithCustomFonts("Tarjeta guardada",customFont: CustomFont(type: .bold, size: 16),color: Color.white)
                HStack(alignment:.center,spacing:18){
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
                    HStack(){
                        TextWithCustomFonts(String(card.cardNumber!.suffix(4)),customFont: CustomFont(type: .bold, size: 15),color: .white)
//                        TextWithCustomFonts(String(card.cardNumber![13]),customFont: CustomFont(type: .bold, size: 15),color: .white)
//                        TextWithCustomFonts(String(card.cardNumber![14]),customFont: CustomFont(type: .bold, size: 15),color: .white)
//                        TextWithCustomFonts(String(card.cardNumber![15]),customFont: CustomFont(type: .bold, size: 15),color: .white)
                    }
                }.frame(minWidth:0, maxWidth: .infinity)
                
                TextWithCustomFonts("\(card.expirationMonth!)/\(card.expirationYear!.suffix(2))",customFont: CustomFont(type: .semibold, size: 20),color: .white)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                }.padding()
        }.background(Color("gray-lightgray")).cornerRadius(10)
    }
}

struct CreditCardRow_Previews: PreviewProvider {
    static var previews: some View {
        var credit: CreditCard = CreditCard()
        CreditCardRow(card: credit)
    }
}
