//
//  SongsAlbum.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SongsAlbum: View {
    var songs:[Song] = [Song(id: 1, name: "Lost",artist: Artist(id: 1, name: "Frank Ocean"))]
    var body: some View {
        VStack{
            Image("dualipa").resizable().aspectRatio(contentMode: .fill).frame(minWidth:0, maxWidth: .infinity).frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            List(self.songs){ song in
                SongAlbumRow(song: song)
            }
        }
    }
}

struct SongsAlbum_Previews: PreviewProvider {
    static var previews: some View {
        SongsAlbum()
    }
}
