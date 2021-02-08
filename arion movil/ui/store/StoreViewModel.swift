//
//  StoreViewModel.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 08/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class StoreViewModel: ObservableObject, ArionService {
    @Published var pakcagesList:[Packages] = []
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
   
   
    var locationId = UserDefaults.standard.string(forKey: Constants.keyLocationId)
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
       
    }
    
    func getPackages() {
        
        let cancellable = self.getPackagesList(branchid: locationId!)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                   
                case .finished:
                  
                    break
                }
            }) { (packages) in
                DispatchQueue.main.async {
                    self.pakcagesList = packages.packages!
                }
            }
        cancellables.insert(cancellable)
    }
    
  
}
