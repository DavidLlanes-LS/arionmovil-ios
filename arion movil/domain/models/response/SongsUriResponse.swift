//
//  PlayListURIResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 22/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import CoreData
// MARK: - SongsUriResponse
struct SongsUriResponse:Codable{
    public var catalogURI: String?
    public var generationDate: String?
    public var resultCode: Int?
    
    
    enum CodingKeys: String, CodingKey{
        case catalogURI = "CatalogUri"
        case generationDate="GenerationDate"
        case resultCode="ResultCode"
    }
    
  
}
