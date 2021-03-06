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
    func getPackagesList(branchid:String) -> AnyPublisher<CreditPackagesResponse, APIError> {
        return apiSession.request(with: ApiRequest().getPackagesList(branchId: branchid))
            .eraseToAnyPublisher()
    }
    func getPurchasesList() -> AnyPublisher<PurchasesHistoryResponse, APIError> {
        return apiSession.request(with: ApiRequest().getPurchasesHistory())
            .eraseToAnyPublisher()
    }
    
    func getSongsURI(branchid:String) -> AnyPublisher<SongsUriResponse, APIError> {
        return apiSession.request(with: ApiRequest().getSongsList(branchId: branchid))
            .eraseToAnyPublisher()
    }
    func getCreditCards() -> AnyPublisher<CardListResponse, APIError> {
        return apiSession.request(with: ApiRequest().getRegisteredCards())
            .eraseToAnyPublisher()
    }
    func getUserCredit() -> AnyPublisher<UserCreditsResponse, APIError> {
        return apiSession.request(with: ApiRequest().getUserCredits())
            .eraseToAnyPublisher()
    }
    func getBranchPrice(branchid:String) -> AnyPublisher<BranchPriceResponse, APIError> {
        return apiSession.request(with: ApiRequest().getBranchPrice(branchId: branchid))
            .eraseToAnyPublisher()
    }
    
    func postAddSongsQueue(body: AddQueue) -> AnyPublisher<ModifyQueueResultCode, APIError> {
        return apiSession.request(with: ApiRequest().postQueue(body: body))
            .eraseToAnyPublisher()
    }
    func postAddCard(body: AddCardBody) -> AnyPublisher<AddCardResultCode, APIError> {
           return apiSession.request(with: ApiRequest().postAddCard(body: body))
            .eraseToAnyPublisher()
       }
    func postChangeProfile(body: ChangeProfileBody) -> AnyPublisher<ChangeProfileResponse, APIError> {
        return apiSession.request(with: ApiRequest().postChangeProfile(body: body))
            .eraseToAnyPublisher()
       }
    func postBuyCredits(body: BuyCreditsBody) -> AnyPublisher<AddCardResultCode, APIError> {
           return apiSession.request(with: ApiRequest().postBuyPackage(body: body))
            .eraseToAnyPublisher()
       }
    
    func postDeleteCard(body: DeleteCardBody) -> AnyPublisher<AddCardResultCode, APIError> {
        return apiSession.request(with: ApiRequest().postDeleteCard(body: body))
            .eraseToAnyPublisher()
       }
    
    func postSignIn(body: [String:Any]) -> AnyPublisher<SignInResponse, APIError> {
        return apiSession.request(with: ApiRequest().postSingIn(body: body))
            .eraseToAnyPublisher()
    }
    
    func postSignUp(body: SignUpBody) -> AnyPublisher<SignUpResponse, APIError> {
        return apiSession.request(with: ApiRequest().postSignUP(body: body))
            .eraseToAnyPublisher()
    }
    
    func getCountries()-> AnyPublisher<CountriesResponse,APIError> {
        return apiSession.request(with: ApiRequest().getCountries())
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
