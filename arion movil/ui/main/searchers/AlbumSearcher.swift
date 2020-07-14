//
//  AlbumSearcher.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct AlbumSearcher: View {
    var letters: [Character] = (0..<26).map {
        i in Character(UnicodeScalar("A".unicodeScalars[ "A".unicodeScalars.startIndex].value + i)!)
    }
    var albums:[Album] = [Album(id: 1, name: "De jira con dualipa", image: "dualipa")]
    @State public var searchText : String = ""
    var body: some View {
        VStack(spacing:0){
            SearchBar(text: $searchText, placeholder: "Busca un album")
            List{
                ForEach(self.letters.filter {self.searchForCharactersInArtists($0)}, id: \.self) {char in
                    Section(header: Text(String(char))){
                        ForEach(self.albums.filter {$0.name.first! == char} , id: \.id){ album in
                            Text("\(album.name)")
                        }
                    }
                    
                }
            }
        }.navigationBarTitle("Albúmes",displayMode: .inline)
    }
    
    func searchForCharactersInArtists(_ character:Character) -> Bool {
        for album in albums {
            if album.name.first == character {
                return true
            }
        }
        return false
    }
}

struct AlbumSearcher_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearcher()
    }
}
