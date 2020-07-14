//
//  SongItem.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SongItem: View {
    var hasCorners:Bool = true
    var body: some View {
        Image("dualipa").resizable().aspectRatio(contentMode: .fill).cornerRadius(hasCorners ? 3:0)
    }
}

struct SongItem_Previews: PreviewProvider {
    static var previews: some View {
        SongItem()
    }
}
