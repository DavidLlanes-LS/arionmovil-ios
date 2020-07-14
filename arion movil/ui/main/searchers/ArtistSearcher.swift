//
//  ArtistSearcher.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ArtistSearcher: View {
    var letters: [Character] = (0..<26).map {
        i in Character(UnicodeScalar("A".unicodeScalars[ "A".unicodeScalars.startIndex].value + i)!)
    }
    var artists:[Artist] = [Artist(id: 1, name: "Adele"), Artist(id: 2, name: "Jhon"),Artist(id: 3, name: "Visente Fernandez"), Artist(id: 4, name: "Alejandro Frendandez")]
    @State public var searchText : String = ""
    var body: some View {
        VStack(spacing:0){
            SearchBar(text: $searchText, placeholder: "Busca un restaurante")
            List{
                ForEach(self.letters.filter {self.searchForCharactersInArtists($0)}, id: \.self) {char in
                    Section(header: Text(String(char))){
                        ForEach(self.artists.filter {$0.name.first! == char} , id: \.id){ artist in
                            NavigationLink(destination:SongsAlbum()){
                                Text("\(artist.name)")
                            }
                        }
                    }
                    
                }
            }
        }.navigationBarTitle("Artistas",displayMode: .inline)
    }
    
    func searchForCharactersInArtists(_ character:Character) -> Bool {
        for artist in artists {
            if artist.name.first == character {
                return true
            }
        }
        return false
    }
}

struct ArtistSearcher_Previews: PreviewProvider {
    static var previews: some View {
        ArtistSearcher()
    }
}
