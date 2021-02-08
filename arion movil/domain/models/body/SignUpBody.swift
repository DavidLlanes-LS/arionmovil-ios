//
//  SignUpBody.swift
//  arion movil
//
//  Created by Daniel Luna on 05/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

public struct SignUpBody{
    var email: String
    var name: String
    var password: String
    var countryId: String
    var birthday: Date
    var gender: Int
    var phoneNumber: String
    
    func dateFormat()->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.string(from: birthday)
    }
    
    func getDic() -> [String:Any] {
        return [
            "Email": email,
            "Name": name,
            "Password": password,
            "CountryId": countryId,
            "Birthday": dateFormat(),
            "Gender": gender,
            "PhoneNumber": phoneNumber
        ]
    }
}
