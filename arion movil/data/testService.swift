//
//  testService.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 21/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import Alamofire
import Gzip
import Combine
class testeto{
    
    enum APIError: Error {
        case decodingError
        case httpError(Int)
        case unknown
    }
    var file:Data = Data()
    func getData(){
        let url = URL(string: "http://acsstaging.cloudapp.net/api/amcm/business/get-closest-locations?Latitude=20.62753&Longitude=-103.33270")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
                
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            
        }
        task.resume()
      
    }
    
    func getUri(catalogUri:String,completion: @escaping () -> () ){
        
        AF.download(catalogUri).downloadProgress{bytesRead in
            //print("descarga \(bytesRead)")
        }.responseData { response in
            //print("descarga \(response.value!)")
            var decompressedData: Data
            if response.value!.isGzipped {
                decompressedData = try! response.value!.gunzipped()
                //print("descarga descomprimido")
               // print("descarga \(decompressedData)")
                self.file = decompressedData
            } else {
                decompressedData = response.value!
                //print("descarga comprimido")
                self.file = decompressedData
            }
            
            
           
         
            let str = String(decoding: self.file, as: UTF8.self)
            self.puedeser(data: str.data(using: .utf8)!,completion: completion)
            
            
            
        }
        
    }
    
        
    
    private func puedeser(data:Data,completion: @escaping () -> ()){
        do{
            let f:AlbumStockCD = try JSONDecoder().decode(AlbumStockCD.self, from: data)
            MyCoreBack.shared.background.saveIfNeeded()
            PersistenceController.shared.container.viewContext.saveIfNeeded()
            completion()
           
        }catch{
            print(error)
        }
       
        }
 
    
    
    
}
