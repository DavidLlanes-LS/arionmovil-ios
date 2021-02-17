//
//  SeeAll.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 04/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct SeeAll: View {
    @StateObject var viewModel:SongsUriViewModel = SongsUriViewModel()
    @StateObject var queueViewModel = QueueViewModel()
    @State var navigateLogin:Bool = false
    @StateObject var storeViewModel = StoreViewModel()
    @EnvironmentObject var appSettings: AppHelper
    let  branchId:String
    init(branchId: String){
        self.branchId = branchId
       
        
    }
    var body: some View {
        VStack{
            NavigationLink(destination: LoginView(), isActive: self.$navigateLogin ) {}
            List{
                if viewModel.rows > 0{
                    ForEach(0...viewModel.rows,id:\.self){i in
                        VStack {
                            HStack(spacing: 16){
                                SongItem(song: viewModel.musicList[i*2], navigateLogin: self.$navigateLogin,url:viewModel.musicList[i*2].coverImageUri! ){id in
                                    queueViewModel.addNewQueue(id: id)
                                }.buttonStyle(PlainButtonStyle())
                                SongItem(song: viewModel.musicList[(i*2)+1], navigateLogin: self.$navigateLogin,url:viewModel.musicList[(i*2)+1].coverImageUri!){id in
                                    queueViewModel.addNewQueue(id: id)
                                }.buttonStyle(PlainButtonStyle())
                            }
                            Spacer().frame(height:10)
                        }.listRowBackground(Color("background"))
                    }
                    if viewModel.isImpar {
                        HStack(spacing: 16){
                            SongItem(song: viewModel.musicList[viewModel.count], navigateLogin: self.$navigateLogin,url:viewModel.musicList[viewModel.count].coverImageUri!){id in
                                queueViewModel.addNewQueue(id: id)
                            }.buttonStyle(PlainButtonStyle())
                            SongItem(song: viewModel.musicList[viewModel.count], navigateLogin: self.$navigateLogin,url:viewModel.musicList[viewModel.count].coverImageUri!){id in
                                queueViewModel.addNewQueue(id: id)
                            }.opacity(0.0).buttonStyle(PlainButtonStyle())
                        }.listRowBackground(Color("background"))
                    }
                }
            }
        }.onAppear{
            viewModel.branchId = branchId
            queueViewModel.appSettings = appSettings
            viewModel.setDataCD()
        }.background(Color("background"))
        
    }
}

struct SeeAll_Previews: PreviewProvider {
    static var previews: some View {
        SeeAll(branchId: "df")
    }
}
