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
    @State var NavLogin:Bool = false
    @ObservedObject var viewModel:SongsUriViewModel =  SongsUriViewModel()
    init(branchId: String){
        viewModel.branchId = branchId
        viewModel.setDataCD()
    }
    var body: some View {
        VStack(spacing:0){
            NavigationLink(destination: LoginView(), isActive: self.$NavLogin ) {
                
            }
            SearchBar(text: $searchText, placeholder: "Busca un album")
            List{
                ForEach(viewModel.albumListMain.filter({$0.name!.lowercased().contains(searchText.lowercased()) || searchText.isEmpty}), id: \.self) {album in
                    
                    Section(header:  TextWithCustomFonts(album.name!, customFont: CustomFont(type: .bold, size: 16)) .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))){
                        ForEach(viewModel.musicList.filter {$0.mediaAlbumId == album.id} , id: \.self){ title in
                            GenereRow(name: title.name!, artist: title.artist!,navigateLogin: $NavLogin)
                        }
                    }
                    
                }
            }
        }.navigationBarTitle("Albúmes",displayMode: .inline)
    }
    
}

struct AlbumSearcher_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearcher(branchId: "df")
    }
}
