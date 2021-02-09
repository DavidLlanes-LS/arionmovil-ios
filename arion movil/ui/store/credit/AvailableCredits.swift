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
                TextWithCustomFonts("Saldo disponible",customFont: CustomFont(type: .bold, size: 16),color: Color.white)
                Spacer()
                Image(systemName: "music.note")
                .foregroundColor(Color.white)
                Text("\(credits) créditos")
                    .font(.custom("Exo-Semibold", size: 16))
                    .foregroundColor(Color.white)
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
