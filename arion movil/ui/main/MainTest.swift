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
    var count:Int = 5
    @State var rows:Int = 0
    @State var isImpar = false
    @Environment(\.managedObjectContext) public var viewContext
    @FetchRequest(sortDescriptors: [])
    private var songsState: FetchedResults<SongsState>
  
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
                    if rows > 0{
                            
                            ForEach(1...rows,id:\.self){i in
                                
                                VStack {
                                    HStack(spacing: 16){
                                        SongItem()
                                        SongItem()
                                        
                                        
                                    }
                                    Spacer().frame(height:10)
                                }
                            }
                            if isImpar {
                                HStack(spacing: 16){
                                    SongItem()
                                    SongItem().opacity(0.0)
                                    
                                    
                                }
                            }
                           
                            
                            
                       
                    }
                    
                }
            }.listStyle(PlainListStyle()).navigationBarTitle("Bienvenido",displayMode: .inline).onAppear{
                getRows()
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
    
    func getData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            viewModel2.songsState.append(contentsOf: songsState)
            viewModel2.viewContext = viewContext
            viewModel2.getUriReponse()
            
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
}

struct MainTest_Previews: PreviewProvider {
    static var previews: some View {
        MainTest()
    }
}
