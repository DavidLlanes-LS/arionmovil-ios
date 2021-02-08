//
//  FilterGrid.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct FilterGrid: View {
    var openFilter:(_ id:Int) ->()
    var body: some View {
        VStack{
            HStack(spacing:16){
                FilterButton(text: "Artistas"){
                    self.openFilter(1)
                }
                FilterButton(text: "Álbumes"){
                    self.openFilter(2)
                    
                }
            }.padding([.bottom],16)
            HStack(spacing:16){
                FilterButton(text: "Género"){
                    self.openFilter(3)
                }
                FilterButton(text: "Año"){
                    self.openFilter(4)
                }
            }
        }.frame(minWidth:0,maxWidth: .infinity,alignment: .center).onAppear{
            
        }
    }
}
