//
//  CreditCards.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct CreditCards: View {
    var body: some View {
        VStack{
            List{
                CreditCardRow()
            }
            NavigationLink(destination: CreateNewCreditCard()){
                RedRectangleText("Añadir método de pago").frame(width: 250, height: 40, alignment: .center)
            }
        }.padding().background(Color("background")).navigationBarTitle("Método de pago")
    }
}

struct CreditCards_Previews: PreviewProvider {
    static var previews: some View {
        CreditCards()
    }
}
