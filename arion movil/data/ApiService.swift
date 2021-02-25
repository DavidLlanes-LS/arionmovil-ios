//
//  ApiService.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Combine

protocol APIService {
    func request<T: Decodable>(with builder: URLRequest) -> AnyPublisher<T, APIError>
}
enum APIError: Error {
  
    case decodingError
    case httpError(Int)
       
    case unknown
    
    func get() -> Int{
            switch self {
            case .httpError(let num):
                return num
            default:
            return 10000
            }
    
        }
}
