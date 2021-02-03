//
//  SignInResponse.swift
//  arion movil
//
//  Created by Daniel Luna on 02/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

class SignInResponse: Codable {
    let userId: String
    let userName: String
    let status: Int
    
    enum CodingKeys:String,CodingKey {
        case userId = "UserId"
        case userName = "UserName"
        case status = "Status"
    }
}
