//
//  SongRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SongRow: View {
    var body: some View {
        HStack(spacing: 16){
            SongItem()
            SongItem()
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow()
    }
}
