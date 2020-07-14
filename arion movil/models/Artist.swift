//
//  Artist.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

class Artist: Identifiable {
    
    var id:Int
    var name:String
    var songs:[Song] = ([])
    
    internal init(id: Int, name: String, songs: [Song] = ([])) {
        self.id = id
        self.name = name
        self.songs = songs
    }
    
}
