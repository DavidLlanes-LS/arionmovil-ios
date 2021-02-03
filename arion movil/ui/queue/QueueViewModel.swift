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
    
    @Published var songs = [TitleInQueue]()
    @Published var showLoader: Bool = false
    @Published var costCredits: Int = 0
    @Published var showAlert: Bool = false
    
    var playerId = UserDefaults.standard.string(forKey: Constants.keyPlayerId)
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
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
    
    func addQueue(body: AddQueue) {
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
                        UserDefaults.standard.set(false, forKey: Constants.keyIsAuth)
                    }
                    self.getQueue()
                }
            }
        cancellables.insert(cancellable)
    }
}
