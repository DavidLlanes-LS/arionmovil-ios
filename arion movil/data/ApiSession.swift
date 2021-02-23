//
//  ApiSession.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine

struct APISession: APIService {
    func request<T>(with builder: URLRequest) -> AnyPublisher<T, APIError> where T: Decodable {
        
        // json decoder instance
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared
            .dataTaskPublisher(for: builder)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                    // 6
                        
                        if (response.url?.absoluteString == "https://www.arioncloudx2.com/api/amcm/auth/sign-in") {
                            let cookieStorage = HTTPCookieStorage.shared
                            let cookies = cookieStorage.cookies(for: response.url!) ?? []
                            for cookie in cookies {
                                print("Cookie: \(cookie.name)=\(cookie.value)")
                                UserDefaults.standard.set("\(cookie.name)=\(cookie.value)", forKey: Constants.keyCookie)
                            }
                        }
                        
                        let body:String? = String(data: data, encoding: .utf8)
                        print("respuesta \(body!)")
                    return Just(data)
                        .decode(type: T.self, decoder: decoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                    } else {
                        print("respuesta error \(response.statusCode)")
                        return Fail(error: APIError.httpError(response.statusCode)).eraseToAnyPublisher()
                    }
                }
                return Fail(error: APIError.unknown)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
