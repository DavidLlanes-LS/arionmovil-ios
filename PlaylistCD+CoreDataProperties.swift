//
//  PlaylistCD+CoreDataProperties.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData


extension PlaylistCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaylistCD> {
        return NSFetchRequest<PlaylistCD>(entityName: "PlaylistCD")
    }

    @NSManaged public var id: String?
    @NSManaged public var albums: NSSet?
    @NSManaged public var albumstock: AlbumStockCD?

}

// MARK: Generated accessors for albums
extension PlaylistCD {

    @objc(addAlbumsObject:)
    @NSManaged public func addToAlbums(_ value: AlbumCD)

    @objc(removeAlbumsObject:)
    @NSManaged public func removeFromAlbums(_ value: AlbumCD)

    @objc(addAlbums:)
    @NSManaged public func addToAlbums(_ values: NSSet)

    @objc(removeAlbums:)
    @NSManaged public func removeFromAlbums(_ values: NSSet)

}

extension PlaylistCD : Identifiable {

}
