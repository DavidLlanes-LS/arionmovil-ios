//
//  CreateNewAccount.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 10/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct CreateNewAccount: View {
    @State var name:String = ""
    @State var email:String = ""
    @State var phone:String = ""
    @State var country:String = ""
    @State var birthday:Date = Date()
    @State var password:String = ""
    @State var gender = 0
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
            
            VStack{
                TextWithCustomFonts("Crea una cuenta", customFont: CustomFont(type: .bold, size: 22),color: .white)
               Form{
                    CustomTextField(textValue: self.$name, title: "Nombre", color: .white)
                    CustomTextField(textValue: self.$email, title: "Correo electrónico", color: .white)
                    CustomTextField(textValue: self.$phone, title: "Teléfono", color: .white)
                    CustomTextField(textValue: self.$country, title: "País", color: .white)
                    CustomTextField(textValue: self.$password, title: "Contraseña", color: .white)
                    HStack{
                        TextWithCustomFonts("Genero", customFont: CustomFont(type: .bold, size: 16),color: .white)
                        Picker(selection: $gender, label: Text("Genero")) {
                           TextWithCustomFonts("Masculino").tag(0)
                           TextWithCustomFonts("Femenino").tag(1)
                       }.pickerStyle(SegmentedPickerStyle())
                    }
                   DatePicker(selection: self.$birthday, in: ...Date(), displayedComponents: .date){
                       TextWithCustomFonts("Fecha de nacimiento", customFont: CustomFont(type: .bold, size: 16), color: .white)
                   }
               }
                RectangleBtn("Crear cuenta"){
                    
                }.frame(width:180,height:40)
            }.padding([.top, .bottom], 64)
        }.onAppear{
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CreateNewAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewAccount()
    }
}
