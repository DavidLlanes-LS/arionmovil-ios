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
    @Published var artistListMain:[String] = []
    @Published var genereList:[String] = []
    @Published var yearList:[[Int]] = []
    @Published var albumListMain:[AlbumCD] = []
    @Published var count:Int = 0
    @Published var rows:Int = 0
    @Published var isImpar = false
    @Published var musicList:[TitleCD] = []
    @Published var uriResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    @Published var stockResponse:SongsUriResponse = SongsUriResponse(catalogURI: "", generationDate: "", resultCode: 0 )
    @Published  var requested:Bool = false
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    init(apiSession: APIService = APISession(), branchId:String = "") {
        self.apiSession = apiSession
        self.branchId = branchId
        self.songsState = self.getSongsStateCD(branchId: branchId)
        getStockCD(branchId: branchId)
        getList()
        
        
        
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
    
    private func getSongsStateCD(branchId:String)->[SongsState]{
        var songsStateList: [SongsState] = []
        let songStateFetch = SongsState.fetchRequestNamed(branchId: branchId)
        do{
            let temporalList = try PersistenceController.shared.container.viewContext.fetch(songStateFetch)
            songsStateList = temporalList
        }catch{
            fatalError("Failed to fetch categories: \(error)")
        }
        return songsStateList
    }
    
    private func getStockCD(branchId:String){
        var AlbumStockList: [AlbumStockCD] = []
        let stockFetch = AlbumStockCD.fetchRequestSingle(branchId: branchId)
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
    func setDataCD(){
        getStockCD(branchId: branchId)
        getList()
        getRows()
    }
    func getList(){
        
        if(stock.count != 0){
            var titles:[TitleCD] = []
            let playlists = stock.first?.playlists?.allObjects as! [PlaylistCD]
            var albumsTemporal:[AlbumCD] = []
            for playlist in playlists{
                albumsTemporal.append(contentsOf: (playlist.albums?.allObjects as! [AlbumCD]))
            }
            var albums = albumsTemporal
            albums.forEach{ album in
                (album.titles?.allObjects as! [TitleCD]).forEach{
                    $0.coverImageUri = album.coverImageUri
                    titles.append(contentsOf:(album.titles?.allObjects as! [TitleCD]))
                }        }
            titles.forEach{title in
                title.coverImageUri = title.coverImageUri! as String
            }
            
            titles = Array(Set(titles))
            musicList = titles
            musicList.sort{
                $0.artist!<$1.artist!
            }
            count = musicList.count - 1
            let sections = Set(musicList.map{ $0.artist!})
            artistListMain = Array(sections)
            artistListMain.sort{
                $0<$1
            }
            let sections2 = Set(musicList.map{ $0.genere!})
            genereList = Array(sections2)
            genereList.sort{
                $0<$1
            }
            let sections3 = Set(musicList.map{ $0.recordedYear})
            let temporarlYearList = Array(sections3)
            var yearListIndividual = temporarlYearList.map({
                (Int($0)/10)*10
                
            })
            yearListIndividual = yearListIndividual.filter({$0 != 0})
            yearListIndividual = Array(Set(yearListIndividual))
            yearListIndividual.sort{
                $0<$1
            }
            yearListIndividual.forEach { year in
                yearList.append([year,year+9])
            }
            
            albums = Array(Set(albums))
            albums.sort{
                $0.name!<$1.name!
            }
            albumListMain = albums
            
            
        }
        
    }
    public func getRows(){
        let decimalValue:Double = Double(count-1)/2
        let intValue:Int =  (count-1)/2
        let difference:Double = decimalValue - Double(intValue)
        
        if difference > 0 {
            rows = intValue
            self.isImpar = true
        }
        else {
            rows = intValue
            
        }
        
    }
}


