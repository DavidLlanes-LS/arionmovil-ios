//
//  testViewmodel.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 26/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Combine
import SwiftUI
import CoreData
import Foundation
class algoViewModel: ObservableObject, ArionService  {
    @Published var change:Bool = false
    @Published var labeled:String = "test"
    var viewContext:NSManagedObjectContext? = MyCoreBack.shared.background
   
     @Published var uriResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
//    // @Published var stockResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
     @Published  var songsState: [SongsState]=[]
     @Published  var requested:Bool = false
     var tester:testeto = testeto()
     var apiSession: APIService
     var cancellables = Set<AnyCancellable>()
     init(apiSession: APIService = APISession()) {
         self.apiSession = apiSession
     }
    func getUriReponse() {
        let cancellable = self.getSongsURI()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    self.change = true
                    break
                }
                
            }) { (response) in
                self.uriResponse = response
                
                self.addTask(song: self.uriResponse)
        }
        
        cancellables.insert(cancellable)
    }
    
    public func changeVar(){
        change.toggle()
        labeled = "holaaaa"
    }
    private func saveContext(){
        viewContext?.saveIfNeeded()
    }

    private func addTask(song:SongsUriResponse){
        if(songsState.count > 0)
        {
            let newtask = songsState.first!
            newtask.catalogUri = song.catalogURI
            newtask.generationDate=song.generationDate
            newtask.resultCode = Int32(song.resultCode!)
        }
        else{
            let newtask = SongsState(context: viewContext!)
            newtask.catalogUri = song.catalogURI
            newtask.generationDate=song.generationDate
            newtask.resultCode = Int32(song.resultCode!)
        }

        saveContext()
    }

    
    
}
