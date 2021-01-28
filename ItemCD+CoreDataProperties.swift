//
//  ItemCD+CoreDataProperties.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemCD> {
        return NSFetchRequest<ItemCD>(entityName: "ItemCD")
    }

    @NSManaged public var dayOfWeek: Int32
    @NSManaged public var periods: NSSet?
    @NSManaged public var event: EventCD?

}

// MARK: Generated accessors for periods
extension ItemCD {

    @objc(addPeriodsObject:)
    @NSManaged public func addToPeriods(_ value: PeriodCD)

    @objc(removePeriodsObject:)
    @NSManaged public func removeFromPeriods(_ value: PeriodCD)

    @objc(addPeriods:)
    @NSManaged public func addToPeriods(_ values: NSSet)

    @objc(removePeriods:)
    @NSManaged public func removeFromPeriods(_ values: NSSet)

}

extension ItemCD : Identifiable {

}
