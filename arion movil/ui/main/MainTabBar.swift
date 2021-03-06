//
//  MainTabBar.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI
import SwiftSignalRClient
struct MainTabBar: View {
    @StateObject var queueviewModel = QueueViewModel()
    @EnvironmentObject var appSettings: AppHelper
    @State private var paddingHeight:CGFloat = 0
    @State private var currentTab:Int = 0
    @State private var showCurrentSong:Bool = false
    @State var service:SignalRService?
    var body: some View{
        VStack{
            
            GeometryReader{geometry in
                ZStack{
                    Color("background")
                    ZStack(alignment:.bottom){
                        TabView(selection: self.$currentTab){
                            Home(branchId:appSettings.currentBranchId).tabItem{
                                Image(systemName: "house")
                                Text("Inicio")
                            }.background(TabBarAccessor { tabBar in
                                DispatchQueue.main.async{
                                    self.paddingHeight = tabBar.bounds.height
                                }
                            }).tag(0)
                            QueueView().tabItem{
                                Image(systemName: "music.note.list")
                                Text("En fila")
                            }.background(TabBarAccessor { tabBar in
                                DispatchQueue.main.async{
                                    self.paddingHeight = tabBar.bounds.height
                                }
                            }).tag(1)
                            Store().tabItem{
                                Image(systemName: "bag")
                                Text("Compras")
                            }.background(TabBarAccessor { tabBar in
                                DispatchQueue.main.async{
                                    self.paddingHeight = tabBar.bounds.height
                                }
                            }).tag(2)
                            Profile().tabItem{
                                Image(systemName: "person")
                                Text("Perfil")
                            }.tag(3)
                        }.accentColor(Color("secondary-background"))
                        if self.appSettings.showCurrentSong {
                            //                            CurrentSong()
                            //                                .padding(.bottom, self.paddingHeight - geometry.safeAreaInsets.bottom).transition(.asymmetric(insertion: .scale, removal: .opacity))
                        }
                    }
                }.banner(data: $appSettings.banerInfo, show: $appSettings.showBanner)
                
            }
            if service?.connection.connectionId != nil {
                VStack{}.onAppear{
                    print("")
                }
            }
            
        }.transition(.move(edge: .trailing)).onAppear{
            
            appSettings.initSignalR(appSettings: appSettings)
            
            
        }.onDisappear{
            print("signalR2","salio")
        }
        
    }
    
    
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar().colorScheme(.dark)
    }
}


struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar) -> Void
    private let proxyController = ViewController()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
    UIViewController {
        proxyController.callback = callback
        return proxyController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }
    
    typealias UIViewControllerType = UIViewController
    
    private class ViewController: UIViewController {
        var callback: (UITabBar) -> Void = { _ in }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar)
            }
        }
    }
}




