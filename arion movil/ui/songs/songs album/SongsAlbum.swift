//
//  SongsAlbum.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI
import URLImage
struct SongsAlbum: View {
    @StateObject var queueViewModel = QueueViewModel()
    @State var musicList:[TitleCD] = []
    @State var navigateLogin = false
    @EnvironmentObject var appSettings: AppHelper
    @StateObject var storeViewModel = StoreViewModel()
    var body: some View {
        VStack{
            NavigationLink(destination: LoginView(), isActive: self.$navigateLogin ) {
            
            }
            Spacer()
            //Image("dualipa").resizable().aspectRatio(contentMode: .fill).frame(minWidth:0, maxWidth: .infinity).frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            URLImage(url:URL(string: musicList[0].coverImageUri!)!, content:  {

//                        $0.resizable().aspectRatio(contentMode: .fill)}).frame(maxWidth: .infinity).frame(height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.leading,20).padding(.trailing,20)
                        $0.resizable().aspectRatio(contentMode: .fill)}).frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).frame(height:130).clipped().cornerRadius(20).padding(.leading,20).padding(.trailing,20)
            List{
             
                    ForEach(self.musicList,id:\.self){song in
                        GenereRow(name: song.name!, artist: song.artist!, navigateLogin: $navigateLogin){
                                                queueViewModel.addNewQueue(id: song.id!)
                                            }.listRowBackground(Color("background"))
                    }

                  
                
               
            }
        }.onAppear{
            queueViewModel.appSettings = appSettings
        }.background(Color("background"))
    }
}

struct SongsAlbum_Previews: PreviewProvider {
    static var previews: some View {
        SongsAlbum()
    }
}
