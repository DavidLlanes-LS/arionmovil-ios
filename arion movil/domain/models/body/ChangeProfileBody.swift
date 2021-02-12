//
//  ChangeProfileBody.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 12/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
public struct ChangeProfileBody{
    var options: String?
    var newEmail: String?
    var currentPassword: String?
    var newPassword: String?
   
    
    func getDic() -> [String:Any] {
        return [
            "Options": options,
            "NewEmail": newEmail,
            "CurrentPassword": currentPassword,
            "NewPasssword": newPassword,
            
        ]
    }
}
