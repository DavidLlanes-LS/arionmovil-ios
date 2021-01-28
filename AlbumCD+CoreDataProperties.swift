//
//  AlbumCD+CoreDataProperties.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData


extension AlbumCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumCD> {
        return NSFetchRequest<AlbumCD>(entityName: "AlbumCD")
    }

    @NSManaged public var artist: String?
    @NSManaged public var coverImageUri: String?
    @NSManaged public var genere: String?
    @NSManaged public var id: String?
    @NSManaged public var mediaId: Int32
    @NSManaged public var name: String?
    @NSManaged public var releaseyear: Int32
    @NSManaged public var playlist: PlaylistCD?
    @NSManaged public var titles: NSSet?

}

// MARK: Generated accessors for titles
extension AlbumCD {

    @objc(addTitlesObject:)
    @NSManaged public func addToTitles(_ value: TitleCD)

    @objc(removeTitlesObject:)
    @NSManaged public func removeFromTitles(_ value: TitleCD)

    @objc(addTitles:)
    @NSManaged public func addToTitles(_ values: NSSet)

    @objc(removeTitles:)
    @NSManaged public func removeFromTitles(_ values: NSSet)

}

extension AlbumCD : Identifiable {

}
