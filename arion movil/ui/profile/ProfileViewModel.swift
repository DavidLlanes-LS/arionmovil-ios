//
//  ProfileViewModel.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 09/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject, ArionService {
    var apiSession: APIService
  
    @Published var transactionsList:[Transaction] = []
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
      
    }
    func getHistory() {
        
        let cancellable = self.getPurchasesList()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    
                case .finished:
                    
                    break
                }
            }) { (response) in
                
                self.transactionsList = response.transactions!
                print("historial5",response.transactions?.count)
            }
        cancellables.insert(cancellable)
    }
}
