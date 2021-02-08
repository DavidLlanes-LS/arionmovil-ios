//
//  shoppingtest.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
class AppHelper: ObservableObject {
    @Published var currentPage: String = "splash"
    @Published var currentBranchId: String = ""
    @Published var locationId: String? = nil
    @Published var userId: String? = nil
    @Published var playerId: String? = nil
    @Published var showCurrentSong: Bool = true
    @Published var payCards:[CreditCard] = []
    @Published var userCredits:Int = 0
}
