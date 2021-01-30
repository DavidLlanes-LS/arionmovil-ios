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
    
    
    func getSongQueue()->URLRequest{
        var urlRequest: URLRequest{
            let urlRequest:String="http://acsstaging.cloudapp.net/api/amcm/queue/get-queue/dd0c41af-1cec-431c-a2b4-37102be058e2"
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





