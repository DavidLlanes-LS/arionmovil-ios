//
//  PeriodCD+CoreDataClass.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 27/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
//

import Foundation
import CoreData

@objc(PeriodCD)
public class PeriodCD: NSManagedObject, Encodable, Decodable {
    enum CodingKeys: String, CodingKey{
        case startTime = "StartTime"
        case endTime = "EndTime"
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let codingUserInfoKeyManagedObjectContext =  MyCoreBack.shared.background
        if
           let entity = NSEntityDescription.entity(forEntityName: "PeriodCD", in: codingUserInfoKeyManagedObjectContext){
            self.init(entity:entity, insertInto: codingUserInfoKeyManagedObjectContext)
        }else{
            self.init()
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try startTime = container.decode(String.self, forKey: .startTime)
        try endTime =  container.decode(String.self, forKey: .endTime)
    }
    
    public func encode (to decoder: Encoder) throws {
        var container = decoder.container(keyedBy: CodingKeys.self)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(endTime, forKey: .endTime)
    }
    
    
}
