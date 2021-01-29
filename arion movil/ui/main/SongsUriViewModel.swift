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
    @Published var countSongs:Int = 0
    @Published var musicList:[TitleCD] = []
    @Published var uriResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    @Published var stockResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    //@Published  var songsState: [SongsState]=[]
    @Published  var requested:Bool = false
    var tester:testeto = testeto()
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.songsState = self.getSongsStateCD()
        self.stock =  self.getStockCD()
        self.getList()
        print("albumesCD",stock.first?.id)
        
        
    }
    func getUriReponse(completion: @escaping () -> () ){
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
                    self.storeCD(song: self.uriResponse)
                }
                
        }
        
        cancellables.insert(cancellable)
    }
    func getStock(completion: @escaping () -> ()){
        tester.getUri(catalogUri: self.uriResponse.catalogURI!,completion: completion)
        
        
    }
    
    private func saveContext(){
        viewContext.saveIfNeeded()
        PersistenceController.shared.container.viewContext.saveIfNeeded()
       

            
    }

    private func storeCD(song:SongsUriResponse){
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
        self.getStock(completion: getList)
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
    
    private func getStockCD()->[AlbumStockCD]{
        var AlbumStockList: [AlbumStockCD] = []
        let stockFetch = AlbumStockCD.fetchRequestSingle()
        do{
            let temporalList = try PersistenceController.shared.container.viewContext.fetch(stockFetch)
            AlbumStockList = temporalList
        }catch{
            fatalError("Failed to fetch categories: \(error)")
        }
        return AlbumStockList
    }
    
    func getList(){
        
        if(stock.count > 0){
            var titles:[TitleCD] = []
            let playlists = stock.first?.playlists?.allObjects as! [PlaylistCD]
            let albums = playlists.first?.albums?.allObjects as! [AlbumCD]
            albums.forEach{ album in
                (album.titles?.allObjects as! [TitleCD]).forEach{
                    $0.coverImageUri = album.coverImageUri
                    titles.append(contentsOf:(album.titles?.allObjects as! [TitleCD]))
                }        }
            print("pruebas",titles.count)
         
            
            titles.forEach{title in
                title.coverImageUri = title.coverImageUri! as String
            }
            titles = Array(Set(titles))
            musicList = titles
            musicList.sort{
                $0.name!<$1.name!
            }
            countSongs = musicList.count - 1
//            print("canciones",musicList.count)
//            print("listas0","\(musicList[0].id) \(musicList[0].name)" )
//            print("listas1","\(musicList[1].id) \(musicList[1].name)" )
//            print("listas2","\(musicList[2].id) \(musicList[2].name)" )
//            print("listas3","\(musicList[3].id) \(musicList[3].name)" )
        }
        
    }
   
}

