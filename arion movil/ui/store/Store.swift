//
//  Store.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI
import BottomSheet
struct Store: View {
    @EnvironmentObject var appHelper: AppHelper;
    @StateObject var viewModel = StoreViewModel()
    @EnvironmentObject var appSettings: AppHelper
    @State private var dateIndex:Int = 0
    @State var openpay : Openpay!
    @State var isPresented:Bool = false
    @State var selectedPackage:Packages = Packages()
    var body: some View {
        NavigationView{
            ZStack {
                VStack(spacing:0){
                    AvailableCreditsBig(credits: $appSettings.userCredits)
                    List{
                        TextWithCustomFonts("Paquetes disponibles",customFont: CustomFont(type: .bold, size: 22),color:Color("title"))
                        ForEach(viewModel.pakcagesList,id:\.self){package in
                            Button(action:{
                                selectedPackage = package
                                isPresented = true
                                
                                
                            }){Package(package: package)}
                            
                        }
                    }.listStyle(PlainListStyle())
                    Spacer()
                }.background(Color("background"))
                .navigationBarTitle("Compras", displayMode: .inline)
                .onAppear() {
                    appSettings.showCurrentSong = false
                }.bottomSheet(isPresented: $isPresented, height: 300) {
                    VStack(alignment:.center){
                        Form{
                            Section(header: TextWithCustomFonts("Método de pago",customFont: CustomFont(type: .bold, size: 18))){
                                Picker(selection: $dateIndex, label: TextWithCustomFonts("Tarjeta")) {
                                    ForEach(appHelper.payCards, id:\.self) {card in
                                        CreditCardRow(card: card)
                                       
                                    }
                                }}
                            
                        }
                        TextWithCustomFonts("Selección: \(appSettings.payCards[dateIndex].cardNumber!)",customFont: CustomFont(type: .light, size: 16))
                        Spacer().frame(height:14)
                        Button(action:{
                            self.openpay = Openpay(withMerchantId: Constants.idOpenPayMerchant, andApiKey: Constants.keyOpenPay, isProductionMode: false)
                            openpay.createDeviceSessionId(successFunction: successSession, failureFunction: failSession)
                            isPresented = false
                           
                        }){
                            RedRectangleText("Aceptar").frame(width: 250, height: 40, alignment: .center)
                           
                        }
                        Spacer().frame(height:20)
                    }
                }
                if viewModel.isLoading  {
                    VStack{
                        Spacer()
                        LoaderComponent()
                        Spacer()
                    }
                }
                
                   
                
              
            }
        }.onAppear{
            viewModel.getPackages()
            viewModel.appSettings = self.appSettings
            viewModel.getCreditsUser()
        }.environmentObject(appSettings)
        
    }
    func successSession(sessionId: String) {
        var body:BuyCreditsBody = BuyCreditsBody()
        body.locationId = appSettings.currentBranchId
        body.packageId = self.selectedPackage.id!
        body.requestInvoice = false
        body.token = appHelper.payCards[dateIndex].id
        body.deviceSessioniD = sessionId
        viewModel.buyCredits(body:body)
        
       
       
    }

    func failSession(error: NSError) {
            print("openpayR\(error.code) - \(error.localizedDescription)")
    }
}


struct BlurView : UIViewRepresentable {
    
    var style : UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView{
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
        
    }
}

struct Store_Previews: PreviewProvider {
    static var previews: some View {
        Store()
    }
}
