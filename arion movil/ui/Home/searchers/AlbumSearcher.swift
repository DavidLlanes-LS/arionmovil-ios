//
//  AlbumSearcher.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct AlbumSearcher: View {
    @StateObject var queueViewModel = QueueViewModel()
    var letters: [Character] = (0..<26).map {
        i in Character(UnicodeScalar("A".unicodeScalars[ "A".unicodeScalars.startIndex].value + i)!)
    }
    @EnvironmentObject var appSettings: AppHelper
    @StateObject var storeViewModel = StoreViewModel()
    @State public var searchText : String = ""
    @State var NavLogin:Bool = false
    @State var conteo = 1
    @State var albumListMain:[AlbumCD] = []
    @State var onceLoad:Bool  = false
    @ObservedObject var viewModel:SongsUriViewModel =  SongsUriViewModel()
    init(branchId: String){
        viewModel.branchId = branchId
    }
    var body: some View {
        ZStack{VStack(spacing:0){
            NavigationLink(destination: LoginView(), isActive: self.$NavLogin ) {}
            SearchBar(text: $searchText, placeholder: "Busca un álbum")
            if albumListMain.count <= 0 {
                if !onceLoad{
                    VStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            
            List{
                ForEach(albumListMain.filter({$0.name!.lowercased().contains(searchText.lowercased()) || searchText.isEmpty}), id: \.self) {album in
                    Section(header:  TextWithCustomFonts(album.name!, customFont: CustomFont(type: .bold, size: Constants.sizeTextBody), font: .caption) .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))){
                        ForEach((album.titles?.allObjects as! [TitleCD]),id:\.self){ title in
                            GenereRow(name: title.name!, artist: title.artist!,navigateLogin: $NavLogin){
                                queueViewModel.addNewQueue(id: title.id!)
                            }
                            
                        }
                    }.listRowBackground(Color("background"))
                    
                    
                    
                }
            }.id(UUID()).onAppear{
                onceLoad = true
            }
            
            
        }.navigationBarTitle(String("Àlbumes"),displayMode: .inline).onAppear{
            viewModel.appSettings = self.appSettings
            viewModel.setDataCD {
                self.albumListMain = viewModel.albumListMain
            }
        }.onAppear{
            queueViewModel.appSettings = appSettings
        }
        
        
        
        
        }
        
    }
    
}

struct AlbumSearcher_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearcher(branchId: "df")
    }
}
