//
//  SongsUriViewModel.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 22/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class SongsUriViewModel: ObservableObject, ArionService {
    var tester:testeto = testeto()
    var apiSession: APIService
    @Published var uriResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    @Published var stockResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
    }
    func getUriReponse() {
        let cancellable = self.getSongsURI()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    self.getStock()
                    break
                }
                
            }) { (response) in
                self.uriResponse = response
        }
        cancellables.insert(cancellable)
    }
    func getStock(){
        tester.getUri(catalogUri: self.uriResponse.catalogURI)
        
        
    }
    
    
   
}

