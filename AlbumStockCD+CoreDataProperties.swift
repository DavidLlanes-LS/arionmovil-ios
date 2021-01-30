//
//  AlbumStockCD+CoreDataProperties.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData


extension AlbumStockCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumStockCD> {
        return NSFetchRequest<AlbumStockCD>(entityName: "AlbumStockCD")
    }

    @NSManaged public var id: String?
    @NSManaged public var restaurantId: String?
    @NSManaged public var events: NSSet?
    @NSManaged public var playlists: NSSet?

}

// MARK: Generated accessors for events
extension AlbumStockCD {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: EventCD)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: EventCD)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}

// MARK: Generated accessors for playlists
extension AlbumStockCD {

    @objc(addPlaylistsObject:)
    @NSManaged public func addToPlaylists(_ value: PlaylistCD)

    @objc(removePlaylistsObject:)
    @NSManaged public func removeFromPlaylists(_ value: PlaylistCD)

    @objc(addPlaylists:)
    @NSManaged public func addToPlaylists(_ values: NSSet)

    @objc(removePlaylists:)
    @NSManaged public func removeFromPlaylists(_ values: NSSet)

}

extension AlbumStockCD : Identifiable {

}
