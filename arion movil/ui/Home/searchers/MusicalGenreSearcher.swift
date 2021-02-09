//
//  MusicalGenre.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct MusicalGenreSearcher: View {
    @StateObject var queueViewModel = QueueViewModel()
    @ObservedObject var viewModel:SongsUriViewModel =  SongsUriViewModel()
    @StateObject var storeViewModel = StoreViewModel()
    @State var NavLogin:Bool = false
    init(branchId: String){
        
        viewModel.branchId = branchId
        
    }
    var musicalGenres:[MusicalGenre] = [MusicalGenre(id:1,name:"Rock")]
    @State public var searchText : String = ""
    var body: some View {
        VStack(spacing:0){
            NavigationLink(destination: LoginView(), isActive: self.$NavLogin ) {}
            SearchBar(text: $searchText, placeholder: "Busca un género")
            List{
                ForEach(viewModel.genereList.filter{$0.lowercased().contains(searchText) || searchText.isEmpty},id:\.self){ genere in
                    Section(header: TextWithCustomFonts(genere, customFont: CustomFont(type: .bold, size: 16)) .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))) {
                        ForEach(viewModel.musicList.filter{$0.genere! == genere},id:\.self){title in
                            GenereRow(name: title.name!, artist: title.artist!,navigateLogin: $NavLogin){
                                queueViewModel.addNewQueue(id: title.id!)
                            }
                        }
                    }
                    
                }
            }.animation(.default)
            // Spacer().frame(height:78)
        }.navigationBarTitle("Género",displayMode: .inline).onAppear{
            viewModel.setDataCD()
        }
    }
    
    
}


struct MusicalGenreSearcher_Previews: PreviewProvider {
    static var previews: some View {
        MusicalGenreSearcher(branchId: "fs")
    }
}
