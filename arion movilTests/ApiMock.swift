//
//  ApiMock.swift
//  arion movilTests
//
//  Created by David Israel Llanes Ordaz on 24/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
@testable import arion_movil
import Combine
class MockAPIService: APIService{
    public var inputRequest: URLRequest?
    var requestCalled = true
    let decoder = JSONDecoder()
    var succes = false
    func request<T>(with builder: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        requestCalled = true
        inputRequest = builder
//
        if succes {
            return Fail(error: APIError.httpError(0)).eraseToAnyPublisher()
        }
        else{
            return Fail(error: APIError.httpError(1)).eraseToAnyPublisher()
        }
       
//        return Just(builder as! T).mapError {_ in .decodingError}
//            .eraseToAnyPublisher()
    }
   
    

}
