//
//  CreateNewCreditCard.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 07/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct CreateNewCreditCard: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var dateIndex:Int = 0
    @State private var months:[Int] = Array(1...12)
    @State private var years:[Int] = Array(21...30)
    @State private var yearIndex:Int = 0
    @State var openpay : Openpay!
    @State private var cardName:String = ""
    @State private var token:String = ""
    @State private var sessionId:String = ""
    @ObservedObject private var cardNumberBinding = TextBindingManager(limit: 16)
    @ObservedObject private var cardCVVBinding = TextBindingManager(limit: 3)
    @StateObject var viewModel = CardViewModel()
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
                        Picker(selection: $dateIndex, label: TextWithCustomFonts("Mes")) {
                            ForEach(0 ..< months.count) {
                                TextWithCustomFonts("\(self.months[$0])")
                            }
                        }
                        Picker(selection: $yearIndex, label: TextWithCustomFonts("Año")) {
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
                    myFunction()
                    
                }.disabled(!self.isValuesReady()).frame(width:200, height:40)
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .center).padding()
            }.navigationBarTitle("Nuevo método de pago").onAppear{
               
            }
            if viewModel.showLoader {
            VStack{
               
                    Spacer()
                    LoaderComponent()
                    Spacer()
                
            }.frame(maxWidth:.infinity,maxHeight: .infinity).background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
            }
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
    func myFunction(){
        viewModel.showLoader = true
      
        self.openpay = Openpay(withMerchantId: Constants.idOpenPayMerchant, andApiKey: Constants.keyOpenPay, isProductionMode: false)
        let card:OPCard = OPCard()
        card.holderName = cardName
        card.number = cardNumberBinding.text
        card.expirationMonth = String(months[dateIndex])
        card.expirationYear = String(years[yearIndex])
        card.cvv2 = cardCVVBinding.text
        openpay.createDeviceSessionId(successFunction: successSession, failureFunction: failSession)
        openpay.createTokenWithCard(address: nil, card: card, successFunction: successToken, failureFunction: failToken)
        
        
    }

    func successToken(token: OPToken) {
            print("openpayTokenID: \(token.id)")
            self.token = token.id
        viewModel.addCard(body:AddCardBody(cardToken: self.token, deviceSessionId: self.sessionId) ){
            self.presentationMode.wrappedValue.dismiss()
        }
           
    }

    func failToken(error: NSError) {
            print("openpayR\(error.code) - \(error.localizedDescription)")
    }
    func successSession(sessionId: String) {
            print("openpaySessionID: \(sessionId)")
        self.sessionId = sessionId
       
       
    }

    func failSession(error: NSError) {
            print("openpayR\(error.code) - \(error.localizedDescription)")
    }
}

struct CreateNewCreditCard_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewCreditCard()
    }
}
