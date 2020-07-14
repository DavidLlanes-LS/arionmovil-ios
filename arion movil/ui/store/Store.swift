//
//  Store.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Store: View {
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                AvailableCreditsBig()
                VStack(alignment:.leading,spacing:16){
                    TextWithCustomFonts("Paquetes disponibles",customFont: CustomFont(type: .bold, size: 22),color:Color("title"))
                    Package()
                    Package()
                    Package()
                    Package()
                }.padding()
                Spacer()
            }.background(Color("background"))
                .navigationBarTitle("Compras", displayMode: .inline)
        }
        
    }
}

struct Store_Previews: PreviewProvider {
    static var previews: some View {
        Store()
    }
}
