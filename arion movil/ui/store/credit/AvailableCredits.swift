//
//  AvailableCredits.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct AvailableCredits: View {
    @Binding var credits:Int
    init(credits:Binding<Int>) {
       _credits = credits
    }
    var body: some View {
        HStack{
            HStack{
                TextWithCustomFonts("Saldo disponible",customFont: CustomFont(type: .bold, size: Constants.sizeTextBody),color: Color.white, font: .body)
                Spacer()
                Image("token")
                    .foregroundColor(Color.white)
                TextWithCustomFonts("\(credits) créditos",customFont: CustomFont(type: .bold, size: Constants.sizeTextBody),color: Color.white, font: .body)
            }.padding()
        }.frame(height:40).background(Color("secondary-background"))
    }
}

struct AvailableCredits_Previews: PreviewProvider {
    @State static var test = 23
    static var previews: some View {
        AvailableCredits(credits: $test)
    }
}
