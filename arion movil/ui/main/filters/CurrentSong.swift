//
//  CurrentSong.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct CurrentSong: View {
    @State var progressValue: Float = 0.0
    var song:TitleCD = TitleCD()
    @State var navigateLogin = false
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                SongItem(song:song,navigateLogin: $navigateLogin,hasCorners: false)
                    .frame(width:75, height:75)
                VStack{
                    TextWithCustomFonts("Reproducción actual",customFont:CustomFont(type: .light, size: 14) ,color: Color("title")).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
                    TextWithCustomFonts("Blinding Lights",customFont: CustomFont(type: .bold, size: 16),color: Color("secondary-background")).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
                    TextWithCustomFonts("The weekend",color: Color("secondary-background")).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
                }.frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
            }.frame(height:75)
            ProgressBar(average: 70)
        }
        .background(Color("background"))
        .frame(height:80)
        .clipped()
        .shadow(radius: 2,x:0, y:-2)
    }
}

struct CurrentSong_Previews: PreviewProvider {
    static var previews: some View {
        CurrentSong()
    }
}
