//
//  SignUpViewModel.swift
//  arion movil
//
//  Created by Daniel Luna on 05/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class SignUpViewModel:ObservableObject,ArionService {
    @Published var email:String = ""
    @Published var name: String = ""
    @Published var password:String = ""
    @Published var confirmPassword:String = ""
    @Published var countrySelection:Int = -1
    @Published var countries: [Country] = []
    @Published var birthday:Date = Date()
    @Published var gender = -1
    @Published var phoneNumber:String = ""
    var genders = ["Otro", "Hombre", "Mujer"]
    
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.getCountries()
    }
    
    func getCountries() {
        let cancellable = self.getCountries()
            .sink(receiveCompletion: { result in
                
            }, receiveValue: { response in
                DispatchQueue.main.async {
                    let sortedCountries = response.countries.sorted {
                        $0.name < $1.name
                    }
                    self.countries = sortedCountries
                }
            })
        cancellables.insert(cancellable)
    }
    
    func signUp() {
        let cancellable = self.postSignUp(body: SignUpBody(email: email, name: name, password: password, countryId: countries[countrySelection].id, birthday: birthday, gender: gender, phoneNumber: phoneNumber))
            .sink(receiveCompletion: { result in
                
            }, receiveValue: { response in
                
            })
        cancellables.insert(cancellable)
    }
}
