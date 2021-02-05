//
//  CreditCards.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct CreditCards: View {
    @StateObject var viewModel = CardViewModel()
    
    @State var navigationToLogin: Bool = false
    @State var navigationToCreateCard: Bool = false
    @State var showAlert: Bool = false
    var body: some View {
        VStack(){
            NavigationLink(destination: LoginView(), isActive: self.$navigationToLogin) {
            }
            NavigationLink(destination: CreateNewCreditCard(), isActive: self.$navigationToCreateCard) {
            }
            if viewModel.showLoader {
                Spacer()
                LoaderComponent()
                Spacer()
            }
            else{
                if viewModel.creditCards.count != 0 && viewModel.creditCards != nil {
                    HStack {
                        List{
                            ForEach(viewModel.creditCards, id:\.self){credit in
                                HStack {
                                    CreditCardRow(card: credit)
                                    Spacer()
                                }
                            }.listStyle(PlainListStyle())

                        }


                    }
                }
                else{
                    Spacer()
                    TextWithCustomFonts("No cuentas con tarjetas registradas",customFont: CustomFont(type: .bold, size: 16),color: Color("title-row")).frame(minWidth:0, maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
               
            }
          
            
                Button(action:{
                    var isAuth = UserDefaults.standard.bool(forKey: Constants.keyIsAuth)
                    if isAuth {
                        navigationToCreateCard = true
                    }
                    else{
                        showAlert = true
                    }
                    
                }) {
                    RedRectangleText("Añadir método de pago").frame(width: 250, height: 40, alignment: .center)
                }
            
           
        }.padding().background(Color("background")).navigationBarTitle("Método de pago").onAppear{
            viewModel.getCreditList()
            //viewModel.getCreditCards()
        }.alert(isPresented: $showAlert, content: {
            Alert(
                title:Text(String("Inicia sesión para continuar")),
                message: Text(String("Iniciar sesión o crear una cuenta para poder realizar esta acción.")),
                primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                secondaryButton: .default(Text(String("Aceptar").capitalized)) {
                    navigationToLogin = true
                }
            )
        })
    }
}

struct CreditCards_Previews: PreviewProvider {
    static var previews: some View {
        CreditCards()
    }
}
