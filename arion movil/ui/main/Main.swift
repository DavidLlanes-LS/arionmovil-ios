//
//  Main.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Main: View {
    @State private var showingAlert = true
    @State var isFilterArtist:Bool = false
    @State var isFilterAlbum:Bool = false
    @State var isFilterMusicGenre:Bool = false
    @State var isFilterYear:Bool = false
    @State public var searchText : String = ""
    @ObservedObject var viewModel = SongsUriViewModel()
    @State var data:[String] = []
    var body: some View {
        
        GeometryReader {g in 
            NavigationView{
                ScrollView{
                    ZStack{
                        Color("background")
                        VStack{
                            TextWithCustomFonts("Buscar una cación", customFont: CustomFont(type: .bold, size: 20))
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
                            VStack{
                                ForEach(1...3,id:\.self){item in
                                    SongRow()
                                }
                               
                                
                            }
                            Spacer().frame(height:78)
                        }.padding()
                    }
                    
                }.onAppear(perform: {
                    UITableView.appearance().separatorStyle = .none
                    //UITableView.appearance().isScrollEnabled = false
                    
                }).navigationBarTitle("Bienvenido",displayMode: .inline)
            }.onAppear{
                viewModel.getUriReponse()
                data = ["1","2"]
            }.alert(isPresented:$showingAlert, content: {
                Alert(title:Text(String("Atención").capitalized), message: Text(String("Recuerda que no podrás reproducir canciones si la calidad de red es baja").capitalized), primaryButton: .cancel(Text(String("Cancelar").capitalized)),secondaryButton: .default(Text(String("Aceptar").capitalized)))
        })
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
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
