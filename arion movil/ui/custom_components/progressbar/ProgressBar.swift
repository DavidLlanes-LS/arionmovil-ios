//
//  ProgressBar.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @State var average:Int
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle().fill(Color.clear)
                Rectangle().fill(Color("secondary-background")).frame(width: (geometry.size.width * CGFloat(self.average)) / 100)
            }.frame(height:5)
        }
        
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(average: 50)
    }
}
