//
//  TitleCD+CoreDataClass.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TitleCD)
public class TitleCD: NSManagedObject, Encodable, Decodable {
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case titleID="TitleId"
        case mediaAlbumID="MediaAlbumId"
        case mediaID = "MediaId"
        case name="Name"
        case genere="Genere"
        case artist = "Artist"
        case hasExplicitContent="HasExplicitContent"
        case recordedYear="RecordedYear"
        case coverImageURI="CoverImageUri"
    }
    required public convenience init(from decoder: Decoder) throws {
        let codingUserInfoKeyManagedObjectContext =  MyCoreBack.shared.background
        if
           let entity = NSEntityDescription.entity(forEntityName: "TitleCD", in: codingUserInfoKeyManagedObjectContext){
            self.init(entity:entity, insertInto: codingUserInfoKeyManagedObjectContext)
        }else{
            self.init()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try id = container.decode(String.self, forKey: .id)
        try titleId = container.decode(Int64.self, forKey: .titleID)
        try mediaAlbumId = container.decode(String.self, forKey: .mediaAlbumID)
        try mediaId = container.decode(Int64.self, forKey: .mediaID)
        try name  =  container.decode(String.self, forKey: .name)
        try genere =  container.decode(String.self, forKey: .genere)
        try artist = container.decode(String.self, forKey: .artist)
        try hasExplicitContent = container.decode(Bool.self, forKey: .hasExplicitContent)
        try recordedYear = container.decode(Int64.self, forKey: .recordedYear)
        try coverImageUri = container.decodeIfPresent(String.self, forKey: .coverImageURI)
    }
    
    public func encode (to decoder: Encoder) throws {
        var container = decoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(titleId, forKey: .titleID)
        try container.encode(mediaAlbumId, forKey: .mediaAlbumID)
        try container.encode(mediaId, forKey: .mediaID)
        try container.encode(name, forKey: .name)
        try container.encode(genere, forKey: .genere)
        try container.encode(artist, forKey: .artist)
        try container.encode(hasExplicitContent, forKey: .hasExplicitContent)
        try container.encode(recordedYear, forKey: .recordedYear)
        try container.encode(coverImageUri, forKey: .coverImageURI)
    }

}
