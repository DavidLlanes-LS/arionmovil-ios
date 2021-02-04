//
//  LoginViewModel.swift
//  arion movil
//
//  Created by Daniel Luna on 02/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel:ObservableObject,ArionService {
    
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    
    @Published var showLoader: Bool = false
    @Published var username: String = "dluna@lumston.com"
    @Published var password: String = "123456"
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
    }
    
    func signIn(handle: @escaping(_ result: Int) -> Void) {
        let cancellable = self.postSignIn(body: ["Email": username, "Password": password])
            .sink(receiveCompletion: { result in
                switch result {
                    case .failure(let error):
                        print("Handle error \(error)")
                        self.showLoader = false
                    case .finished:
                        print("Response \(result)")
                        self.showLoader = false
                        break
                }
            }, receiveValue: { (result) in
                handle(result.status)
                UserDefaults.standard.set(result.userId, forKey: Constants.keyUserId)
                UserDefaults.standard.set(true, forKey: Constants.keyIsAuth)
            })
        
        cancellables.insert(cancellable)
    }
}
