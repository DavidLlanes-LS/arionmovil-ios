//
//  BuyCreditsBody.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 08/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

public struct BuyCreditsBody {
    var locationId: String?
    var packageId: String?
    var requestInvoice: Bool?
    var token: String?
    var deviceSessioniD: String?
    
    func getDic() -> [String:Any] {
        return [
            "LocationId": locationId,
            "PackageId": packageId,
            "RequestInvoice": requestInvoice,
            "Token": token,
            "DeviceSessionId": deviceSessioniD
        ]
    }
}
