//
//  ContriesResponse.swift
//  arion movil
//
//  Created by Daniel Luna on 05/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

struct CountriesResponse:Codable {
    let countries: [Country]
    
    enum CodingKeys:String,CodingKey {
        case countries = "Countries"
    }
}

struct Country:Codable,Identifiable{
    let id:String
    let name:String
    
    enum CodingKeys:String,CodingKey{
        case id = "Id"
        case name = "Name"
    }
}
