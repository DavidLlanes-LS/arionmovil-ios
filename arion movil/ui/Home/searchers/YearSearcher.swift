//
//  YearSearcher.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 13/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct YearSearcher: View {
    @StateObject var queueViewModel = QueueViewModel()
    @ObservedObject var viewModel:SongsUriViewModel =  SongsUriViewModel()
    @EnvironmentObject var appSettings: AppHelper
    @State var NavLogin = false
    @StateObject var storeViewModel = StoreViewModel()
    @State public var searchText : String = ""
    init(branchId: String){
        viewModel.branchId = branchId
        
    }
    @State var musicList:[TitleCD] = []
    var body: some View {
        VStack(spacing:0){
            NavigationLink(destination: LoginView(), isActive: self.$NavLogin ) {}
            //SearchBar(text: $searchText, placeholder: "Busca una cancion")
            List{
                ForEach(viewModel.yearList, id: \.self) {interval in
                    Section(header:TextWithCustomFonts(String("\(interval[0])-\(interval[1])"), customFont: CustomFont(type: .bold, size: 16)) .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)) ){
                        ForEach(viewModel.musicList.filter {$0.recordedYear >= interval[0] && $0.recordedYear <= interval[1] } , id: \.id){ title in
                            Button(action:{
                                NavLogin = true
                            }){
                                GenereRow(name: title.name!, artist: title.artist!,navigateLogin: $NavLogin){
                                    queueViewModel.addNewQueue(id: title.id!)
                                }
                            }
                        }
                    }.listRowBackground(Color("background"))
                    
                }
            }
        }.navigationBarTitle("Año",displayMode: .inline).onAppear{
            queueViewModel.appSettings = appSettings
            viewModel.setDataCD()
            
        }
    }
    
    
    
    
    struct YearSearcher_Previews: PreviewProvider {
        static var previews: some View {
            YearSearcher(branchId: "ddsf")
        }
    }
}
