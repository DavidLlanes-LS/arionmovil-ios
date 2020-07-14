//
//  BranchesList.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct BranchesList: View {
    @ObservedObject var locationManager = LocationManager()
    @State public var searchText : String = ""
    public var showMainView:()->()
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }

    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    public var branches:[Branch] = [Branch(id:1,name: "Burger King", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:2, name: "Alitas", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:3, name: "Americas", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:4, name: "Mexicaltzingo", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:5, name: "Escutia", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:6, name: "Insurgente", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:7,name: "Cerveceria Chapultepec", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:8, name: "Tuenchapu", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:9, name: "Burger King", location: "Av Chapultepec Sur 45",image: "burger"),Branch(id:10, name: "Burger King", location: "Av Chapultepec Sur 45",image: "burger")]
    
    @State public var showingMain:Bool = false
    
    var body: some View {
        ZStack{
            Color("background")
            VStack(spacing:0){
                SearchBar(text: $searchText, placeholder: "Busca un restaurante")
                List(self.branches.filter{ self.searchText != "" ? $0.name.contains(self.searchText) : true } ){ branch in
                    Button(action: {
                        self.showMainView()
                    }, label: {
                        BranchRow(branch: branch)
                    })
                }
                /*VStack {
                    Text("location status: \(locationManager.statusString)")
                    HStack {
                        Text("latitude: \(userLatitude)")
                        Text("longitude: \(userLongitude)")
                    }
                }*/
            }
        }.navigationBarTitle("Elije tu establecimiento",displayMode: .inline)
        
        
    }
}
