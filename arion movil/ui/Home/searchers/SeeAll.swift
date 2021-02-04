//
//  SeeAll.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 04/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SeeAll: View {
    @ObservedObject var viewModel:SongsUriViewModel = SongsUriViewModel()
    @State var navigateLogin:Bool = false
    init(branchId: String){
        viewModel.branchId = branchId
        viewModel.setDataCD()
        
    }
    var body: some View {
        VStack{
            NavigationLink(destination: LoginView(), isActive: self.$navigateLogin ) {
                
            }
            List{
                
                    if viewModel.rows > 0{
                        
                        ForEach(0...viewModel.rows,id:\.self){i in
                            
                            VStack {
                                HStack(spacing: 16){
                                    SongItem(song: viewModel.musicList[i*2], navigateLogin: self.$navigateLogin,url:viewModel.musicList[i*2].coverImageUri! ).buttonStyle(PlainButtonStyle())
                                    SongItem(song: viewModel.musicList[(i*2)+1], navigateLogin: self.$navigateLogin,url:viewModel.musicList[(i*2)+1].coverImageUri!).buttonStyle(PlainButtonStyle())
                                    
                                    
                                }
                                Spacer().frame(height:10)
                            }
                        }
                        if viewModel.isImpar {
                            HStack(spacing: 16){
                                SongItem(song: viewModel.musicList[viewModel.count], navigateLogin: self.$navigateLogin,url:viewModel.musicList[viewModel.count].coverImageUri!).buttonStyle(PlainButtonStyle())
                                SongItem(song: viewModel.musicList[viewModel.count], navigateLogin: self.$navigateLogin,url:viewModel.musicList[viewModel.count].coverImageUri!).opacity(0.0).buttonStyle(PlainButtonStyle())
                                
                                
                            }
                        }
                        
                        
                        
                        
                    }
                }
            
        }
     
    }
}

struct SeeAll_Previews: PreviewProvider {
    static var previews: some View {
        SeeAll(branchId: "df")
    }
}