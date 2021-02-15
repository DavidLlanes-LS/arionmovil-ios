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
    @Published var isLoading:Bool = false
    @Published var transactionsList:[Transaction] = []
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
      
    }
    func getHistory() {
        self.isLoading.toggle()
        let cancellable = self.getPurchasesList()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.isLoading.toggle()
                    print("Handle error: \(error)")
                    
                case .finished:
                    
                    break
                }
            }) { (response) in
                self.isLoading.toggle()
                if response.transactions != nil{
                    self.transactionsList = response.transactions!
                   
                }
               
            }
        cancellables.insert(cancellable)
    }
    
    func changeProfile(body:ChangeProfileBody,onSuccess:@escaping (_:String)->(),onFail:@escaping (_:String)->()) {
        
        let cancellable = self.postChangeProfile(body: body)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    
                case .finished:
                    
                    break
                }
            }) { (response) in
                switch response.result{
                case 0:
                    onSuccess(Constants.succesChangeMsg)
                case 1:
                    onFail(Constants.emailExistsMsg)
                case 2:
                    onFail(Constants.wrongCredentialMsg)
                case 3:
                    onFail(Constants.generalChangeErrorMsg)
                default:
                    onFail(Constants.generalChangeErrorMsg)
                }
              
                print("cambio",response)
               
            }
        cancellables.insert(cancellable)
    }
}
