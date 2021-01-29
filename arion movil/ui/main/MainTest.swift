//
//  MainTest.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 26/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct MainTest: View {
    @Environment(\.managedObjectContext) public var viewContext
    @FetchRequest(sortDescriptors: [])
    private var songsState: FetchedResults<SongsState>
    @FetchRequest(sortDescriptors: [])
    private var stock: FetchedResults<AlbumStockCD>
    @ObservedObject var viewModel2:algoViewModel = algoViewModel()
    @ObservedObject var viewModel:SongsUriViewModel = SongsUriViewModel()
    @State var musicList:[TitleCD] = []
    @State private var showingAlert = true
    @State var isFilterArtist:Bool = false
    @State var isFilterAlbum:Bool = false
    @State var isFilterMusicGenre:Bool = false
    @State var isFilterYear:Bool = false
    @State public var searchText : String = ""
    @State var count:Int = 9
    @State var rows:Int = 0
    @State var isImpar = false
  
    init(){
        
    }
   
    var body: some View {
        
        NavigationView {
            VStack {
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
                                if isImpar {
                                    HStack(spacing: 16){
                                        SongItem(song: musicList[count],url:musicList[count].coverImageUri!)
                                        SongItem(song: musicList[count],url:musicList[count].coverImageUri!).opacity(0.0)
                                        
                                        
                                    }
                                }
                               
                                
                                
                           
                        }
                    }
                 
                    Spacer().frame(height:78)
                }
            }.listStyle(PlainListStyle()).navigationBarTitle("Bienvenido",displayMode: .inline).onAppear{
                viewModel.getUriReponse {
                    getList()
                    getRows()
                }
//                getList()
//
//                getRows()
              
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
    
   
    
    public func getRows(){
        let decimalValue:Double = Double(count)/2
        let intValue:Int =  count/2
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
         
            
            titles.forEach{title in
                title.coverImageUri = title.coverImageUri! as String
            }
            //count = musicList.count
            
            titles = Array(Set(titles))
            musicList = titles
            musicList.sort{
                $0.name!<$1.name!
            }
            count = 490
            print("listas0","\(musicList[1].id) \(musicList[1].name)" )
            print("listas1","\(musicList[1].id) \(musicList[1].name)" )
            print("listas2","\(musicList[2].id) \(musicList[2].name)" )
            print("listas3","\(musicList[3].id) \(musicList[3].name)" )
        }
        
    }
}

struct MainTest_Previews: PreviewProvider {
    static var previews: some View {
        MainTest()
    }
}
