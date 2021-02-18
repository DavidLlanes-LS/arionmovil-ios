//
//  UserCreditsResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 08/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

struct UserCreditsResponse:Codable {
    let creditsBalance: Int
   
    
    enum CodingKeys:String,CodingKey {
        case creditsBalance = "CreditsBalance"
    }
}
