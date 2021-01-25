//
//  ArionService.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
protocol ArionService {
    var apiSession: APIService {get}
    func getBranchesList(latitude:String,longitude:String) -> AnyPublisher<LocationsList, APIError>
//    func getSongQueue() -> AnyPublisher<LocationsList, APIError>
}

extension ArionService {
    
    func getBranchesList(latitude:String,longitude:String) -> AnyPublisher<LocationsList, APIError> {
        return apiSession.request(with:ApiRequest().getBranches(longitude: longitude, latitude: latitude) )
            .eraseToAnyPublisher()
    }
    
    func getSongsQueue() -> AnyPublisher<Titleslist, APIError> {
        return apiSession.request(with: ApiRequest().getSongQueue())
            .eraseToAnyPublisher()
    }
    
    func getSongsURI() -> AnyPublisher<SongsUriResponse, APIError> {
        return apiSession.request(with: ApiRequest().getSongsList())
            .eraseToAnyPublisher()
    }
}
