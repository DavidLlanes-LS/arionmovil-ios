//
//  BranchesNav.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct BranchesNav: View {
    public var showMainView:()->()
    var body: some View {
        NavigationView{
            BranchesList(showMainView: self.showMainView)
        }
    }
}

struct BranchesNav_Previews: PreviewProvider {
    static var previews: some View {
        BranchesNav(){
            
        }
    }
}
