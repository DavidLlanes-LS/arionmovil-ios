//
//  ArionService.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import Gzip
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
    
    func getStockUnzipped(catalogUri:String,completion: @escaping () -> () )->AlbumStockCD{
        var file:Data = Data()
        var stockFinal:AlbumStockCD = AlbumStockCD()
        AF.download(catalogUri).downloadProgress{bytesRead in
        }.responseData { response in
            var decompressedData: Data
            if response.value!.isGzipped {
                decompressedData = try! response.value!.gunzipped()
               file = decompressedData
            } else {
                decompressedData = response.value!
              file = decompressedData
            }
            let str = String(decoding: file, as: UTF8.self)
            
            stockFinal = self.saveStock(data: str.data(using: .utf8)!,completion: completion)
            
          
        }
        return stockFinal
    }
    
    private func saveStock(data:Data,completion: @escaping () -> ())->AlbumStockCD{
        do{
            let stock:AlbumStockCD = try JSONDecoder().decode(AlbumStockCD.self, from: data)
            //MyCoreBack.shared.background.saveIfNeeded()
            //PersistenceController.shared.container.viewContext.saveIfNeeded()
            completion()
            return stock
           
        }catch{
            print(error)
        }
          return AlbumStockCD()
        }
}
