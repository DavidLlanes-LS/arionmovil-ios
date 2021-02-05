//
//  BranchesNav.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct BranchesNav: View {
   
  
    @EnvironmentObject var pageSettings: AppHelper;
    
    var body: some View {
        if pageSettings.currentPage == "splash" {
            BranchesList()
        }
        else{
            MainTabBar()
            
        }
    }


   
}

struct BranchesNav_Previews: PreviewProvider {
    static var previews: some View {
        BranchesNav()
        .preferredColorScheme(.dark)
    }
}
