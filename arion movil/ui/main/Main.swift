//
//  Main.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Main: View {
    @State var isFilterArtist:Bool = false
    @State var isFilterAlbum:Bool = false
    @State var isFilterMusicGenre:Bool = false
    @State var isFilterYear:Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    Color("background")
                    VStack{
                        TextWithCustomFonts("Buscar una cación", customFont: CustomFont(type: .bold, size: 20))
                            .frame(minWidth:0, maxWidth: .infinity,alignment: .leading)
                        ZStack {
                            SearchBarFilter().buttonStyle(PlainButtonStyle())
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
                        VStack(spacing:16){
                             ForEach((1...10).reversed(), id: \.self) {_ in
                                 SongRow()
                             }
                         }
                    }.padding()
                }
                
            }.onAppear(perform: {
                UITableView.appearance().separatorStyle = .none
            }).navigationBarTitle("Bienvenido",displayMode: .inline)
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
