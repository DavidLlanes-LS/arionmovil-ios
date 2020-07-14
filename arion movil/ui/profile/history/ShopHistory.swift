//
//  ShopHistory.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ShopHistory: View {
    var body: some View {
        List{
            ShopHistoryRow()
        }.navigationBarTitle("Historial de compras")
    }
}

struct ShopHistory_Previews: PreviewProvider {
    static var previews: some View {
        ShopHistory()
    }
}
