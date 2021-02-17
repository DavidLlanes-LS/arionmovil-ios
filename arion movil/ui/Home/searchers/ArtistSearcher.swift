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
    @ObservedObject var viewModel:SongsUriViewModel =  SongsUriViewModel()
    @State public var searchText : String = ""
   
    init(branchId: String){
        viewModel.branchId = branchId
     
        
    }
    var body: some View {
        VStack(spacing:0){
            
            SearchBar(text: $searchText, placeholder: "Busca un artista")
            List{
                ForEach(self.letters.filter {self.searchForCharactersInArtists($0) }, id: \.self) {char in
                    Section(header: TextWithCustomFonts(String(char), customFont: CustomFont(type: .semibold, size: Constants.sizeTextBody), font: .caption) .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))){
                        ForEach(viewModel.artistListMain.filter {$0.first! == char && ($0.lowercased().contains(searchText.lowercased()) || searchText.isEmpty)} , id: \.self){ artist in
                            NavigationLink(destination:SongsAlbum(musicList:viewModel.musicList.filter{$0.artist == artist})){
                                TextWithCustomFonts(artist, customFont: CustomFont(type: .semibold, size: Constants.sizeTextBody), font: .body)
                                    .onAppear{
                                        print("searchedText", viewModel.artistListMain)
                                    }
                            }
                        }
                        
                    }.listRowBackground(Color("background"))
                    
                }
                
                
            }
        }.navigationBarTitle(String("Artistas"),displayMode: .inline).onAppear{
            viewModel.setDataCD()
        }
    }
    
    func searchForCharactersInArtists(_ character:Character) -> Bool {
        var show = false
        for artist in viewModel.artistListMain {
            if artist.first?.lowercased() == character.lowercased() {
                if searchText.isEmpty{
                    show = true
                }
                else{
                    if searchText.first?.lowercased() == character.lowercased(){
                        show = true
                    }
                    else{
                        show = false
                    }
                }
            }
        }
        return show
    }
}

struct ArtistSearcher_Previews: PreviewProvider {
    static var previews: some View {
        ArtistSearcher(branchId: "sds")
    }
}
