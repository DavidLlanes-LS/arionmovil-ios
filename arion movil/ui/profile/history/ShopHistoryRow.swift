//
//  ShopHistoryRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ShopHistoryRow: View {
    let dateFormatterIn = DateFormatter()
    let dateFormatterOut = DateFormatter()
   var transaction:Transaction
    init(transaction:Transaction) {
        self.transaction = transaction
        dateFormatterIn.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterIn.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatterIn.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatterOut.dateFormat = "dd/MM/YYYY"
    }
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                TextWithCustomFonts("\(transaction.packageName!)", customFont: CustomFont(type: .bold, size: 16)).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
                TextWithCustomFonts("\(dateFormatterOut.string(from: dateFormatterIn.date(from: transaction.transactionDate!)!))", customFont: CustomFont(type: .light, size: 22)).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
            }
            TextWithCustomFonts("$\(transaction.amount!)",customFont: CustomFont(type: .bold, size: 18), color: Color("secondary-background"))
        }
    }
}

struct ShopHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        ShopHistoryRow(transaction: Transaction())
    }
}
