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
    @EnvironmentObject var appSettings:AppHelper
    @ObservedObject var viewModel:SongsUriViewModel = SongsUriViewModel()
    var fetchRequest: FetchRequest<AlbumStockCD> = FetchRequest<AlbumStockCD>(entity:AlbumStockCD.entity(), sortDescriptors: [], predicate: NSPredicate(format: "restaurantId == %@", ""))
    private var stock: FetchedResults<AlbumStockCD>{fetchRequest.wrappedValue}
    @State var navigateLogin = false
    @State var navigateFilterArtist:Bool = false
    @State var navigateFilterAlbum:Bool = false
    @State var navigateFilterMusicGenre:Bool = false
    @State var navigateFilterYear:Bool = false
    @State var navigateSongSearcher:Bool = false
    @State var navigateSeeAll:Bool = false
    @State private var showingAlert = true
    @State var hasFetsched:Bool = false
    @State var musicList:[TitleCD] = []
    @State public var searchText : String = ""
    @State var count:Int = 0
    @State var rows:Int = 0
    @State var isImpar = false
    init(branchId: String){
        fetchRequest = FetchRequest<AlbumStockCD>(entity:AlbumStockCD.entity(), sortDescriptors: [], predicate: NSPredicate(format: "restaurantId == %@", branchId))
    }
    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink(destination: MusicalGenreSearcher(branchId: appSettings.currentBranchId), isActive: self.$navigateFilterMusicGenre ) {}
                NavigationLink(destination:YearSearcher(branchId: appSettings.currentBranchId), isActive: self.$navigateFilterYear ) {}
                NavigationLink(destination: AlbumSearcher(branchId: appSettings.currentBranchId), isActive: self.$navigateFilterAlbum ) {}
                NavigationLink(destination: ArtistSearcher(branchId: appSettings.currentBranchId), isActive: self.$navigateFilterArtist ) {}
                NavigationLink(destination: LoginView(), isActive: self.$navigateLogin ) {}
                NavigationLink(destination: SongSearcher(branchId: appSettings.currentBranchId), isActive: self.$navigateSongSearcher ) {}
                NavigationLink(destination: SeeAll(branchId: appSettings.currentBranchId), isActive: self.$navigateSeeAll) {}
                
                List{
                    VStack{
                        TextWithCustomFonts("Buscar una canción", customFont: CustomFont(type: .bold, size: 20))
                            .frame(minWidth:0, maxWidth: .infinity,alignment: .leading)
                        ZStack {
                            Button(action:{
                                navigateSongSearcher = true
                                
                            }){
                                SearchBarFilter().buttonStyle(PlainButtonStyle())
                            }
                            
                        }.padding(.bottom)
                        ZStack {
                            FilterGrid(openFilter: self.openFilter(id:))
                        }.padding(.bottom)
                        HStack{
                            TextWithCustomFonts("Canciones disponibles",customFont: CustomFont(type: .bold, size: 20)).frame(minWidth:0, maxWidth: .infinity,alignment: .leading)
                            SimpleunderlineBtn("Ver todo"){
                                navigateSeeAll = true
                            }
                        }
                    }.buttonStyle(PlainButtonStyle())
                    if(stock.count != 0){
                        if rows > 0{
                            
                            ForEach(0...rows,id:\.self){i in
                                
                                VStack {
                                    HStack(spacing: 16){
                                        SongItem(song: musicList[i*2], navigateLogin: self.$navigateLogin,url:musicList[i*2].coverImageUri! ).buttonStyle(PlainButtonStyle())
                                        SongItem(song: musicList[(i*2)+1], navigateLogin: self.$navigateLogin,url:musicList[(i*2)+1].coverImageUri!).buttonStyle(PlainButtonStyle())
                                        
                                        
                                    }
                                    Spacer().frame(height:10)
                                }
                            }
                            if self.isImpar {
                                HStack(spacing: 16){
                                    SongItem(song: musicList[count], navigateLogin: self.$navigateLogin,url:musicList[count].coverImageUri!).buttonStyle(PlainButtonStyle())
                                    SongItem(song: musicList[count], navigateLogin: self.$navigateLogin,url:musicList[count].coverImageUri!).opacity(0.0).buttonStyle(PlainButtonStyle())
                                    
                                    
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
                appSettings.showCurrentSong = true
            }
            
            
            
            
        }
        
    }
    func openFilter(id:Int) {
        switch id {
        case 1:
            self.navigateFilterArtist = true
        case 2:
            self.navigateFilterAlbum = true
        case 3:
            self.navigateFilterMusicGenre = true
        case 4:
            self.navigateFilterYear = true
            
        default:
            self.navigateFilterArtist = true
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
            var albums2:[AlbumCD] = []
            for playlist in playlists{
                albums2.append(contentsOf: (playlist.albums?.allObjects as! [AlbumCD]))
            }
            let albums = albums2
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
