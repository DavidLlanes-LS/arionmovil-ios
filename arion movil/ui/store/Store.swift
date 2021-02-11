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
    @State private var dateIndex:Int = 0
    @State var openpay : Openpay!
    @State var showBottomSheet:Bool = false
    @State var showAlertQuestion:Bool = false
    @State var showAlertResult:Bool = false
    @State var selectedPackage:Packages = Packages()
    var body: some View {
        NavigationView{
            ZStack {
                VStack(spacing:0){
                    AvailableCreditsBig(credits: $appSettings.userCredits)
                    List{
                        TextWithCustomFonts("Paquetes disponibles",customFont: CustomFont(type: .bold, size: 17),color:Color("title")).listRowBackground(Color("background"))
                        ForEach(viewModel.pakcagesList,id:\.self){package in
                            Button(action:{
                                selectedPackage = package
                                showBottomSheet = true
                                
                                
                            }){Package(package: package)}.listRowBackground(Color("background"))
                            
                        }
                    }.listStyle(PlainListStyle())
                    Spacer()
                }.background(Color("background"))
                .navigationBarTitle("Compras", displayMode: .inline)
                .onAppear() {
                    appSettings.showCurrentSong = false
                }.bottomSheet(isPresented: $showBottomSheet, height: cardViewModel.creditCards.count > 0 ? 420:300) {
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
                                Section(header: TextWithCustomFonts("Método de pago",customFont: CustomFont(type: .bold, size: 18))){
                                    Picker(selection: $dateIndex, label: TextWithCustomFonts("")) {
                                        ForEach(0 ..< cardViewModel.creditCards.count, id:\.self) {index in
                                            CreditCardRow(card: cardViewModel.creditCards[index]).frame(minWidth:0, maxWidth: 300).listRowBackground(Color("background"))
                                            
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        
                        Spacer().frame(height:14)
                        
                        RectangleBtn("Aceptar"){
                            showAlertQuestion = true
                        }.disabled(cardViewModel.creditCards.count > 0 ? false:true).frame(width: 250, height: 40, alignment: .center)
                        Spacer().frame(height:20)
                    }.background(Color("background"))
                }.background(Color("background"))
                if viewModel.isLoading  {
                    VStack{
                        Spacer()
                        LoaderComponent()
                        Spacer()
                    }.frame(maxWidth:.infinity,maxHeight: .infinity).background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
                }
                
                
                
                
            }.onAppear{
                cardViewModel.appSettings = self.appSettings
                cardViewModel.getCreditList()
                viewModel.getPackages()
                viewModel.appSettings = self.appSettings
                viewModel.getCreditsUser()
            }.onDisappear{
                dateIndex = 0
            }.alert(isPresented: $viewModel.showResult) { () -> Alert in
                Alert(title: Text(String("Aviso").capitalized), message: Text(String("\(viewModel.resultText)").capitalizedFirstLetter), dismissButton: .default(Text(String("Aceptar").capitalized)))
            }
        }.environmentObject(appSettings).alert(isPresented: $showAlertQuestion) { () -> Alert in
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
                body.token = appSettings.payCards[dateIndex].id
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
