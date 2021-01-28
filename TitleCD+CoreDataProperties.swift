//
//  TitleCD+CoreDataProperties.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData


extension TitleCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TitleCD> {
        return NSFetchRequest<TitleCD>(entityName: "TitleCD")
    }

    @NSManaged public var artist: String?
    @NSManaged public var coverImageUri: String?
    @NSManaged public var genere: String?
    @NSManaged public var hasExplicitContent: Bool
    @NSManaged public var id: String?
    @NSManaged public var mediaAlbumId: String?
    @NSManaged public var mediaId: Int64
    @NSManaged public var name: String?
    @NSManaged public var recordedYear: Int64
    @NSManaged public var titleId: Int64
    @NSManaged public var album: AlbumCD?

}

extension TitleCD : Identifiable {

}
