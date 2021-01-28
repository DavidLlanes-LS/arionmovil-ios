//
//  SongsUriViewModel.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 22/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//


import Combine
import SwiftUI
import CoreData
import Foundation

class SongsUriViewModel: ObservableObject, ArionService {
    @Environment(\.managedObjectContext) public var viewContextMain
    var viewContext:NSManagedObjectContext = MyCoreBack.shared.background
    @FetchRequest(fetchRequest: SongsState.fetchRequest())
    private var songsState: FetchedResults<SongsState>
    @Published var uriResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    @Published var stockResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    //@Published  var songsState: [SongsState]=[]
    @Published  var requested:Bool = false
    var tester:testeto = testeto()
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        
        
        //if let titles = self.album.title as?  Set
        //if let titles = self.album.title.map([ $0 as! Title ])
        
        
    }
    func getUriReponse() {
        requested = false
        let cancellable = self.getSongsURI()
            .sink(receiveCompletion: { result in
                switch result {
                
                case .failure(let error):
                    self.requested = true
                    print("Handle error: \(error)")
                case .finished:
                    self.requested = true
                    
                    break
                }
                
            }) { (response) in
                DispatchQueue.main.async {
                    self.requested = true
                    self.uriResponse = response
                    self.getStock()
                    self.addTask(song: self.uriResponse)
                }
        }
        
        cancellables.insert(cancellable)
    }
    func getStock(){
        tester.getUri(catalogUri: self.uriResponse.catalogURI!)
        
        
    }
    
    private func saveContext(){
        viewContext.saveIfNeeded()
        print("viewContext....", viewContext)
        print("viewContextMain...", viewContextMain)
//        viewContextMain.saveIfNeeded()
        PersistenceController.shared.container.viewContext.saveIfNeeded()
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
            let newtask = SongsState(context: viewContext)
            newtask.catalogUri = song.catalogURI
            newtask.generationDate=song.generationDate
            newtask.resultCode = Int32(song.resultCode!)
        }

        saveContext()
    }
    
   
}

