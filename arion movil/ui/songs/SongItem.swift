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
            Image("dualipa").resizable().aspectRatio(contentMode: .fill).cornerRadius(hasCorners ? 0:0)
            if(hasCorners){
                VStack {
                    
                    TextWithCustomFonts("Dua lipa", customFont: CustomFont(type: .bold, size: 14)).frame(maxWidth:.infinity,alignment: .leading).padding(.leading,2)
                    TextWithCustomFonts("Canción", customFont: CustomFont(type: .bold, size: 14)).frame(maxWidth:.infinity,alignment: .leading).padding(.leading,2)
                    Spacer().frame(height:2)
                    
                }.frame(maxWidth:.infinity).background(Color.gray)
            }
            
           
        }
        
    }
}

struct SongItem_Previews: PreviewProvider {
    static var previews: some View {
        SongItem()
    }
}
