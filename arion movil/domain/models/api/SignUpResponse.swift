//
//  SignUpResponse.swift
//  arion movil
//
//  Created by Daniel Luna on 05/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

class SignUpResponse: Codable {
    let resultCode: Int
    
    enum CodingKeys:String,CodingKey {
        case resultCode = "Result"
    }
}
