//
//  QueueTitle.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Opacity16: View {
    var hasOpacity:Bool = true
    var title:String
    init(_ title:String) {
        self.title = title
    }
    var body: some View {
        Text(title)
            .bold()
            .lineLimit(1)
            .font(.custom("Exo", size: 16))
            .opacity(hasOpacity ? 1: 0.5)
    }
}

struct QueueTitle_Previews: PreviewProvider {
    static var previews: some View {
        Opacity16("Hola")
    }
}
