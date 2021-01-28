//
//  AlbumCD+CoreDataClass.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AlbumCD)
public class AlbumCD: NSManagedObject, Encodable, Decodable {
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case mediaID = "MediaId"
        case name="Name"
        case genere="Genere"
        case artist = "Artist"
        case releaseYear = "ReleaseYear"
        case coverImageURI="CoverImageUri"
        case titles =  "Titles"
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let codingUserInfoKeyManagedObjectContext =  MyCoreBack.shared.background
        if
           let entity = NSEntityDescription.entity(forEntityName: "AlbumCD", in: codingUserInfoKeyManagedObjectContext){
            self.init(entity:entity, insertInto: codingUserInfoKeyManagedObjectContext)
        }else{
            self.init()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try id = container.decode(String.self, forKey: .id)
        try mediaId = container.decode(Int32.self, forKey: .mediaID)
        try name = container.decode(String.self, forKey: .name)
        try genere  =  container.decode(String.self, forKey: .genere)
        try artist = container.decode(String.self, forKey: .artist)
        try releaseyear = container.decode(Int32.self, forKey: .releaseYear)
        try coverImageUri = container.decode(String.self, forKey: .coverImageURI)
        try titles = container.decode(Set<TitleCD>.self, forKey: .titles) as NSSet
    }
    
    
    public func encode (to decoder: Encoder) throws {
        var container = decoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(mediaId, forKey: .mediaID)
        try container.encode(name, forKey: .name)
        try container.encode(genere, forKey: .genere)
        try container.encode(artist, forKey: .artist)
        try container.encode(releaseyear, forKey: .releaseYear)
        try container.encode(coverImageUri, forKey: .coverImageURI)
        try container.encode(titles as! Set<TitleCD>, forKey: .titles)
    }
}
