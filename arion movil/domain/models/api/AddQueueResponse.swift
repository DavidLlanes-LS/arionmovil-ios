//
//  AddQueueResponse.swift
//  arion movil
//
//  Created by Daniel Luna on 29/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
import Foundation

struct ModifyQueueResultCode:Codable {
    let resultCode: Int
    let authMessage: String?
    
    enum CodingKeys:String,CodingKey {
        case resultCode = "ResultCode"
        case authMessage = "AuthMessage"
    }
}
