//
//  MusicalGenre.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct MusicalGenreSearcher: View {
    var letters: [Character] = (0..<26).map {
        i in Character(UnicodeScalar("A".unicodeScalars[ "A".unicodeScalars.startIndex].value + i)!)
    }
    var musicalGenres:[MusicalGenre] = [MusicalGenre(id:1,name:"Rock")]
    @State public var searchText : String = ""
    var body: some View {
        VStack(spacing:0){
            SearchBar(text: $searchText, placeholder: "Busca un album")
            List{
                ForEach(self.letters.filter {self.searchForCharactersInArtists($0)}, id: \.self) {char in
                    Section(header: Text(String(char))){
                        ForEach(self.musicalGenres.filter {$0.name.first! == char} , id: \.id){ musicalGenre in
                            Text("\(musicalGenre.name)")
                        }
                    }
                    
                }
            }
        }.navigationBarTitle("Generos",displayMode: .inline)
    }
    
    func searchForCharactersInArtists(_ character:Character) -> Bool {
        for musicalGenre in musicalGenres {
            if musicalGenre.name.first == character {
                return true
            }
        }
        return false
    }
}

struct MusicalGenreSearcher_Previews: PreviewProvider {
    static var previews: some View {
        MusicalGenreSearcher()
    }
}
