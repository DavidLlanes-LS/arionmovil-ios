//
//  SongSearcher.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct SongSearcher: View {
    @StateObject var queueViewModel = QueueViewModel()
    @State var searchText:String = ""
    @ObservedObject var viewModel:SongsUriViewModel =  SongsUriViewModel()
    @State var navigateLogin = false
    init(branchId: String){
        viewModel.branchId = branchId
        
    }
    var body: some View {
        VStack{
            NavigationLink(destination: LoginView(), isActive: self.$navigateLogin ) {}
            SearchBar(text: $searchText, placeholder: "Busca una canción")
            List{
                if viewModel.stock.count > 0 {
                    ForEach(viewModel.musicList.filter{$0.name!.lowercased().contains(searchText.lowercased()) || searchText.isEmpty},id: \.self){song in
                        GenereRow(name: song.name!, artist: song.artist!, navigateLogin: $navigateLogin){
                            queueViewModel.addNewQueue(id: song.id!)
                        }
                    }
                }
            }.animation(.default)
        }.navigationBarTitle("Buscador",displayMode: .inline).onAppear{
            viewModel.setDataCD()
        }
    }
    
    
    
}

struct SongSearcher_Previews: PreviewProvider {
    static var previews: some View {
        SongSearcher(branchId: "sd")
    }
}
