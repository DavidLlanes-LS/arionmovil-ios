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
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.getQueue()
    }
    
    func getQueue() {
        self.showLoader = true
        let cancellable = self.getSongsQueue()
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
                self.songs = queue.titlesInQueue
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
                self.getQueue()
            }
        cancellables.insert(cancellable)
    }
}
