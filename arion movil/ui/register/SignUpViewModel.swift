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
    @Published var errorEmail:String = ""
    @Published var name: String = ""
    @Published var errorName:String = ""
    @Published var password:String = ""
    @Published var errorPassword:String = ""
    @Published var confirmPassword:String = ""
    @Published var errorConfirmPassword:String = ""
    @Published var countrySelection:Int = -1
    @Published var errorCountry:String = ""
    @Published var countries: [Country] = []
    @Published var birthday:Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    @Published var errorBirthday:String = ""
    @Published var gender = -1
    @Published var errorGender:String = ""
    @Published var phoneNumber:String = ""
    @Published var errorPhoneNumber:String = ""
    @Published var appSettings:AppHelper?
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
                let sortedCountries = response.countries.sorted {
                    $0.name < $1.name
                }
                self.countries = sortedCountries
            })
        cancellables.insert(cancellable)
    }
    
    func signUp(handle: @escaping(_ result: Int?, _ error: Error?) -> Void) {
        let cancellable = self.postSignUp(body: SignUpBody(email: email, name: name, password: password, countryId: countries[countrySelection].id, birthday: birthday, gender: gender, phoneNumber: phoneNumber))
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error \(error)")
                    DispatchQueue.main.async {
                        handle(nil, error)
                    }
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                DispatchQueue.main.async {
                    handle(response.resultCode, nil)
                }
            })
        cancellables.insert(cancellable)
    }
    
    func disableButton()->Bool {
        return name.isEmpty || email.isEmpty || phoneNumber.isEmpty || countrySelection < -1 || gender < -1 || password.isEmpty || confirmPassword.isEmpty
    }
    
    func isFormValid()->Bool {
        if (!name.isEmpty && !email.isEmpty && email.isValidEmail && countrySelection > -1 && gender > -1 && !password.isEmpty && password.count > 5 && confirmPassword == password) {
            return true
        }
        runWatchers()
        return false
    }
    
    func runWatchers() {
        nameRequiredPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe ingresar un nombre" }
            .assign(to: \.errorName, on: self)
            .store(in: &cancellables)
        
        emailRequiredPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe ingresar un email válido."}
            .assign(to: \.errorEmail, on: self)
            .store(in: &cancellables)
        
        emailValidPublisher
            .receive(on: RunLoop.main)
            .map { ($0.isValid ? "" : "Debe ingresar un email válido.") }
            .assign(to: \.errorEmail, on: self)
            .store(in: &cancellables)
        
        phoneRequiredPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe ingresar un teléfono" }
            .assign(to: \.errorPhoneNumber, on: self)
            .store(in: &cancellables)
        
        phoneValidPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" :  "Debe ingresar un teléfono valido" }
            .assign(to: \.errorPhoneNumber, on: self)
            .store(in: &cancellables)
        
        countryRequiredPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe seleccionar un país" }
            .assign(to: \.errorCountry, on: self)
            .store(in: &cancellables)
        
        genderRequiredPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe seleccionar tu genero" }
            .assign(to: \.errorGender, on: self)
            .store(in: &cancellables)
        
        passwordRequiredPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe ingresar un password" }
            .assign(to: \.errorPassword, on: self)
            .store(in: &cancellables)
        
        passwordValidPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Debe ingresar un password válido mayor a 6 caracteres" }
            .assign(to: \.errorPassword, on: self)
            .store(in: &cancellables)
        
        confirmPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Las contraseñas no coincide" }
            .assign(to: \.errorConfirmPassword, on: self)
            .store(in: &cancellables)
        
    }
    
    private var nameRequiredPublisher: AnyPublisher<(name: String, isValid: Bool), Never> {
        return $name
            .map { (name: $0, isValid: !$0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    private var emailRequiredPublisher: AnyPublisher<(email: String, isValid: Bool), Never> {
        return $email
            .map { (email: $0, isValid: !$0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    private var emailValidPublisher: AnyPublisher<(email: String, isValid: Bool), Never> {
        return emailRequiredPublisher
            .filter { $0.isValid }
            .map { (email: $0.email, isValid: $0.email.isValidEmail) }
            .eraseToAnyPublisher()
    }
    
    private var phoneRequiredPublisher: AnyPublisher<(phone: String, isValid: Bool), Never> {
        return $phoneNumber
            .map{ (phone: $0, isValid: !$0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    private var phoneValidPublisher: AnyPublisher<(phone: String, isValid: Bool), Never> {
        return phoneRequiredPublisher
            .filter { $0.isValid }
            .map { (phone: $0.phone, isValid: $0.phone.count == 10) }
            .eraseToAnyPublisher()
    }
    
    private var countryRequiredPublisher:AnyPublisher<(countrySelection: Int, isValid:Bool), Never> {
        return $countrySelection
            .map { (countrySelection: $0, isValid: $0 > -1) }
            .eraseToAnyPublisher()
    }
    
    private var genderRequiredPublisher: AnyPublisher<(gender: Int, isValid:Bool), Never> {
        return $gender
            .map { (gender: $0, isValid: $0 > -1) }
            .eraseToAnyPublisher()
    }
    
    private var passwordRequiredPublisher: AnyPublisher<(password: String, isValid: Bool), Never> {
        return $password
            .map { (password: $0, isValid: !$0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    private var passwordValidPublisher: AnyPublisher<(password: String, isValid: Bool), Never> {
        return passwordRequiredPublisher
            .filter { $0.isValid }
            .map { (password: $0.password, isValid: $0.password.count > 5) }
            .eraseToAnyPublisher()
    }
    
    private var confirmPasswordValidPublisher: AnyPublisher<(confirmPass: String, isValid: Bool), Never> {
        return $confirmPassword
            .map { (confirmPass: $0, isValid: $0 == self.password) }
            .eraseToAnyPublisher()
    }
}

extension Int {
    var isValidSelection: Bool {
        return self > -1
    }
}
