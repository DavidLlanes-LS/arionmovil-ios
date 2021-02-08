//
//  ArionEndPoint.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation

class ApiRequest{
   
    func getBranches(longitude:String, latitude: String)->URLRequest{
        var urlRequest: URLRequest{
            let urlRequest:String="http://acsstaging.cloudapp.net/api/amcm/business/get-closest-locations?Latitude=\(latitude)&Longitude=\(longitude)"
            guard let url = URL(string:urlRequest )
                else {preconditionFailure("Invalid URL format")}
            //print("branchesRequest: \(urlRequest)")
            let request = URLRequest(url: url)
            return request
        }
        return urlRequest
    }
    
    func postQueue(body: AddQueue)->URLRequest{
           var urlRequest: URLRequest{
                let urlRequest:String="http://acsstaging.cloudapp.net/api/amcm/queue/modify-queue"
                guard let url = URL(string:urlRequest )
                   else {preconditionFailure("Invalid URL format")}
                // print("branchesRequest: \(urlRequest)")
                var request = URLRequest(url: url)
            
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue(UserDefaults.standard.string(forKey: Constants.keyCookie), forHTTPHeaderField: "Cookie")
                
                let bodyData = try? JSONSerialization.data(withJSONObject: body.getDic(), options: [])
                request.httpBody = bodyData
                request.httpMethod = "POST"
               
                return request
           }
           return urlRequest
    }
    
    func postSingIn(body: [String:Any])->URLRequest{
        var urlRequest:URLRequest{
            let urlReq: String = "http://acsstaging.cloudapp.net/api/amcm/auth/sign-in"
            guard let url = URL(string: urlReq)
                else {preconditionFailure("Invalid URL format")}
            var request = URLRequest(url: url)
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = bodyData
            request.httpMethod = "POST"
           
            return request
        }
        

        return urlRequest
    }
    
    func getCountries()->URLRequest{
        var urlRequest:URLRequest{
            let urlRequest:String = "http://acsstaging.cloudapp.net/api/amcm/countries/get-all"
            guard let url = URL(string: urlRequest)
                else {preconditionFailure("Invalid URL format")}
            let request = URLRequest(url: url)
            
            return request
        }
        
        return urlRequest
    }
    
    func postSignUP(body: SignUpBody)->URLRequest{
        var urlRequest:URLRequest{
            let urlRequest:String = "http://acsstaging.cloudapp.net/api/amcm/users/register-user"
            guard let url = URL(string: urlRequest)
                else { preconditionFailure("Invalid URL format") }
            var request = URLRequest(url: url)
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print("body: \(body.getDic())")
            
            let bodyData = try? JSONSerialization.data(withJSONObject: body.getDic(), options: [])
            request.httpBody = bodyData
            request.httpMethod = "POST"
           
            return request
        }
        return urlRequest
    }
    
    func getSongQueue(playerId: String)->URLRequest{
        var urlRequest: URLRequest{
            let urlRequest:String="http://acsstaging.cloudapp.net/api/amcm/queue/get-queue/\(playerId)"
            guard let url = URL(string:urlRequest )
                else {preconditionFailure("Invalid URL format")}
           // print("branchesRequest: \(urlRequest)")
            let request = URLRequest(url: url)
            
            return request
        }
        return urlRequest
    }
    
    func getSongsList(branchId:String)->URLRequest{
        var urlRequest: URLRequest{
            let urlRequest:String="http://acsstaging.cloudapp.net/api/amcm/playlists/get-playlists-catalog/\(branchId)"
            guard let url = URL(string:urlRequest )
                else {preconditionFailure("Invalid URL format")}
            //print("songsRequest: \(branchId)")
            let request = URLRequest(url: url)
            return request
        }
        return urlRequest
    }
    
    func getBranchPrice(branchId:String)->URLRequest{
           var urlRequest: URLRequest{
               let urlRequest:String="http://acsstaging.cloudapp.net/api/amcm/credits/get-location-base-price/\(branchId)"
               guard let url = URL(string:urlRequest )
                   else {preconditionFailure("Invalid URL format")}
               //print("songsRequest: \(branchId)")
               let request = URLRequest(url: url)
               return request
           }
           return urlRequest
       }


}





