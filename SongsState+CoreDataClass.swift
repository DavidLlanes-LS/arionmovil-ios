//
//  SongsState+CoreDataClass.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SongsState)
public class SongsState: NSManagedObject {

    @nonobjc public class func fetchRequestNamed(branchId:String) -> NSFetchRequest<SongsState> {
        let request = NSFetchRequest<SongsState>(entityName: "SongsState")
        //request.sortDescriptors = [NSSortDescriptor(key: "catalogUri", ascending: true)]
        request.predicate = NSPredicate(format: "branchId == %@", branchId)
        //request.propertiesToFetch = ["name"]
        return request
    }
    
   
}
