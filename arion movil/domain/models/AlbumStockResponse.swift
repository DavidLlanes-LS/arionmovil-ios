//
//  AlbumStockResponse.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 22/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
// MARK: - AlbumStockResponse
struct AlbumStockResponse:Codable {
    let id: String?
    let playlists: [Playlist]?
    let events: [Event]?
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case playlists = "Playlists"
        case events = "Events"
    }
}

// MARK: - Event
struct Event:Codable {
    let playlistID: String?
    let items: [Item]?
    enum CodingKeys: String, CodingKey{
        case playlistID = "PlaylistId"
        case items = "Items"
    }
}

// MARK: - Item
struct Item:Codable {
    let dayOfWeek: Int?
    let periods: [Period]?
    enum CodingKeys: String, CodingKey{
        case dayOfWeek = "DayOfWeek"
        case periods = "Periods"
    }
}

// MARK: - Period
struct Period:Codable {
    let startTime, endTime: String?
    enum CodingKeys: String, CodingKey{
        case startTime = "StartTime"
        case endTime = "EndTime"
    }
 
}

// MARK: - Playlist
struct Playlist:Codable {
    let id: String?
    let albums: [Album2]?
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case albums = "Albums"

        
    }
}

// MARK: - Album
struct Album2:Codable {
    let id: String?
    let mediaID: Int?
    let name, genere, artist: String?
    let releaseYear: Int?
    let coverImageURI: String?
    let titles: [Title]?
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case mediaID = "MediaID"
        case name="Name"
        case genere="Genere"
        case artist = "Srtist"
        case releaseYear = "ReleaseYear"
        case coverImageURI="CoverImageUri"
        case titles =  "Titles"
    }
}

// MARK: - Title
struct Title:Codable {
    let id: String?
    let titleID: Int?
    let mediaAlbumID: String?
    let mediaID: Int?
    let name, genere, artist: String?
    let hasExplicitContent: Bool?
    let recordedYear: Int?
    let coverImageURI: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case titleID="TitleId"
        case mediaAlbumID="MediaAlbumId"
        case mediaID = "MediaId"
        case name="Name"
        case genere="Genere"
        case artist = "Artist"
        case hasExplicitContent="HasExplicitContent"
        case recordedYear="RecordedYear"
        case coverImageURI="CoverImageUri"
    }
}
