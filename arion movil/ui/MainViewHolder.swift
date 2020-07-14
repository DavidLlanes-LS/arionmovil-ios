//
//  MainViewHolder.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct MainViewHolder: View {
    @State var isShowingMain:Bool = false
    var body: some View {
        Group{
            if(isShowingMain){
                MainTabBar()
            }else{
                BranchesNav(){
                    self.showMain()
                }
            }
        }
    }
    
    func showMain() {
        self.isShowingMain.toggle()
    }
}

struct MainViewHolder_Previews: PreviewProvider {
    static var previews: some View {
        MainViewHolder()
    }
}
