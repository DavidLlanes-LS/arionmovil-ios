//
//  AddCardBody.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 05/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
//
import Foundation

public struct AddCardBody {
    var cardToken:String
    var deviceSessionId: String
    
    
    func getDic() -> [String:Any] {
        return [
            "CardToken": cardToken,
            "DeviceSessionid": deviceSessionId
            
        ]
    }
}
