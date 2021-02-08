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
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
            VStack{
                Form{
                    CustomTextField(textValue: $viewModel.name, title: "Nombre")
                    CustomTextField(textValue: $viewModel.email, title: "Correo electrónico").keyboardType(.emailAddress)
                    CustomTextField(textValue: $viewModel.phoneNumber, title: "Teléfono")
                    Picker(selection: $viewModel.countrySelection, label: TextWithCustomFonts("País", customFont: CustomFont(type: .light, size: 16)).padding()) {
                        ForEach(0..<self.viewModel.countries.count, id: \.self) { index in
                            TextWithCustomFonts(self.viewModel.countries[index].name).tag(index)
                        }
                    }
                    Picker(selection: $viewModel.gender, label: TextWithCustomFonts("Genero", customFont: CustomFont(type: .light, size: 16))
                            .padding()) {
                        ForEach(0..<viewModel.genders.count) {
                            TextWithCustomFonts(self.viewModel.genders[$0]).tag($0)
                        }
                    }
                    DatePicker(selection: $viewModel.birthday, in: ...Date(), displayedComponents: .date){
                        TextWithCustomFonts("Fecha de nacimiento", customFont: CustomFont(type: .light, size: 16)).padding()
                    }
                    SecureTextField(textValue: $viewModel.password, title: "Contraseña")
                    SecureTextField(textValue: $viewModel.confirmPassword, title: "Confirmar contraseña")
                    RectangleBtn("Crear cuenta") {
                        viewModel.signUp()
                    }
                    .frame(height:40)
                    .padding(.vertical)
                }
            }
        }
        .onAppear{
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        }
        .navigationBarTitle("Crea una cuenta", displayMode: .inline)
    }
}

struct CreateNewAccount_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
