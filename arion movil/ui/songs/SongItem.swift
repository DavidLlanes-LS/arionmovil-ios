//
//  SongItem.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI
import URLImage

struct SongItem: View {
    var song:TitleCD
     var url:String = "https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/BLACKPINK-_The_Album.png/220px-BLACKPINK-_The_Album.png"
    var hasCorners:Bool = true
    
    var body: some View {
        
        VStack(alignment:.center,spacing:0) {
            //Image("dualipa").resizable().aspectRatio(contentMode: .fill).cornerRadius(hasCorners ? 0:0)
//            URLImage(url:URL(string: "https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/BLACKPINK-_The_Album.png/220px-BLACKPINK-_The_Album.png")!, content:  {
//
//                $0.resizable().aspectRatio(contentMode: .fill)})
         
            VStack(alignment: .center) {
                Spacer()
                URLImage(url:URL(string: url)!, content:  {

                            $0.resizable().aspectRatio(contentMode: .fill)}).frame(maxWidth: .infinity,maxHeight:.infinity)
                Spacer()
            }.frame(maxWidth: .infinity,maxHeight:.infinity)
            if(hasCorners){
                VStack {
                    
                    TextWithCustomFonts(song.artist ?? "No hay", customFont: CustomFont(type: .bold, size: 8)).frame(maxWidth:.infinity,alignment: .leading).padding(.leading,2)
                    TextWithCustomFonts(song.name ?? "No hay", customFont: CustomFont(type: .bold, size: 12)).frame(maxWidth:.infinity,alignment: .leading).padding(.leading,2)
                    Spacer().frame(height:2)
                    
                }.frame(maxWidth:.infinity).background(Color.white).onAppear{
//                    url = song.coverImageUri!
//                    print("imagenes", url)
//                    print("cancion",url)
                    //var url:String = song.coverImageUri ?? "sdsd"
                    
                }
            }
        
           
        }.frame(height: hasCorners ? 200: nil)
        
    }
}

struct SongItem_Previews: PreviewProvider {
    static var previews: some View {
        let title:TitleCD = TitleCD()
        SongItem(song:title)
    }
}
