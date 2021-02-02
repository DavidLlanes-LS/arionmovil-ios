//
//  Main.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI
import CoreData
struct Home: View {
    var fetchRequest: FetchRequest<AlbumStockCD> = FetchRequest<AlbumStockCD>(entity:AlbumStockCD.entity(), sortDescriptors: [], predicate: NSPredicate(format: "restaurantId == %@", ""))
    @State private var showLinkTarget = false
    @Environment(\.managedObjectContext) public var viewContext
    @EnvironmentObject var appSettings:AppHelper
    @FetchRequest(sortDescriptors: [])
    private var songsState: FetchedResults<SongsState>
    private var stock: FetchedResults<AlbumStockCD>{fetchRequest.wrappedValue}
    @ObservedObject var viewModel:SongsUriViewModel = SongsUriViewModel()
    @State var musicList:[TitleCD] = []
    @State private var showingAlert = true
    @State var isFilterArtist:Bool = false
    @State var isFilterAlbum:Bool = false
    @State var isFilterMusicGenre:Bool = false
    @State var isFilterYear:Bool = false
    @State var hasFetsched:Bool = false
    @State public var searchText : String = ""
    @State var count:Int = 9
    @State var rows:Int = 0
    @State var isImpar = false
    init(branchId: String){
        fetchRequest = FetchRequest<AlbumStockCD>(entity:AlbumStockCD.entity(), sortDescriptors: [], predicate: NSPredicate(format: "restaurantId == %@", branchId))
        
    }
    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink(destination: MusicalGenreSearcher(branchId: appSettings.currentBranchId), isActive: self.$isFilterMusicGenre ) {
                   Spacer().fixedSize()
                }
                NavigationLink(destination:YearSearcher(), isActive: self.$isFilterYear ) {
                   Spacer().fixedSize()
                }
                NavigationLink(destination: AlbumSearcher(), isActive: self.$isFilterAlbum ) {
                   Spacer().fixedSize()
                }
                NavigationLink(destination: ArtistSearcher(branchId: appSettings.currentBranchId), isActive: self.$isFilterArtist ) {
                   Spacer().fixedSize()
                }
                List{
                    VStack{
                        TextWithCustomFonts("Buscar una canción", customFont: CustomFont(type: .bold, size: 20))
                            .frame(minWidth:0, maxWidth: .infinity,alignment: .leading)
                        ZStack {
                            //SearchBarFilter().buttonStyle(PlainButtonStyle())
                            SearchBar(text: $searchText, placeholder: "Canción, artista, albúm")
                            
                        }.padding(.bottom)
                        ZStack {
                            FilterGrid(openFilter: self.openFilter(id:))
                        }.padding(.bottom)
                        HStack{
                            
                            
                            TextWithCustomFonts("Canciones disponibles",customFont: CustomFont(type: .bold, size: 20)).frame(minWidth:0, maxWidth: .infinity,alignment: .leading)
                            SimpleunderlineBtn("Ver todo"){
                                
                            }
                        }
                        
                       
                    }.buttonStyle(PlainButtonStyle())
                    if(stock.count != 0){
                        if rows > 0{
                                
                            ForEach(0...rows,id:\.self){i in
                                    
                                    VStack {
                                        HStack(spacing: 16){
                                            SongItem(song: musicList[i*2],url:musicList[i*2].coverImageUri! )
                                            SongItem(song: musicList[(i*2)+1],url:musicList[(i*2)+1].coverImageUri!)
                                            
                                            
                                        }
                                        Spacer().frame(height:10)
                                    }
                                }
                            if viewModel.isImpar {
                                    HStack(spacing: 16){
                                        SongItem(song: musicList[count],url:musicList[count].coverImageUri!)
                                        SongItem(song: musicList[count],url:musicList[count].coverImageUri!).opacity(0.0)
                                        
                                        
                                    }
                                }
                               
                                
                                
                           
                        }
                    }
                 
                    Spacer().frame(height:78)
                }
            }.listStyle(PlainListStyle()).navigationBarTitle("Bienvenido",displayMode: .inline).alert(isPresented:$showingAlert, content: {
                Alert(title:Text(String("Atención").capitalized), message: Text(String("Recuerda que no podrás reproducir canciones si la calidad de red es baja").capitalized), primaryButton: .cancel(Text(String("Cancelar").capitalized)),secondaryButton: .default(Text(String("Aceptar").capitalized)))
            }).onAppear{
                if stock.count > 0 {
                    self.getList()
                    self.getRows()
                }
                if !hasFetsched
                {
                    viewModel.branchId = appSettings.currentBranchId
                    viewModel.getUriReponse {
                        self.getList()
                        self.getRows()
                    }
                    hasFetsched = true
                }
                
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
    
   
    
    public func getRows(){
        let decimalValue:Double = Double(count-1)/2
        let intValue:Int =  (count-1)/2
        let difference:Double = decimalValue - Double(intValue)
        print("rows",difference)
        if difference > 0 {
            rows = intValue
            self.isImpar = true
        }
        else {
            rows = intValue
           
        }
     
    }
    func getList(){
        
        if(stock.count != 0){
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
            count = musicList.count - 1
        }
        
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Home(branchId: "sdsd")
    }
}
