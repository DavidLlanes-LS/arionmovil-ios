//
//  CardViewModel.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 05/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
class CardViewModel: ObservableObject, ArionService {
    var apiSession: APIService
    @Published var creditCards:[CreditCard] = []
    @Published var showLoader:Bool = false
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        
    }
    
    
    func addQueue(body: AddCardBody) {
        let cancellable = self.postAddCard(body: body)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("openpayError: \(error.localizedDescription)")
                   
                case .finished:
                    
                    break
                }
            }) { (result) in
                DispatchQueue.main.async {
                    print("openpay",result)
                }
            }
        cancellables.insert(cancellable)
    }
    
    func getCreditList() {
        DispatchQueue.main.async {
            self.showLoader = true}
        let cancellable = self.getCreditCards()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    self.showLoader = false
                case .finished:
                    
                    break
                }
                

            }) { (list) in
                self.showLoader = false
                if list.cards != nil {
                    self.creditCards = list.cards!}
        }
        cancellables.insert(cancellable)
    }
}
