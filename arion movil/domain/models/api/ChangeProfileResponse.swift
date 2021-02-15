//
//  ChangeProfileResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 12/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

struct ChangeProfileResponse:Codable {
    let result: Int
   
    
    enum CodingKeys:String,CodingKey {
        case result = "Result"
    }
}
