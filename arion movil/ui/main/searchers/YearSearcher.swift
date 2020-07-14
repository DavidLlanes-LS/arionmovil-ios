//
//  YearSearcher.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 13/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct YearSearcher: View {
    var headers: [String] = ["2010 -2019", "2000 - 2009"]
    var artists:[Artist] = [Artist(id: 1, name: "Adele"), Artist(id: 2, name: "Jhon"),Artist(id: 3, name: "Visente Fernandez"), Artist(id: 4, name: "Alejandro Frendandez")]
    @State public var searchText : String = ""
    var body: some View {
        VStack(spacing:0){
            SearchBar(text: $searchText, placeholder: "Busca una cancion")
            List{
                ForEach(self.headers, id: \.self) {char in
                    Section(header: Text(char)){
                        ForEach(self.artists.filter {$0.name.contains(char)} , id: \.id){ artist in
                            NavigationLink(destination:SongsAlbum()){
                                Text("\(artist.name)")
                            }
                        }
                    }
                    
                }
            }
        }.navigationBarTitle("Año",displayMode: .inline)
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

struct YearSearcher_Previews: PreviewProvider {
    static var previews: some View {
        YearSearcher()
    }
}
