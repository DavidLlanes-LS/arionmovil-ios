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
}
