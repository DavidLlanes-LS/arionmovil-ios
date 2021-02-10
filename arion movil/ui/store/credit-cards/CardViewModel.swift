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
    var appSettings:AppHelper?
    var hasDeleted:Bool = false
    @Published var showLoader:Bool = false
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        
    }
    
    
    func addCard(body: AddCardBody, onSuccess:@escaping ()->(),onFail:@escaping ()->()) {
        
        let cancellable = self.postAddCard(body: body)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.showLoader = false}
                    onFail()
                case .finished:
                    
                    break
                }
            }) { (result) in
                DispatchQueue.main.async {
                   
                   
                    if result.resultCode == 0 {
                        onSuccess()
                        self.getCreditList()
                    }
                    else{
                        onFail()
                    }
                    
                }
            }
        cancellables.insert(cancellable)
    }
    func deleteCard(cardId:String) {
        let body:DeleteCardBody = DeleteCardBody(cardId: cardId)
        let cancellable = self.postDeleteCard(body: body)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                   
                case .finished:
                    
                    break
                }
            }) { (result) in
                DispatchQueue.main.async {
                    print("openpay",result)
                }
                self.hasDeleted = true
                self.getCreditList()
                
            }
        cancellables.insert(cancellable)
    }
    
    func getCreditList() {
        DispatchQueue.main.async {
            if(!self.hasDeleted)
            {
                self.showLoader = true
            }
            }
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
                if self.appSettings != nil
                    {
                   
                        if list.cards != nil {
                            self.appSettings?.payCards = list.cards!
                        }
                        
                    
                    }
                
            }
        cancellables.insert(cancellable)
    }
}
