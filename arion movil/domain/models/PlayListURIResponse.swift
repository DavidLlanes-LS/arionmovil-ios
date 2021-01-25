//
//  PlayListURIResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 22/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
// MARK: - SongsUriResponse
struct SongsUriResponse:Codable{
    let catalogURI: String
    let generationDate: String
    let resultCode: Int
    
    
    enum CodingKeys: String, CodingKey{
        case catalogURI = "CatalogUri"
        case generationDate="GenerationDate"
        case resultCode="ResultCode"
    }
}
