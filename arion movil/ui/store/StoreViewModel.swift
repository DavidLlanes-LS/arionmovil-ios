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
    @Published var banerDate = BannerData(title: "", detail: "", type: .info)
    @Published var pakcagesList:[Packages] = []
    @Published var isLoading:Bool = false
    @Published var credits:Int = 0
    @Published var showResult:Bool = false
    @Published var resultText:String = ""
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    var appSettings:AppHelper?
    
    var locationId = UserDefaults.standard.string(forKey: Constants.keyLocationId)
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
       
    }
    
    func getPackages() {
        isLoading.toggle()
        let cancellable = self.getPackagesList(branchid: locationId!)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    self.isLoading.toggle()
                case .finished:
                  
                    break
                }
            }) { (packages) in
                self.isLoading.toggle()
                DispatchQueue.main.async {
                    if packages.packages != nil
                    {
                        self.pakcagesList = packages.packages!
                    }
                    else{
                        self.pakcagesList = []
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
                
                switch result.resultCode{
                case 1:
                    self.resultText = String(Constants.succesPurchaseMsg)
                    self.banerDate.type = .success
                case 128:
                    self.resultText = String(Constants.declinedCardMsg)
                    self.banerDate.type = .error
                case 129:
                    self.resultText = String(Constants.expiredCardMsg)
                    self.banerDate.type = .error
                case 130:
                    self.resultText = String(Constants.foundLessCardMsg)
                    self.banerDate.type = .error
                case 136:
                    self.resultText = String(Constants.restrictedCardMsg)
                    self.banerDate.type = .error
                case 137:
                    self.resultText = String(Constants.retainedCardMsg)
                    self.banerDate.type = .error
                case 138:
                    self.resultText = String(Constants.needsBankAuthMsg)
                    self.banerDate.type = .error
                    
                default:
                    self.resultText = String(Constants.failPurchaseDefaultMsg)
                    self.banerDate.type = .error
                    
                }
                self.banerDate.title = self.resultText
                self.showResult.toggle()
               
                
                
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
