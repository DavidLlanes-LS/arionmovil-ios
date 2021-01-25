//
//  SongsQueueResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 22/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct Titleslist:Codable{
    let titlesInQueue: [TitleInQueue]
    
    enum CodingKeys: String, CodingKey{
        case titlesInQueue = "TitlesInQueue"
        
    }
    
}

// MARK: - TitlesInQueue
struct TitleInQueue:Codable,Identifiable {
    let id:String
    let playerID:String
    let titleID:String
    let titleName: String
    let titleArtist: String
    let credits: Int
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case playerID="PlayerId"
        case titleID="TitleId"
        case titleName="TitleName"
        case titleArtist = "TitleArtist"
        case credits="Credits"
    }
}
