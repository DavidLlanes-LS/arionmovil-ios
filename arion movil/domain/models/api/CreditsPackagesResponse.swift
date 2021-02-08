//
//  CreditsPackagesResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 08/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
struct CreditPackagesResponse:Codable{
    public var packages:[Packages]?
   
    
    
    enum CodingKeys: String, CodingKey{
        case packages = "Packages"
    
  
}


}
struct Packages:Codable,Hashable{
    public var id: String?
    public var name: String?
    public var amount: Int?
    public var price: Float?
    
    
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case name = "Name"
        case amount = "Amount"
        case price = "Price"
      
    }
    
  
}
