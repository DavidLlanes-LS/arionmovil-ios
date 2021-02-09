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
        List{
            ForEach(viewModel.transactionsList,id:\.self){ transaction in
                ShopHistoryRow(transaction: transaction)
            }
           
        }.navigationBarTitle("Historial de compras").onAppear{
            viewModel.getHistory()
        }
    }
}

struct ShopHistory_Previews: PreviewProvider {
    static var previews: some View {
        ShopHistory()
    }
}
