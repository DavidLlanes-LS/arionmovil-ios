//
//  Branch.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import Foundation


class Branch:Identifiable{
    var id:Int
    var name:String
    var location:String
    var image:String
    
    internal init(id: Int, name: String, location: String, image: String) {
        self.id = id
        self.name = name
        self.location = location
        self.image = image
    }
    
}
