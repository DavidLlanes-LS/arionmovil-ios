//
//  DeleteCodeBody.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 08/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
struct DeleteCardBody{
    public var cardId:String
   
    
    
    func getDic() -> [String:Any] {
        return [
            "CardId": cardId
            
        ]
    }


}
