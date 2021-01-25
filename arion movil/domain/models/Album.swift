//
//  Album.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 08/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

class Album:Identifiable {
    
    var id:Int
    var name:String
    var image:String
    weak var artist:Artist?
    
    internal init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
    
}
