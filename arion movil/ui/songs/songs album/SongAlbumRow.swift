//
//  SongAlbumRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SongAlbumRow: View {
    var song:Song
    var body: some View {
        HStack{
            VStack{
                TextWithCustomFonts(song.name, customFont: CustomFont(type: .bold, size: 18)).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
                TextWithCustomFonts(song.artist?.name ?? "No artist", customFont: CustomFont(type: .light, size: 18)).frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
            }
            Spacer()
            IconBtn("capslock"){
                
            }
        }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct SongAlbumRow_Previews: PreviewProvider {
    static var previews: some View {
        SongAlbumRow(song: Song(id: 1, name: "San Blas", album: Album(id: 1, name: "Mana 2020", image: "dualipa")))
    }
}
