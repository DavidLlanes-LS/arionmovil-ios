//
//  MusicListViewModel.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 22/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MusicListViewModel: ObservableObject, ArionService {

    var apiSession: APIService
    @Published var bch = [TitleInQueue]()
    
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
    }
    
    func getQueueList(longitude:String, latitude:String, playerId: String) {
        let cancellable = self.getSongsQueue(playerId: playerId)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
                
            }) { (branch) in
                self.bch = branch.titlesInQueue
        }
        cancellables.insert(cancellable)
    }
   
}

