//
//  AddCardResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 05/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

struct AddCardResultCode:Codable {
    let resultCode: Int
   
    
    enum CodingKeys:String,CodingKey {
        case resultCode = "ResultCode"
    }
}
