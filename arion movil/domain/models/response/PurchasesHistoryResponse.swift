//
//  PurchasesHistoryResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 09/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
struct PurchasesHistoryResponse:Codable{
    public var transactions:[Transaction]?
   
    
    
    enum CodingKeys: String, CodingKey{
        case transactions = "Transactions"
    
  
}


}
struct Transaction:Codable,Hashable{
    public var packageName: String?
    public var amount: Int?
    public var cost: Float?
    public var transactionDate: String?
    
    
//    init(){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        self.date = dateFormatter.date(from:self.transactionDate!)!
//    }
    
    enum CodingKeys: String, CodingKey{
        case packageName = "PackageName"
        case amount = "Amount"
        case cost = "Cost"
        case transactionDate = "TransactionDate"
       
    }
    
  
}
