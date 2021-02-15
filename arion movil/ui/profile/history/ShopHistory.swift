//
//  ShopHistory.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ShopHistory: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack{
        VStack{
            List{
                ForEach(viewModel.transactionsList,id:\.self){ transaction in
                    ShopHistoryRow(transaction: transaction).listRowBackground(Color("background"))
                }
               
            }
           
            
        }.navigationBarTitle("Historial de compras").onAppear{
            viewModel.getHistory()
        }.frame(maxWidth:.infinity,maxHeight: .infinity).background(Color("background"))
            if viewModel.isLoading{
                VStack{
                Spacer()
                ProgressView()
                Spacer()
                }
            }
            else{
            if viewModel.transactionsList.count <= 0{
                VStack{
                Spacer()
                    TextWithCustomFonts("No tienes compras realizadas aún",customFont: CustomFont(type: .bold, size: 16),color: Color("title")).frame(minWidth:0, maxWidth: .infinity, alignment: .center)
              
                Spacer()
                }
            }
            }
    }
    }
}

struct ShopHistory_Previews: PreviewProvider {
    static var previews: some View {
        ShopHistory()
    }
}
