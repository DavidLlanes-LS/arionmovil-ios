//
//  BrnchesViewModel.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class BranchesListViewModel: ObservableObject, ArionService {

    var apiSession: APIService
    @Published var branch = [Location]()
    @Published var showLoader:Bool = false
    
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
    }
    func getBranchesList(longitude:String, latitude:String, finish:@escaping ()->()={}) {
        DispatchQueue.main.async {
            self.showLoader = true
        }
       
        let cancellable = self.getBranchesList(latitude:latitude, longitude: longitude)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    self.showLoader = false
                case .finished:
                    self.showLoader = false
                    break
                }
                

            }) { (branch) in
                finish()
                self.branch = branch.locations
        }
        cancellables.insert(cancellable)
    }
   
}
