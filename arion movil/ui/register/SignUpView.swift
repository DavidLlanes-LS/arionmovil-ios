//
//  CreateNewAccount.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 10/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var alertEmailAlreadyExist: Alert {
        Alert(
            title: Text(String("Atención")),
            message: Text(String("Esta dirección de correo ya existe.")),
            dismissButton: .default(Text(String("Cerrar"))) {
                
            }
        )
    }
    var alertSuccess: Alert {
        Alert(
            title: Text(String("Éxito")),
            message: Text(String("Se ha registrado correctamente, ahora puedes iniciar sesión.")),
            dismissButton: .default(Text(String("Iniciar sesión"))) {
                self.presentationMode.wrappedValue.dismiss()
            }
        )
    }
    
    @State var showSuccess:Bool = false
    @State var showErrorEmail: Bool = false
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
            VStack{
                Form{
                    RoundedTextField(textValue: $viewModel.name, title: "Nombre", textError: viewModel.errorName,transparent:true)
                    RoundedTextField(textValue: $viewModel.email, title: "Correo electrónico", textError: viewModel.errorEmail,transparent:true).keyboardType(.emailAddress).autocapitalization(.none)
                    RoundedTextField(textValue: $viewModel.phoneNumber, title: "Teléfono", textError: viewModel.errorPhoneNumber,transparent:true)
                    PickerRounded(selection: $viewModel.countrySelection, title: "País", data: viewModel.countries, textError: viewModel.errorCountry)
                    PickerRounded(selection: $viewModel.gender, title: "Genero", data: viewModel.genders, textError: viewModel.errorGender)
                    DatePickerRounded(dateSelection: $viewModel.birthday, title: "Fecha de nacimiento", textError: viewModel.errorBirthday)
                    SecureTextField(textValue: $viewModel.password, title: "Contraseña", textError: viewModel.errorPassword,transparent:true)
                    SecureTextField(textValue: $viewModel.confirmPassword, title: "Confirmar contraseña", textError: viewModel.errorConfirmPassword,transparent:true)
                    RectangleBtn("Crear cuenta") {
                        if self.viewModel.isFormValid() {
                            self.viewModel.signUp() { result, error in
                                if (error != nil) {
                                    
                                }
                                if (result != nil) {
                                    switch result {
                                    case 0:
                                        self.showSuccess = true
                                        break
                                    case 1:
                                        self.showErrorEmail = true
                                        break
                                    default:
                                        break
                                    }
                                }
                            }
                        }
                    }
                    .disabled(viewModel.disableButton())
                    .frame(height:40)
                    .padding(.vertical)
                }
            }
        }
        .alert(isPresented: $showErrorEmail, content: { alertEmailAlreadyExist })
        .alert(isPresented: $showSuccess, content: { alertSuccess })
        .onAppear{
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        }
        .navigationBarTitle(String("Nueva cuenta"), displayMode: .inline)
    }
}

struct CreateNewAccount_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
