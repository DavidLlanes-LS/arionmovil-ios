//
//  MusicalGenre.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 09/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import Foundation


class MusicalGenre:Identifiable {
    
    var id:Int
    var name:String

    internal init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}
