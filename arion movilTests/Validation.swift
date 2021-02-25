//
//  Validation.swift
//  arion movilTests
//
//  Created by David Israel Llanes Ordaz on 23/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import XCTest
import Foundation
import Combine
@testable import arion_movil
class Validation: XCTestCase,ArionService {
    var apiSession: APIService = MockAPIService()
    var cancellables = Set<AnyCancellable>()
   
    func testReceiveBranchesSuccess(){
        let expectation = self.expectation(description: "Scaling")
       let viewmodel = BranchesListViewModel()
        viewmodel.getBranchesList(longitude: "-103.33270", latitude: "20.62753"){
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(viewmodel.branch.count > 0 )
    }
    func testReceiveBranchesFail(){
        let expectation = self.expectation(description: "Scaling")
       let viewmodel = BranchesListViewModel()
        viewmodel.getBranchesList(longitude: "0", latitude: "0"){
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(viewmodel.branch.count <= 0 )
    }
    
    func testLoginSuccess(){
        var result2 = 30
       let viewmodel = LoginViewModel()
        viewmodel.username = "dllanes@lumston.com"
        viewmodel.password = "123456"
        let expectation2 = self.expectation(description: "Scaling")
        viewmodel.signIn() { (result, error) in
            result2 = result!
            expectation2.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(result2 == 1 )
        
       
    }
    func testLoginFail(){
        var result2:Int? = 30
       let viewmodel = LoginViewModel()
        viewmodel.username = "dllanes@lumston.com"
        viewmodel.password = "1234567"
        let expectation2 = self.expectation(description: "Scaling")
        viewmodel.signIn() { (result, error) in
          result2 = nil
        
            expectation2.fulfill()
        }
        waitForExpectations(timeout:5, handler: nil)
        XCTAssert(result2 == nil )
        
       
    }
    
    func testmockedLoginSuccess(){
        apiSession = MockAPIService()
        var success = false
        (apiSession as! MockAPIService).succes = true
        let cancellable = self.postSignIn(body: ["Email": "", "Password": ""])
            .sink(receiveCompletion: { result in
                switch result {
                
                case .failure(let error):
                    if (error as APIError).get() == 0 {
                        success = true
                    }
                    break
                case .finished:
                    break
                }
            }, receiveValue: { (result) in
            })
        cancellables.insert(cancellable)
        XCTAssertTrue(success)
        
        
    }
    
    func testmockedLoginFail(){
        apiSession = MockAPIService()
        var success = false
        (apiSession as! MockAPIService).succes = false
        let cancellable = self.postSignIn(body: ["Email": "", "Password": ""])
            .sink(receiveCompletion: { result in
                switch result {
                
                case .failure(let error):
                    if (error as APIError).get() == 0 {
                        success = true
                    }
                    break
                case .finished:
                    break
                }
            }, receiveValue: { (result) in
            })
        cancellables.insert(cancellable)
        XCTAssertTrue(!success)
    }
}
