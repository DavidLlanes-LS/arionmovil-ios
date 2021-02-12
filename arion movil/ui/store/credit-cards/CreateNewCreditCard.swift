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
    @State private var monthsArr:[String] = []
    @State private var years:[Int] = Array(21...30)
    @State private var yearIndex:Int = 0
    @State var openpay : Openpay!
    @EnvironmentObject var appSettings: AppHelper;
    @State var isPresented:Bool = false
    @State private var cardName:String = ""
    @State  var errorMessage:String = ""
    @State private var token:String = ""
    @State private var sessionId:String = ""
    @ObservedObject private var cardNumberBinding = TextBindingManager(limit: 16)
    @ObservedObject private var cardCVVBinding = TextBindingManager(limit: 3)
    @StateObject var viewModel = CardViewModel()
    init(){
        months = Array(1...12)
        self.monthsArr = self.months.map {
            String($0)
            
        }
    }
    var body: some View {
        ZStack{
            Color("background")
            VStack{
                Form{
                    Section(header: TextWithCustomFonts("Nombre del titular",customFont: CustomFont(type: .bold, size: 18))){
                      // CustomTextField(textValue: self.$cardName, title: "Escribe el nombre del titular")
                        RoundedTextField(textValue: self.$cardName, title: "Escribe el nombre del titular", textError:"",transparent: true)
                    }
                    Section(header: TextWithCustomFonts("Número de tarjeta",customFont: CustomFont(type: .bold, size: 18))){
                        RoundedTextField(textValue: $cardNumberBinding.text, title: "Escribe el número de tarjeta", textError:"",transparent: true).keyboardType(.numberPad)
//                        CustomTextField(textValue: $cardNumberBinding.text, title: "Escribe el número de la tarjeta").keyboardType(.numberPad)
                    }
                    Section(header: TextWithCustomFonts("Fecha de vencimiento",customFont: CustomFont(type: .bold, size: 18))){
                        HStack{
                            PickerRounded(selection:  $dateIndex, title: "Seleccionar", data: months, textError: "", transparent: true)
                            VStack{}.frame(width:10)
                            PickerRounded(selection:  $yearIndex, title: "Seleccionar", data: years, textError: "", transparent: true)
                            
                        }
                    }
                    Section(header: TextWithCustomFonts("CVV",customFont: CustomFont(type: .bold, size: 18))){
                       // CustomTextField(textValue: $cardCVVBinding.text, title: "Escribe el cvv de la tarjeta").keyboardType(.numberPad)
                      
                            
                            RoundedTextField(textValue:  $cardCVVBinding.text, title: "Escribe el cvv de la tarjeta", textError:"",transparent: true).keyboardType(.numberPad)
                        
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
        }.alert(isPresented: $isPresented) {
            Alert(title: Text(String("Aviso").capitalized), message: Text(Constants.failAddCardDefaultMsg.lowercased()), dismissButton: .default(Text(String("Aceptar").capitalized)))
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
        viewModel.appSettings = self.appSettings
        viewModel.addCard(body:AddCardBody(cardToken: self.token, deviceSessionId: self.sessionId) ){
            self.presentationMode.wrappedValue.dismiss()
        } onFail:{
            isPresented = true
        }
           
    }

    func failToken(error: NSError) {
            print("openpayR\(error.code) - \(error.localizedDescription)")
        viewModel.showLoader = false
        isPresented = true
        
    }
    func successSession(sessionId: String) {
            print("openpaySessionID: \(sessionId)")
        self.sessionId = sessionId
       
       
    }

    func failSession(error: NSError) {
            print("openpayR\(error.code) - \(error.localizedDescription)")
        viewModel.showLoader = false
        isPresented = true
    }
}

struct CreateNewCreditCard_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewCreditCard()
    }
}
