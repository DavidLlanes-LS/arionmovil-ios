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
    var stock: FetchedResults<AlbumStockCD>{fetchRequest.wrappedValue}
    @State var musicList:[TitleCD] = []
    @State var artistListMain:[String] = []
    var fetchRequest: FetchRequest<AlbumStockCD> = FetchRequest<AlbumStockCD>(entity:AlbumStockCD.entity(), sortDescriptors: [], predicate: NSPredicate(format: "restaurantId == %@", ""))
    var artists:[Artist] = [Artist(id: 1, name: "Adele"), Artist(id: 2, name: "Jhon"),Artist(id: 3, name: "Visente Fernandez"), Artist(id: 4, name: "Alejandro Frendandez")]
    @State public var searchText : String = ""
    init(branchId: String){
        fetchRequest = FetchRequest<AlbumStockCD>(entity:AlbumStockCD.entity(), sortDescriptors: [], predicate: NSPredicate(format: "restaurantId == %@", branchId))
       
    }
    var body: some View {
        VStack(spacing:0){
            SearchBar(text: $searchText, placeholder: "Busca un restaurante")
            List{
                ForEach(self.letters.filter {self.searchForCharactersInArtists($0) }, id: \.self) {char in
                    Section(header: Text(String(char))){
                        ForEach(self.artistListMain.filter {$0.first! == char && ($0.lowercased().contains(searchText.lowercased()) || searchText.isEmpty)} , id: \.self){ artist in
                            NavigationLink(destination:SongsAlbum()){
                                Text("\(artist)").onAppear{print("searchedText",artistListMain)}
                            }
                        }
                        
                    }.onAppear{
                        
                    }
                    
                }
            }.animation(.default)
            //Spacer().frame(height:78)
        }.navigationBarTitle("Artistas",displayMode: .inline).onAppear{
            getArtists()
        }
    }
    
    func searchForCharactersInArtists(_ character:Character) -> Bool {
        for artist in artistListMain {
            if artist.first?.lowercased() == character.lowercased() {
               
                        return true
                    }
          
        }
        return false
    }
    func getArtists(){
        if self.stock.count>0{
            var titles:[TitleCD] = []
            let playlists = stock.first?.playlists?.allObjects as! [PlaylistCD]
            let albums = playlists.first?.albums?.allObjects as! [AlbumCD]
            albums.forEach{ album in
                (album.titles?.allObjects as! [TitleCD]).forEach{
                    $0.coverImageUri = album.coverImageUri
                    titles.append(contentsOf:(album.titles?.allObjects as! [TitleCD]))
                }        }
            
            
            print("pruebas",titles.count)
         
            
            titles.forEach{title in
                title.coverImageUri = title.coverImageUri! as String
            }
            
            titles = Array(Set(titles))
            musicList = titles
            musicList.sort{
                $0.name!<$1.name!
            }
            let sections = Set(musicList.map{ $0.artist!})
            artistListMain = Array(sections)
            artistListMain.sort{
                $0<$1
            }
            print("sections",sections)
        }
        
    }
}

struct ArtistSearcher_Previews: PreviewProvider {
    static var previews: some View {
        ArtistSearcher(branchId: "sds")
    }
}
