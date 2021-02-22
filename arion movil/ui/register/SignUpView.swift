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
    @EnvironmentObject var appSettings: AppHelper
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
    var alertError: Alert {
        Alert(
            title: Text(String("Error")),
            message: Text(String("Se ha producido un error al registrar el usuario.")),
            dismissButton: .default(Text(String("Iniciar sesión"))) {
                self.presentationMode.wrappedValue.dismiss()
            }
        )
    }
    
    @State var showSuccess:Bool = false
    @State var result:Int = -1
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
            ScrollView{
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "Nombre",
                        customFont:
                            CustomFont(type: .bold, size: Constants.sizeTextCaption),
                        color: .white, font: .caption
                    )
                    RoundedTextField(textValue: $viewModel.name, title: "Nombre", textError: viewModel.errorName,transparent: false)
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "Correo electrónico",
                        customFont:
                            CustomFont(type: .bold, size: Constants.sizeTextCaption),
                        color: .white, font: .caption
                    )
                    RoundedTextField(textValue: $viewModel.email, title: "Correo electrónico", textError: viewModel.errorEmail,transparent: false).keyboardType(.emailAddress).autocapitalization(.none)
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "Teléfono",
                        customFont:
                            CustomFont(type: .bold, size: Constants.sizeTextCaption),
                        color: .white, font: .caption
                    )
                    RoundedTextField(textValue: $viewModel.phoneNumber, title: "Teléfono", textError: viewModel.errorPhoneNumber,transparent: false).keyboardType(.phonePad)
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "País",
                        customFont:
                            CustomFont(type: .bold, size: Constants.sizeTextCaption),
                        color: .white, font: .caption
                    )
                    PickerRounded(selection: $viewModel.countrySelection, title: "Seleccionar", data: viewModel.countries, textError: viewModel.errorCountry, transparent: false)
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "Genero",
                        customFont:
                            CustomFont(type: .bold, size: Constants.sizeTextCaption),
                        color: .white, font: .caption
                    )
                    PickerRounded(selection: $viewModel.gender, title: "Seleccionar", data: viewModel.genders, textError: viewModel.errorGender, transparent: false)
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "Fecha de nacimiento",
                        customFont:
                            CustomFont(type: .bold, size: Constants.sizeTextCaption),
                        color: .white, font: .caption
                    )
                    DatePickerRounded(dateSelection: $viewModel.birthday, title: "Seleccionar", textError: viewModel.errorBirthday, transparent: false)
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "Contraseña",
                        customFont:
                            CustomFont(type: .bold, size: Constants.sizeTextCaption),
                        color: .white, font: .caption
                    )
                    SecureTextField(textValue: $viewModel.password, title: "Contraseña", textError: viewModel.errorPassword,transparent: false)
                }.padding(.horizontal)
                VStack(alignment: .leading) {
                    TextWithCustomFonts(
                        "Confirmar contraseña",
                        customFont:
                            CustomFont(type: .bold, size: Constants.sizeTextCaption),
                        color: .white, font: .caption
                    )
                    SecureTextField(textValue: $viewModel.confirmPassword, title: "Confirmar contraseña", textError: viewModel.errorConfirmPassword,transparent: false)
                }.padding(.horizontal)
                
                RectangleBtn("Crear cuenta") {
                    if self.viewModel.isFormValid() {
                        self.viewModel.signUp() { result, error in
                            if (error != nil) {
                                self.showSuccess = true
                                self.result = -1
                            }
                            if (result != nil) {
                                switch result {
                                case 0:
                                    self.showSuccess = true
                                    self.result = result!
                                    break
                                case 1:
                                    self.showSuccess = true
                                    self.result = result!
                                    break
                                default:
                                    self.showSuccess = true
                                    self.result = result!
                                    break
                                }
                            }
                        }
                    }
                }
                .disabled(viewModel.disableButton())
                .frame(height:40)
                .padding()
            }
            .padding(.vertical)
        }
        .alert(isPresented: $showSuccess, content: {
            switch (result) {
            case 0:
                return alertSuccess
            case 1:
                return alertEmailAlreadyExist
            default:
                return alertError
            }
        }
        )
        
        .navigationBarTitle(String("Nueva cuenta"), displayMode: .inline).onAppear{
            viewModel.appSettings = appSettings
        }
    }
}

struct CreateNewAccount_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
