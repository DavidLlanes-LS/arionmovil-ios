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
    @Published var isLoading:Bool = false
    @Published var credits:Int = 0
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    var appSettings:AppHelper?
    
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
                    if packages.packages != nil
                    {
                        self.pakcagesList = packages.packages!
                    }
                  
                }
            }
        cancellables.insert(cancellable)
    }
    func buyCredits(body: BuyCreditsBody) {
        self.isLoading = true
        let cancellable = self.postBuyCredits(body: body)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    self.isLoading = false
                case .finished:
                 
                    break
                }
            }) { (result) in
                print("comprar",result)
                self.getCreditsUser()
                self.isLoading = false
                
            }
        cancellables.insert(cancellable)
    }
    
    
    func getCreditsUser() {
        
        let cancellable = self.getUserCredit()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                   
                case .finished:
                  
                    break
                }
            }) { (result) in
                DispatchQueue.main.async {
                   print("comprar",result)
                    self.credits = result.creditsBalance
                    if self.appSettings != nil {
                        self.appSettings?.userCredits = result.creditsBalance
                    }
                }
            }
        cancellables.insert(cancellable)
    }
    
  
}
