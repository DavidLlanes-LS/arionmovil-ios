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
    @Published var verifyPasswordBinding:Binding<String>?
    @Published var newPasswordBinding:Binding<String>?
    @Published var newEmailBinding:Binding<String>?
    var cancellables = Set<AnyCancellable>()
   
    
    @Published var newEmail:String = ""
    @Published var newPassword:String = ""
    @Published var verifyPassword:String = ""
    @Published var currentPassword:String = ""
    @Published var responseMessage:String = ""
    @Published var errorVerifyMessage:String = ""
    @Published var errorVerifyEmail:String = ""
    @Published var errorMinimumPassword:String = ""
    @Published var showAlert = false
    @Published var wasSucces = false

    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        
        
        verifyPasswordBinding = Binding<String>(get: {
            self.verifyPassword
        }, set: {
            self.verifyPassword = $0
            if  self.verifyPassword ==  self.newPassword {
                withAnimation{
                    self.errorVerifyMessage = ""
                }
            }
        })
        newPasswordBinding = Binding<String>(get: {
            self.newPassword
        }, set: {
            self.newPassword = $0
            if  self.newPassword ==  self.verifyPassword {
                withAnimation{
                    self.errorVerifyMessage = ""
                }
            }
            if  self.newPassword.count > 5 {
                self.errorMinimumPassword = ""
            }
        })
        newEmailBinding = Binding<String>(get: {
            self.newEmail
        }, set: {
            self.newEmail = $0
            if  self.newEmail.isValidEmail{
                withAnimation{
                    self.errorVerifyEmail = ""
                }
                
            }
        })
        
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
    
    func changeProfileRequest(body:ChangeProfileBody,onSuccess:@escaping (_:String)->(),onFail:@escaping (_:String)->()) {
        currentPassword = ""
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
    
    func changeProfile(){
        var options:Int = Constants.changePasswordAndEmailOption
        // MARK: - Just Email change
        if currentPassword.isEmpty{
            if newEmail.isValidEmail {
                alertView()
            }
            else{
                withAnimation{
                    errorVerifyEmail = Constants.errorInvalidEmailsMsg
                }
            }
        }
        // MARK: - Just password change
        else if newEmail.isEmpty {
            options = Constants.changePasswordOption
            if newPassword.count > 5{
                if newPassword == verifyPassword {
                    errorVerifyMessage = ""
                    self.changeProfileRequest(body: ChangeProfileBody(options: options, newEmail: newEmail, currentPassword: currentPassword, newPassword: newPassword)) {message in
                        self.wasSucces.toggle()
                        self.responseMessage = message
                        self.showAlert.toggle()
                    } onFail: {message in
                        self.responseMessage = message
                        self.showAlert.toggle()
                    }
                    
                }
                else{
                    withAnimation{
                        errorVerifyMessage = Constants.missmatchPasswordsMsg
                    }
                }
            }
            else{
                errorMinimumPassword = Constants.errorMinCharactersPasswordMsg
            }
        }
        // MARK: - Password and email change
        else{
            if !newEmail.isValidEmail {
                withAnimation{
                    errorVerifyEmail = Constants.errorInvalidEmailsMsg
                }
            }
            if newPassword.count > 5 {
                if newPassword == verifyPassword {
                    errorVerifyMessage = ""
                    self.changeProfileRequest(body: ChangeProfileBody(options: options, newEmail: newEmail, currentPassword: currentPassword, newPassword: newPassword)) {message in
                        self.wasSucces.toggle()
                        self.responseMessage = message
                        self.showAlert.toggle()
                    } onFail: {message in
                        self.responseMessage = message
                        self.showAlert.toggle()
                    }
                    
                }
                else{
                    withAnimation{
                        errorVerifyMessage = Constants.missmatchPasswordsMsg
                    }
                }
            }
            else{
                errorMinimumPassword = Constants.errorMinCharactersPasswordMsg
            }
        }
        
        
    }
    
    func alertView(){
        let alert = UIAlertController(title: "Atención", message: "Por favor ingresa tu contraseña para continuar", preferredStyle: .alert)
        alert.addTextField{text in
            text.isSecureTextEntry = true
            text.placeholder = "Contraseña"
            
            
        }
        let loging = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            self.currentPassword = alert.textFields![0].text!
            self.changeProfileRequest(body: ChangeProfileBody(options: Constants.changeEmailOption, newEmail: self.newEmail, currentPassword: self.currentPassword, newPassword: self.newPassword)) {message in
                self.wasSucces.toggle()
                self.responseMessage = message
                self.showAlert = true
            } onFail: {message in
                self.responseMessage = message
                self.showAlert = true
            }
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive) { (_) in
            
        }
        alert.addAction(cancel)
        alert.addAction(loging)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            
        })
    }
}
