//
//  SongItem.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SongItem: View {
    var hasCorners:Bool = true
    var body: some View {
        VStack(spacing:0) {
            Image("dualipa").resizable().aspectRatio(contentMode: .fill).cornerRadius(hasCorners ? 3:0)
            if(hasCorners){
                VStack {
                    
                    Text("Dua Lipa").frame(maxWidth:.infinity,alignment: .leading).padding(.leading,0)
                    Text("Canción").frame(maxWidth:.infinity,alignment: .leading).padding(.leading,0)
                    Spacer().frame(height:6)
                    
                }.frame(maxWidth:.infinity).background(Color("background"))
            }
            
           
        }
        
    }
}

struct SongItem_Previews: PreviewProvider {
    static var previews: some View {
        SongItem()
    }
}
