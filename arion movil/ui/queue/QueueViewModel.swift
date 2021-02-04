//
//  QueueViewModel.swift
//  arion movil
//
//  Created by Daniel Luna on 28/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

class QueueViewModel: ObservableObject, ArionService {
    
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    var branchPrice:BranchPriceResponse?
    @Published var songs = [TitleInQueue]()
    @Published var showLoader: Bool = false
    @Published var costCredits: Int = 0
    @Published var showAlert: Bool = false
    
    var playerId = UserDefaults.standard.string(forKey: Constants.keyPlayerId)
    var locationId = UserDefaults.standard.string(forKey: Constants.keyLocationId)
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        getActualBranchPrice()
    }
    
    func getQueue() {
        self.showLoader = true
        let cancellable = self.getSongsQueue(playerId: playerId!)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    self.showLoader = false
                case .finished:
                    self.showLoader = false
                    break
                }
            }) { (queue) in
                DispatchQueue.main.async {
                    self.songs = queue.titlesInQueue
                }
            }
        cancellables.insert(cancellable)
    }
    
    func addQueue(body: AddQueue, handle: @escaping(_ result: Int?, _ error: Bool?) -> Void) {
        self.showLoader = true
        let cancellable = self.postAddSongsQueue(body: body)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    self.showLoader = false
                case .finished:
                    self.showLoader = false
                    break
                }
            }) { (result) in
                DispatchQueue.main.async {
                    if (result.authMessage != nil) {
                        handle(nil, true)
                    } else {
                        handle(result.resultCode, nil)
                        self.getQueue()
                    }
                }
            }
        cancellables.insert(cancellable)
    }
    func getActualBranchPrice() {
        self.showLoader = true
        let cancellable = self.getBranchPrice(branchid: locationId!)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    self.showLoader = false
                case .finished:
                    self.showLoader = false
                    break
                }
            }) { (price) in
                
                self.branchPrice = price
                
            }
        cancellables.insert(cancellable)
    }
    func addNewQueue(id:String){
        let userId = UserDefaults.standard.string(forKey: Constants.keyUserId)
        print("branchprice",branchPrice!.basePrice)
        if userId != nil
        { self.addQueue(body: AddQueue(userId: userId!, locationId: self.locationId!, playerId: self.playerId!, mediaTitleId: id, creditsToCharge: branchPrice!.basePrice, positionToAdvance: -1)){result, error in}}
        
    }
}
