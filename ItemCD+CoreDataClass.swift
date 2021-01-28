//
//  ItemCD+CoreDataClass.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ItemCD)
public class ItemCD: NSManagedObject, Encodable, Decodable {
    enum CodingKeys: String, CodingKey{
        case dayOfWeek = "DayOfWeek"
        case periods = "Periods"
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let codingUserInfoKeyManagedObjectContext =  MyCoreBack.shared.background
        if
           let entity = NSEntityDescription.entity(forEntityName: "ItemCD", in: codingUserInfoKeyManagedObjectContext){
            self.init(entity:entity, insertInto: codingUserInfoKeyManagedObjectContext)
        }else{
            self.init()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try dayOfWeek = container.decode(Int32.self, forKey: .dayOfWeek)
        try periods = container.decode(Set<PeriodCD>.self, forKey: .periods) as NSSet
        
    }
    
    public func encode(to decoder: Encoder) throws {
        var container = decoder.container(keyedBy: CodingKeys.self)
        try container.encode(dayOfWeek, forKey: .dayOfWeek)
        try container.encode(periods as! Set<PeriodCD>, forKey: .periods)
    }
    
}
