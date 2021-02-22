//
//  SwiftUIView.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 28/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct GridViewSong: View {
    var song:TitleCD = TitleCD()
    var count:Int = 0
    @State var navigateLogin = false
    @State var rows:Int = 0
    @State var isImpar = false
    init(items:Int) {
        count = items
    }
    var body: some View {
        VStack {
            if rows > 0{
                List{
                    
                    ForEach(1...rows,id:\.self){i in
                        
                        HStack(spacing: 16){
                            SongItem(song:song,navigateLogin: $navigateLogin){_ in}
                            SongItem(song:song,navigateLogin: $navigateLogin){_ in}
                            
                            
                        }
                    }
                    if isImpar {
                        HStack(spacing: 16){
                            SongItem(song:song,navigateLogin: $navigateLogin){_ in}
                            SongItem(song:song,navigateLogin: $navigateLogin){_ in}.opacity(0.0)
                            
                            
                        }
                    }
                    
                    
                    
                }.onAppear{
                    //  UITableView.appearance().isScrollEnabled = false
                }
            }
            
            
            
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        GridViewSong(items: 4)
    }
}
