//
//  PeriodCD+CoreDataProperties.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData


extension PeriodCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PeriodCD> {
        return NSFetchRequest<PeriodCD>(entityName: "PeriodCD")
    }

    @NSManaged public var endTime: String?
    @NSManaged public var startTime: String?
    @NSManaged public var period: ItemCD?

}

extension PeriodCD : Identifiable {

}
