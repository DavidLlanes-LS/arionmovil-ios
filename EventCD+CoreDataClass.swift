//
//  EventCD+CoreDataClass.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EventCD)
public class EventCD: NSManagedObject, Encodable,Decodable {
   
    enum CodingKeys: String, CodingKey{
        case playlistID = "PlaylistId"
        case items = "Items"
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let codingUserInfoKeyManagedObjectContext =  MyCoreBack.shared.background
        if
           let entity = NSEntityDescription.entity(forEntityName: "EventCD", in: codingUserInfoKeyManagedObjectContext){
            self.init(entity:entity, insertInto: codingUserInfoKeyManagedObjectContext)
        }else{
            self.init()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try playListId = container.decode(String.self, forKey: .playlistID)
        try items =  container.decode(Set<ItemCD>.self, forKey: .items) as NSSet
       
    }
    
    
    public func encode (to decoder: Encoder) throws {
        var container = decoder.container(keyedBy: CodingKeys.self)
        try container.encode(playListId, forKey: .playlistID)
        try container.encode(items as! Set<ItemCD>, forKey: .items)
    }
}
