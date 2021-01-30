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
    var viewContext:NSManagedObjectContext = MyCoreBack.shared.background
    var songsState: [SongsState] = []
    var stock: [AlbumStockCD] = []
    @Published var branchId:String = ""
    @Published var countSongs:Int = 0
    @Published var rows:Int = 0
    @Published var isImpar = false
    @Published var musicList:[TitleCD] = []
    @Published var uriResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    @Published var stockResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    @Published  var requested:Bool = false
    var tester:testeto = testeto()
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.songsState = self.getSongsStateCD()
        getStockCD()
        
        
        
    }
    func getUriReponse(completion: @escaping () -> () ){
        requested = false
        let cancellable = self.getSongsURI(branchid:branchId)
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
                    self.storeSongsStateCD(song: self.uriResponse,completion: completion)
                
                }
                
        }
        
        cancellables.insert(cancellable)
    }
   
    private func storeSongsStateCD(song:SongsUriResponse,completion: @escaping () -> ()){
        if(songsState.count > 0)
        {
            let newtask = songsState.first!
            newtask.catalogUri = song.catalogURI
            newtask.generationDate=song.generationDate
            newtask.resultCode = Int32(song.resultCode!)
            newtask.branchId = branchId
            self.getStockUnzipped(branchId:branchId,catalogUri: self.uriResponse.catalogURI!, completion: completion)
        }
        else{
            if songsState.first?.generationDate != song.generationDate
            {
                self.getStockUnzipped(branchId:branchId,catalogUri: self.uriResponse.catalogURI!, completion: completion)
            }
            let newtask = SongsState(context: viewContext)
            newtask.catalogUri = song.catalogURI
            newtask.generationDate=song.generationDate
            newtask.resultCode = Int32(song.resultCode!)
            newtask.branchId = branchId
        }
        
        
       saveContext()
    }
    
    private func getSongsStateCD()->[SongsState]{
        var songsStateList: [SongsState] = []
        let songStateFetch = SongsState.fetchRequestNamed()
        do{
            let temporalList = try PersistenceController.shared.container.viewContext.fetch(songStateFetch)
            songsStateList = temporalList
        }catch{
            fatalError("Failed to fetch categories: \(error)")
        }
        return songsStateList
    }
    
    private func getStockCD(){
        var AlbumStockList: [AlbumStockCD] = []
        let stockFetch = AlbumStockCD.fetchRequestSingle()
        do{
            let temporalList = try PersistenceController.shared.container.viewContext.fetch(stockFetch)
            AlbumStockList = temporalList
        }catch{
            fatalError("Failed to fetch categories: \(error)")
        }
        self.stock = AlbumStockList
    }

    
    private func saveContext(){
        viewContext.saveIfNeeded()
        PersistenceController.shared.container.viewContext.saveIfNeeded()
            
    }

}

