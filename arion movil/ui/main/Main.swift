//
//  Main.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI
import CoreData
struct Main: View {
    @State var viewModel:SongsUriViewModel = SongsUriViewModel()
    @State private var showingAlert = true
    @State var isFilterArtist:Bool = false
    @State var isFilterAlbum:Bool = false
    @State var isFilterMusicGenre:Bool = false
    @State var isFilterYear:Bool = false
    @State public var searchText : String = ""
    @State  var isRequested:Bool = false
    @State var musicList:[TitleCD] = []
    @Environment(\.managedObjectContext) public var viewContext
    @FetchRequest(sortDescriptors: [])
    private var songsState: FetchedResults<SongsState>
    @FetchRequest(sortDescriptors: [])
    private var stock: FetchedResults<AlbumStockCD>
    @State var data:[String] = []
    init() {
       
    }
    var body: some View {
        
        GeometryReader {g in 
            NavigationView{
                ScrollView{
                    VStack {
                        ZStack{
                            Color("background")
                            VStack{
                                TextWithCustomFonts("\(stock.count)Buscar una canción", customFont: CustomFont(type: .bold, size: 20))
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
                    
                }.onAppear(perform: {
                    UITableView.appearance().separatorStyle = .none
                    
                }).navigationBarTitle("Bienvenido",displayMode: .inline)
            }.alert(isPresented:$showingAlert, content: {
                Alert(title:Text(String("Atención").capitalized), message: Text(String("Recuerda que no podrás reproducir canciones si la calidad de red es baja").capitalized), primaryButton: .cancel(Text(String("Cancelar").capitalized)),secondaryButton: .default(Text(String("Aceptar").capitalized)))
            }).onAppear{
                //viewModel.getUriReponse()
                if !isRequested {
                   
                    getList()
                }
                self.isRequested = true
                
            }
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
    
    func getList(){
        var titles:[TitleCD] = []
        var playlists = stock.first?.playlists?.allObjects as! [PlaylistCD]
        //var playlist = Array(( stock.first?.playlists as! Set<PlaylistCD>))
        var albums = playlists.first?.albums?.allObjects as! [AlbumCD]
//        var albums2 = albums.sorted{
//           $0.id < $1.id
//       }
        albums.forEach{ album in
            (album.titles?.allObjects as! [TitleCD]).forEach{
                $0.coverImageUri = album.coverImageUri
                titles.append(contentsOf:(album.titles?.allObjects as! [TitleCD]))
            }        }
       // titles = albums.first?.titles?.allObjects as! [TitleCD]

            
        print("pruebas",titles.count)
        musicList = titles
       
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
