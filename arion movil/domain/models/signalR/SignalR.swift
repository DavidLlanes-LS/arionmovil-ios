//
//  SignalR.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 25/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import SwiftSignalRClient
public class SignalRService: HubConnectionDelegate {
    
    public func connectionDidOpen(hubConnection: HubConnection) {
        connection.send(method: "BeginLocationSession", self.appSettings!.currentBranchId)
        
    }
    
    public func connectionDidFailToOpen(error: Error) {
        print("signalR2","falló")
    }
    
    public func connectionDidClose(error: Error?) {
        print("signalR2","cerrado")
    }
    
    
    public var connection: HubConnection
    public var appSettings: AppHelper?
    
    public init(url: URL,appSettings:AppHelper) {
        
        connection = HubConnectionBuilder(url: url).withLogging(minLogLevel: .debug).build()
        connection.delegate = self
        self.appSettings = appSettings
        
        
        connection.on(method: "QueueNotifications",callback:{argumentExtractor in
         //   let location = try! argumentExtractor.getArgument(type: QueueResponse.self)
            do{
                let queueViewModel = QueueViewModel()
                queueViewModel.appSettings = appSettings
                queueViewModel.getQueue()
                let storeViewModel = StoreViewModel()
                storeViewModel.appSettings = self.appSettings
                storeViewModel.getCreditsUser()
            }
           
            
        })
        connection.on(method: "PlaybackNotifications",callback:{(UUID:String) in
            print("signalR2","play")
            do{
                
               // print("signalR2","\(UUID)")
                
            }
            
        })
        
        connection.start()
        
        
    }
    
   
}
