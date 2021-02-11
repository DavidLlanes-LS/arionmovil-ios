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
    @Published var username: String = ""
    @Published var errorUsername:String = ""
    @Published var password:String = ""
    @Published var errorPassword:String = ""
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
    }
    
    func signIn(handle: @escaping(_ result: Int?, _ error: Error?) -> Void) {
        let cancellable = self.postSignIn(body: ["Email": username, "Password": password])
            .sink(receiveCompletion: { result in
                switch result {
                    case .failure(let error):
                        print("Handle error \(error)")
                        handle(nil, error)
                        self.showLoader = false
                    case .finished:
                        print("Response \(result)")
                        self.showLoader = false
                        break
                }
            }, receiveValue: { (result) in
                handle(result.status, nil)
                UserDefaults.standard.set(result.userId, forKey: Constants.keyUserId)
                UserDefaults.standard.set(true, forKey: Constants.keyIsAuth)
                UserDefaults.standard.set(result.userName, forKey: Constants.keyUserName)
            })
        
        cancellables.insert(cancellable)
    }
    
    func isFormValid()->Bool {
        if (!username.isEmpty && username.isValidEmail && !password.isEmpty) {
            return true
        }
        runValidators()
        return false
    }
    
    private var usernameRequiredPublisher: AnyPublisher<(username: String, isValid: Bool), Never> {
        return $username
            .map { (username: $0, isValid: !$0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    private var usernameValidPublisher: AnyPublisher<(username: String, isValid: Bool), Never> {
        return usernameRequiredPublisher
            .filter { $0.isValid }
            .map { (username: $0.username, isValid: $0.username.isValidEmail) }
            .eraseToAnyPublisher()
    }
    
    private var passworValidPublisher: AnyPublisher<(password: String, isValid:Bool), Never> {
        return $password
            .map { (password: $0, isValid: !$0.isEmpty ) }
            .eraseToAnyPublisher()
    }
    
    func runValidators() {
        usernameRequiredPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe ingresar un email válido."}
            .assign(to: \.errorUsername, on: self)
            .store(in: &cancellables)
        
        usernameValidPublisher
            .receive(on: RunLoop.main)
            .map { ($0.isValid ? "" : "Debe ingresar un email válido.") }
            .assign(to: \.errorUsername, on: self)
            .store(in: &cancellables)
        
        passworValidPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe ingresar un password válido." }
            .assign(to: \.errorPassword, on: self)
            .store(in: &cancellables)
    }
    
    func disableButton()->Bool {
        return username.isEmpty || password.isEmpty
    }
}

extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format: "SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
}
