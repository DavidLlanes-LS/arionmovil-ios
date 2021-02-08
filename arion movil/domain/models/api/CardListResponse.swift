//
//  CardListResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 05/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

struct CardListResponse:Codable{
    public var cards:[CreditCard]?
   
    
    
    enum CodingKeys: String, CodingKey{
        case cards = "Cards"
    
  
}


}
struct CreditCard:Codable,Hashable{
    public var id: String?
    public var bankName: String?
    public var brand: String?
    public var cardNumber: String?
    public var expirationMonth: String?
    public var expirationYear: String?
    public var holderName: String?
    public var type: String?
    
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case bankName = "BankName"
        case brand  = "Brand"
        case cardNumber = "CardNumber"
        case expirationMonth = "ExpirationMonth"
        case expirationYear = "ExpirationYear"
        case holderName = "HolderName"
        case type = "Type"
    }
    
  
}
