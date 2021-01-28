//
//  EventCD+CoreDataProperties.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData


extension EventCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventCD> {
        return NSFetchRequest<EventCD>(entityName: "EventCD")
    }

    @NSManaged public var playListId: String?
    @NSManaged public var items: NSSet?
    @NSManaged public var albumstock: AlbumStockCD?

}

// MARK: Generated accessors for items
extension EventCD {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ItemCD)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ItemCD)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension EventCD : Identifiable {

}
