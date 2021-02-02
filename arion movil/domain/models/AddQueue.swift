//
//  AddQueue.swift
//  arion movil
//
//  Created by Daniel Luna on 29/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
import Foundation

public struct AddQueue {
    var userId:String
    var locationId: String
    var playerId: String
    var mediaTitleId: String
    var creditsToCharge: Int
    var positionToAdvance: Int
    
    func getDic() -> [String:Any] {
        return [
            "UserId": userId,
            "LocationId": locationId,
            "PlayerId": playerId,
            "MediaTitleId": mediaTitleId,
            "CreditsToCharge": creditsToCharge,
            "PositionsToAdvance": positionToAdvance
        ]
    }
}
