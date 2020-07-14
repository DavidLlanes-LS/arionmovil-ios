//
//  CreateNewCreditCard.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 07/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct CreateNewCreditCard: View {
    @State private var dateIndex:Int = 0
    @State private var dates:[Int] = Array(1...30)
    @State private var years:[Int] = Array(1...12)
    @State private var yearIndex:Int = 0
    @State private var cardName:String = ""
    @ObservedObject private var cardNumberBinding = TextBindingManager(limit: 18)
    @ObservedObject private var cardCVVBinding = TextBindingManager(limit: 3)
    
    var body: some View {
        ZStack{
            Color("background")
            VStack{
                Form{
                    Section(header: TextWithCustomFonts("Nombre del titular",customFont: CustomFont(type: .bold, size: 18))){
                        CustomTextField(textValue: self.$cardName, title: "Escribe el nombre del titular")
                    }
                    Section(header: TextWithCustomFonts("Número de tarjeta",customFont: CustomFont(type: .bold, size: 18))){
                        CustomTextField(textValue: $cardNumberBinding.text, title: "Escribe el número de la tarjeta").keyboardType(.numberPad)
                    }
                    Section(header: TextWithCustomFonts("Fecha de vencimiento",customFont: CustomFont(type: .bold, size: 18))){
                        Picker(selection: $dateIndex, label: TextWithCustomFonts("Día")) {
                            ForEach(0 ..< dates.count) {
                                TextWithCustomFonts("\(self.dates[$0])")
                            }
                        }
                        Picker(selection: $yearIndex, label: TextWithCustomFonts("Mes")) {
                            ForEach(0 ..< years.count) {
                                TextWithCustomFonts("\(self.years[$0])")
                            }
                        }
                    }
                    Section(header: TextWithCustomFonts("CVV",customFont: CustomFont(type: .bold, size: 18))){
                        CustomTextField(textValue: $cardCVVBinding.text, title: "Escribe el cvv de la tarjeta").keyboardType(.numberPad)
                    }
                    
                }.padding(.top, 16)
                RectangleBtn("Guardar"){
                    
                }.disabled(!self.isValuesReady()).frame(width:200, height:40)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .center).padding()
            }.navigationBarTitle("Nuevo método de pago")
        }
        
    }
    
    func isValuesReady() -> Bool {
        if self.cardName.count > 0 {
            if self.cardNumberBinding.text.count == 16 || self.cardNumberBinding.text.count == 18{
                if self.cardCVVBinding.text.count == 3{
                    return true
                }
            }
        }
        return false
    }
}

struct CreateNewCreditCard_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewCreditCard()
    }
}
