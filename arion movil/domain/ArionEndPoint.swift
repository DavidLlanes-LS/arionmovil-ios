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
               request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = body.getDic().percentEncoded()
               
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
    
    
}





