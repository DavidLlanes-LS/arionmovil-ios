//
//  BranchesNav.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct BranchesNav: View {
   
    @StateObject var viewModel = CardViewModel()
    @StateObject var storeViewModel = StoreViewModel()
    @EnvironmentObject var pageSettings: AppHelper;
   
    
    var body: some View {
        if pageSettings.currentPage == "splash" {
            BranchesList()
        }
        else{
            MainTabBar().onAppear{
                viewModel.appSettings = self.pageSettings
                viewModel.getCreditList()
                storeViewModel.appSettings = self.pageSettings
                storeViewModel.getCreditsUser()
            }
            
        }
    }


   
}

struct BranchesNav_Previews: PreviewProvider {
    static var previews: some View {
        BranchesNav()
        .preferredColorScheme(.dark)
    }
}
