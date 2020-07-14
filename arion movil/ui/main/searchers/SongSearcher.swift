//
//  SongSearcher.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SongSearcher: View {
    @State var searchText:String = ""
    var songs:[Song] = [Song(id: 1, name: "Lost",artist: Artist(id: 1, name: "Frank Ocean"))]
    var body: some View {
        VStack{
            SearchBar(text: $searchText, placeholder: "Busca una canción")
            List(self.songs.filter {
                searchText != "" ? ($0.name.contains(searchText) || ($0.artist != nil ? $0.artist!.name.contains(searchText) : true) ): true
            }){ song in
                SearchSongRow(song: song)
            }
        }.navigationBarTitle("Buscador",displayMode: .inline)
    }
}

struct SongSearcher_Previews: PreviewProvider {
    static var previews: some View {
        SongSearcher()
    }
}
