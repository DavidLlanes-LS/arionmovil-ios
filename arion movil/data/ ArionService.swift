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
    
    func getSongsQueue(playerId:String) -> AnyPublisher<Titleslist, APIError> {
        return apiSession.request(with: ApiRequest().getSongQueue(playerId: playerId))
            .eraseToAnyPublisher()
    }
    
    func getSongsURI(branchid:String) -> AnyPublisher<SongsUriResponse, APIError> {
        return apiSession.request(with: ApiRequest().getSongsList(branchId: branchid))
            .eraseToAnyPublisher()
    }
    
    func postAddSongsQueue(body: AddQueue) -> AnyPublisher<ModifyQueueResultCode, APIError> {
        return apiSession.request(with: ApiRequest().postQueue(body: body))
            .eraseToAnyPublisher()
    }
    
    func postSignIn(body: [String:Any]) -> AnyPublisher<SignInResponse, APIError> {
        return apiSession.request(with: ApiRequest().postSingIn(body: body))
            .eraseToAnyPublisher()
    }
    
    func getStockUnzipped(branchId:String,catalogUri:String,completion: @escaping () -> () ){
        var file:Data = Data()
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
            
            self.saveStock(branchId:branchId,data: str.data(using: .utf8)!,completion: completion)
            
          
        }
       
    }
    
    private func saveStock(branchId:String,data:Data,completion: @escaping () -> ()){
        do{
            let decoder:JSONDecoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey(rawValue: "localId")!] = branchId
            let stock:AlbumStockCD = try decoder.decode(AlbumStockCD.self, from: data)
            MyCoreBack.shared.background.saveIfNeeded()
            PersistenceController.shared.container.viewContext.saveIfNeeded()
            completion()
            
           
        }catch{
            print(error)
        }
         
        }
}
