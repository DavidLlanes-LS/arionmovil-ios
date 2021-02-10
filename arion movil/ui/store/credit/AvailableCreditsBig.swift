//
//  AvailableCreditsBig.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct AvailableCreditsBig: View {
    @Binding var credits:Int
    init(credits:Binding<Int>) {
       _credits = credits
    }
    var body: some View {
        HStack{
            VStack(spacing:4){
                TextWithCustomFonts("Saldo disponible",customFont: CustomFont(type: .bold, size: 16),color: Color.white)
                HStack{
                    Image("token")
                        .foregroundColor(Color.white)
                    TextWithCustomFonts("\(credits)",customFont: CustomFont(type: .bold, size: 30),color: .white)
                    TextWithCustomFonts("créditos",customFont: CustomFont(type: .light, size: 16),color: .white)
                }
            }
            Spacer()
        }.padding([.bottom,.top,.leading],4).frame(minWidth:0,maxWidth: .infinity).background(Color("secondary-background"))
    }
}

struct AvailableCreditsBig_Previews: PreviewProvider {
    @State static var test = 23
    static var previews: some View {
        AvailableCreditsBig(credits: $test)
    }
}
