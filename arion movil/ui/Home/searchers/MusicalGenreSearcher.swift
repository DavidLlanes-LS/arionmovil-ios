//
//  MusicalGenre.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct MusicalGenreSearcher: View {
    @State var musicList:[TitleCD] = []
    @State var genereList:[String] = []
    var fetchRequest: FetchRequest<AlbumStockCD> = FetchRequest<AlbumStockCD>(entity:AlbumStockCD.entity(), sortDescriptors: [], predicate: NSPredicate(format: "restaurantId == %@", ""))
    var stock: FetchedResults<AlbumStockCD>{fetchRequest.wrappedValue}
    init(branchId: String){
        fetchRequest = FetchRequest<AlbumStockCD>(entity:AlbumStockCD.entity(), sortDescriptors: [], predicate: NSPredicate(format: "restaurantId == %@", branchId))
       
    }
    var musicalGenres:[MusicalGenre] = [MusicalGenre(id:1,name:"Rock")]
    @State public var searchText : String = ""
    var body: some View {
        VStack(spacing:0){
            SearchBar(text: $searchText, placeholder: "Busca un album")
            List{
                ForEach(self.genereList.filter{$0.lowercased().contains(searchText) || searchText.isEmpty},id:\.self){ genere in
                    Section(header: TextWithCustomFonts(genere, customFont: CustomFont(type: .bold, size: 16)) .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))) {
                        ForEach(self.musicList.filter{$0.genere! == genere},id:\.self){title in
                            
                            
                                VStack(alignment:.leading){
                                    TextWithCustomFonts(title.name!, customFont: CustomFont(type: .bold, size: 15))
                                    TextWithCustomFonts(title.artist!, customFont: CustomFont(type: .light, size: 14))
                                
                                
                            }
                                
                        
                            
                            
                        }
                    }
                    
                }
            }.animation(.default)
            Spacer().frame(height:78)
            
        }.navigationBarTitle("Género",displayMode: .inline).onAppear{
            getGeneres()
        }
    }
    
    func searchForCharactersInArtists(_ character:Character) -> Bool {
        for musicalGenre in musicalGenres {
            if musicalGenre.name.first == character {
                return true
            }
        }
        return false
    }
    func getGeneres(){
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
            let sections = Set(musicList.map{ $0.genere!})
            genereList = Array(sections)
            genereList.sort{
                $0<$1
            }
            print("sections",sections)
        }
        
    }
}


struct MusicalGenreSearcher_Previews: PreviewProvider {
    static var previews: some View {
        MusicalGenreSearcher(branchId: "fs")
    }
}
