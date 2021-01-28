//
//  SongsState+CoreDataProperties.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData


extension SongsState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SongsState> {
        return NSFetchRequest<SongsState>(entityName: "SongsState")
    }

    @NSManaged public var catalogUri: String?
    @NSManaged public var generationDate: String?
    @NSManaged public var resultCode: Int32

}

extension SongsState : Identifiable {

}
