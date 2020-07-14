//
//  Queue.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Queue: View {
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                AvailableCredits()
                List{
                    HStack{
                        TextWithCustomFonts("Termina en",customFont: CustomFont(type: .bold, size: 18))
                        TextWithCustomFonts(" 00:30",customFont: CustomFont(type: .bold, size: 22),color: Color("secondary-background"))
                        Spacer()
                    }
                    ForEach((1...10).reversed(), id: \.self) {_ in
                        QueueRow().buttonStyle(PlainButtonStyle())
                    }
                }
            }.navigationBarTitle("En fila", displayMode: .inline)
        }
        
    }
}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        Queue()
    }
}
