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
    var body: some View{
        HStack{
            VStack(alignment: .leading, spacing:4){
                TextWithCustomFonts("Saldo disponible",customFont: CustomFont(type: .bold, size: Constants.sizeTextBody), color: Color.white, font: .body)
                HStack{
                    Image("token")
                        .foregroundColor(Color.white)
                    TextWithCustomFonts("\(credits)",customFont: CustomFont(type: .bold, size: Constants.sizeTextPageTitle), color: .white, font: .title)
                    TextWithCustomFonts("créditos",customFont: CustomFont(type: .light, size: Constants.sizeTextBody), color: .white, font: .body)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
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
