//
//  Song.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

class Song: Identifiable {
    
    
    
    var id:Int
    var name:String
    var album:Album?
    var artist:Artist?
    
    internal init(id: Int, name: String, album: Album? = nil, artist: Artist? = nil) {
        self.id = id
        self.name = name
        self.album = album
        self.artist = artist
    }
}
