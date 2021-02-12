//
//  Store.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI
import BottomSheet
extension String {
    var capitalizedFirstLetter:String {
        let string = self
        return string.replacingCharacters(in: startIndex...startIndex, with: String(self[startIndex]).capitalized)
    }
}
struct Store: View {
    @StateObject var viewModel = StoreViewModel()
    @EnvironmentObject var appSettings: AppHelper
    @StateObject var cardViewModel = CardViewModel()
    @State var openpay : Openpay!
    @State var showBottomSheet:Bool = false
    @State var showAlertQuestion:Bool = false
    @State var showAlertResult:Bool = false
    @State var selectedPackage:Packages = Packages()
    var isAuth = UserDefaults.standard.bool(forKey: Constants.keyIsAuth)
    var body: some View {
        NavigationView{
            ZStack {
                VStack(spacing:0){
                    AvailableCreditsBig(credits: $appSettings.userCredits)
                    List{
                        TextWithCustomFonts("Paquetes disponibles",customFont: CustomFont(type: .bold, size: 17),color:Color("title")).listRowBackground(Color("background"))
                        if isAuth{
                            
                            ForEach(viewModel.pakcagesList,id:\.self){package in
                                Button(action:{
                                    selectedPackage = package
                                    showBottomSheet = true
                                    
                                    
                                }){Package(package: package)}.listRowBackground(Color("background"))
                                
                            }
                            
                        }
                        
                    }.listStyle(PlainListStyle())
                    Spacer()
                    if isAuth{
                        VStack{}.onAppear{
                            viewModel.getPackages()
                            viewModel.appSettings = self.appSettings
                            cardViewModel.appSettings = self.appSettings
                            viewModel.getCreditsUser()
                            cardViewModel.getCreditList()
                        }
                    }
                }.background(Color("background"))
                .navigationBarTitle("Compras", displayMode: .inline)
                .onAppear() {
                    appSettings.showCurrentSong = false
                }.bottomSheet(isPresented: $showBottomSheet, height: cardViewModel.creditCards.count > 0 ? 260:260) {
                    VStack(alignment:.center){
                        Form{
                            
                            if cardViewModel.creditCards.count <= 0 {
                                List{
                                    NavigationLink(destination: CreateNewCreditCard(), label: {
                                        TextWithCustomFonts("Agregar método de pago",customFont: CustomFont(type: .semibold, size: 18), color: Color("title")).frame(height:40)
                                    }).listRowBackground(Color("background"))
                                }
                            }
                            else{
                                
                                NavigationLink(destination:CreditCards().onAppear{
                                    appSettings.isFromStoreToCreditCard = true
                                }.onDisappear{
                                    appSettings.isFromStoreToCreditCard = false
                                }, label: {
                                    
                                    HStack{
                                        if appSettings.selectedPayCard!.brand == "mastercard"{
                                            Image("mastercard").resizable() .scaledToFit().frame(maxWidth:40)
                                        }
                                        else if appSettings.selectedPayCard!.brand == "visa"{
                                            Image("visa").renderingMode(.template).resizable() .scaledToFit().frame(maxWidth:40).foregroundColor(Color("visa_color"))
                                        }
                                        TextWithCustomFonts(String(appSettings.selectedPayCard!.cardNumber!.suffix(4)),customFont: CustomFont(type: .semibold, size: 18), color: Color("title")).frame(height:40)
                                    }
                                    
                                }).listRowBackground(Color("background"))
                            }
                            
                        }
                        
                        
                        
                        RectangleBtn("Aceptar"){
                            showAlertQuestion = true
                        }.disabled(cardViewModel.creditCards.count > 0 ? false:true).frame(width: 250, height: 40, alignment: .center)
                        Spacer().frame(height:10)
                    }.background(Color("background"))
                }.background(Color("background"))
                if viewModel.isLoading  {
                    VStack{
                        Spacer()
                        LoaderComponent()
                        Spacer()
                    }.frame(maxWidth:.infinity,maxHeight: .infinity).background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
                }
                
                
                
                
            }.banner(data: $viewModel.banerDate, show: $viewModel.showResult)}.environmentObject(appSettings).alert(isPresented: $showAlertQuestion) { () -> Alert in
                Alert(
                    title:Text(String("Comprar paquete").capitalized),
                    message: Text(String("Se te hará un cobro de $\(self.selectedPackage.price ?? 0.00) por compra del paquete \(self.selectedPackage.name ?? "")")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)){
                        showBottomSheet = false
                    },
                    secondaryButton: .default(Text(String("Aceptar").capitalized)) {
                        self.openpay = Openpay(withMerchantId: Constants.idOpenPayMerchant, andApiKey: Constants.keyOpenPay, isProductionMode: false)
                        openpay.createDeviceSessionId(successFunction: successSession, failureFunction: failSession)
                        showBottomSheet = false
                    })
            }
        
        
    }
    func successSession(sessionId: String) {
        var body:BuyCreditsBody = BuyCreditsBody()
        body.locationId = appSettings.currentBranchId
        body.packageId = self.selectedPackage.id!
        body.requestInvoice = false
        body.token = appSettings.selectedPayCard!.id
        body.deviceSessioniD = sessionId
        
        withAnimation{
            viewModel.buyCredits(body:body)
        }
        
        
        
        
        
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
