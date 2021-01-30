//
//  SearchSongRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SearchSongRow: View {
    var song:Song
    var body: some View {
        HStack{
            TextWithCustomFonts("\(self.song.name) - \(self.song.artist?.name ?? "Sin artista")", color: Color("light-gray"))
        }
    }
}

struct SearchSongRow_Previews: PreviewProvider {
    static var previews: some View {
        
        SearchSongRow(song: Song(id: 1, name: "Lost",artist: Artist(id: 1, name: "Frank Ocean")))
    }
}
