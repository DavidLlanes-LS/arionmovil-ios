//
//  BranchPriceResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 04/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Foundation
struct BranchPriceResponse:Codable {
    let basePrice:Int


    enum CodingKeys: String, CodingKey{
        case basePrice = "BasePrice"
    }


}
