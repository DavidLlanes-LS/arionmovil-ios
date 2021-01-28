//
//  PlaylistCD+CoreDataClass.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData

@objc(PlaylistCD)
public class PlaylistCD: NSManagedObject, Encodable, Decodable {
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case albums = "Albums"

        
    }
    
    
    required public convenience init(from decoder: Decoder) throws {
        let codingUserInfoKeyManagedObjectContext =  MyCoreBack.shared.background
        if
           let entity = NSEntityDescription.entity(forEntityName: "PlaylistCD", in: codingUserInfoKeyManagedObjectContext){
            self.init(entity:entity, insertInto: codingUserInfoKeyManagedObjectContext)
        }else{
            self.init()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try id = container.decode(String.self, forKey: .id)
        try albums =  container.decode(Set<AlbumCD>.self, forKey: .albums) as NSSet
    }
    
    public func encode (to decoder: Encoder) throws {
        var container = decoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(albums as! Set<AlbumCD>, forKey: .albums)
    }
    
    
}
