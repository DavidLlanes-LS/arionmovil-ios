//
//  BranchResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct LocationsList:Codable {
    let locations: [Location]
    
   
    enum CodingKeys: String, CodingKey{
        case locations = "Locations"
    }
    
    
}

// MARK: - Location

struct Location:Codable,Identifiable {
    let id:String
    let playerID:String
    let name:String
    let locationDescription: String
    let addressLine, spatialLocation: String
    let logoImage: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case playerID="PlayerId"
        case name="Name"
        case locationDescription="Description"
        case addressLine = "AddressLine"
        case spatialLocation="SpatialLocation"
        case logoImage="LogoImage"
        
        
    }
}
