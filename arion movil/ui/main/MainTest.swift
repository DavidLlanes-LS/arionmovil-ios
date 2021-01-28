//
//  MainTest.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 26/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct MainTest: View {
    @ObservedObject var viewModel2:algoViewModel = algoViewModel()
    //@ObservedObject var viewModel:SongsUriViewModel = SongsUriViewModel()
    @State private var showingAlert = true
    @State var isFilterArtist:Bool = false
    @State var isFilterAlbum:Bool = false
    @State var isFilterMusicGenre:Bool = false
    @State var isFilterYear:Bool = false
    @State public var searchText : String = ""
   
    @Environment(\.managedObjectContext) public var viewContext
    @FetchRequest(sortDescriptors: [])
    private var songsState: FetchedResults<SongsState>
  
    init(){
        
    }
   
    var body: some View {
        
        NavigationView {
        
             
                    VStack{
                        VStack {
                            ZStack{
                                Color("background")
                                VStack{
                                    TextWithCustomFonts("Buscar una canción", customFont: CustomFont(type: .bold, size: 20))
                                        .frame(minWidth:0, maxWidth: .infinity,alignment: .leading)
                                    ZStack {
                                        //SearchBarFilter().buttonStyle(PlainButtonStyle())
                                        SearchBar(text: $searchText, placeholder: "Canción, artista, albúm")
                                        NavigationLink(destination: SongSearcher()) {
                                            EmptyView()
                                        }
                                    }.padding(.bottom)
                                    ZStack {
                                        FilterGrid(openFilter: self.openFilter(id:))
                                    }.padding(.bottom)
                                    NavigationLink(destination: ArtistSearcher(),isActive: $isFilterArtist) {
                                        EmptyView()
                                    }
                                    NavigationLink(destination: AlbumSearcher(),isActive: $isFilterAlbum) {
                                        EmptyView()
                                    }
                                    NavigationLink(destination: MusicalGenreSearcher(),isActive: $isFilterMusicGenre) {
                                        EmptyView()
                                    }
                                    
                                    NavigationLink(destination: YearSearcher(),isActive: $isFilterYear) {
                                        EmptyView()
                                    }
                                    
                                    HStack{
                                        
                                        
                                        TextWithCustomFonts("Canciones disponibles",customFont: CustomFont(type: .bold, size: 20)).frame(minWidth:0, maxWidth: .infinity,alignment: .leading)
                                        SimpleunderlineBtn("Ver todo"){
                                            
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                    VStack(spacing:10){
                                        ForEach(1...3,id:\.self){item in
                                            SongRow()
                                        }
                                        
                                        
                                    }
                                   Spacer().frame(height:78)
                                    
                                    
                                }.padding()
                            }
                        }
                        GridViewSong(items:15).listStyle(PlainListStyle())
                    }.navigationBarTitle("Bienvenido",displayMode: .inline)
                
            
        }
        
    }
    func openFilter(id:Int) {
        switch id {
        case 1:
            self.isFilterArtist = true
        case 2:
            self.isFilterAlbum = true
        case 3:
            self.isFilterMusicGenre = true
        case 4:
            self.isFilterYear = true

        default:
            self.isFilterArtist = true
        }
    }
    
    func getData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            viewModel2.songsState.append(contentsOf: songsState)
            viewModel2.viewContext = viewContext
            viewModel2.getUriReponse()
            
        }
   
    }
}

struct MainTest_Previews: PreviewProvider {
    static var previews: some View {
        MainTest()
    }
}
