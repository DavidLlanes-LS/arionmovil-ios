//
//  QueueRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct QueueRow: View {
    var body: some View {
        HStack(){
            Triangle()
                .fill(Color.green)
                .frame(width: 5, height: 5)
            VStack(alignment:.leading){
                TextWithCustomFonts("Don't stop me now",customFont: CustomFont(type: .bold, size: 16),color:  Color("two-gray"))
                TextWithCustomFonts("Queen",color: Color("two-gray"))
            }
            Spacer()
            HStack(spacing:32){
                IconBtn("arrow.right.circle"){
                    
                }
                IconBtn("hand.thumbsup"){
                    
                }
            }
            Text("52").bold()
        }.frame(height:60)
    }
}

struct QueueRow_Previews: PreviewProvider {
    static var previews: some View {
        QueueRow()
    }
}
