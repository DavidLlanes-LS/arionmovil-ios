//
//  AlbumStockCD+CoreDataClass.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AlbumStockCD)
public class AlbumStockCD: NSManagedObject, Encodable, Decodable {
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case playlists = "Playlists"
        case events = "Events"
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let codingUserInfoKeyManagedObjectContext =  MyCoreBack.shared.background
        if
           let entity = NSEntityDescription.entity(forEntityName: "AlbumStockCD", in: codingUserInfoKeyManagedObjectContext){
            self.init(entity:entity, insertInto: codingUserInfoKeyManagedObjectContext)
        }else{
            self.init()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try id = container.decode(String.self, forKey: .id)
        try playlists =  container.decode(Set<PlaylistCD>.self, forKey: .playlists) as NSSet
        try events =  container.decode(Set<EventCD>.self, forKey: .events) as NSSet
    }
    
    
    public func encode (to decoder: Encoder) throws {
        var container = decoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(playlists as! Set<PlaylistCD>, forKey: .playlists)
        try container.encode(events as! Set<EventCD>, forKey: .events)
    }
}
