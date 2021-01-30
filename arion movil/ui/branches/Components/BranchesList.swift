//
//  BranchesList2.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 25/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct BranchesList: View {
    @ObservedObject var viewModel = BranchesListViewModel()
    @EnvironmentObject var appSettings: AppHelper
    @State var show = false
    @State var isView = true
    @State var txt = ""
    @State var branchesFiltered:[Branch]=[]
    @ObservedObject var locationManager = LocationManager()

    var body: some View{
        ZStack {
            VStack(spacing:0){
                VStack{}.frame(height:45)
                VStack {
                    ZStack {
                        if !self.show{
                            
                            TextWithCustomFonts("Elije tu establecimiento",customFont: CustomFont(type: .bold, size: 16),color: Color("title-row")).frame(minWidth:0, maxWidth: .infinity, alignment: .center)
                        }
                        
                        ExpandedSearchBar(show:$show,txt: $txt, placeholder: "Buscar Restaurante")
                    }
                    Spacer().frame(height:10).background(Color("background"))
                    if self.locationManager.latitudeVar==""{
                        Spacer()}
                }.background(Color("background"))
                
                if !(self.locationManager.latitudeVar=="") {
                    
                    VStack{
                        if(self.viewModel.branch.filter( {$0.name.lowercased().contains(self.txt.lowercased()) || self.txt.isEmpty
                        })).count>0{
                            List{
                                ForEach(self.viewModel.branch.filter({$0.name.lowercased().contains(self.txt.lowercased()) || self.txt.isEmpty})){branch in
                                    
                                    Button(action: {
                                        withAnimation{
                                            appSettings.currentBranchId = branch.id
                                            appSettings.currentPage="otro"
                                           
                                        }
                                        
                                        
                                    }, label: {
                                        BranchRow(branch: branch)
                                    }).listRowBackground(Color("background")).listRowInsets(.init(EdgeInsets(top: 2, leading:0, bottom: 2, trailing: 0)))
                                    
                                    
                                    
                                }}.listStyle(PlainListStyle())
                            
                        }
                        else{
                            if !viewModel.showLoader{
                                Text("No hay datos")
                                
                            }
                            Spacer()
                        }
                    }.onAppear{
                        self.viewModel.getBranchesList(longitude: "-103.33270", latitude: "20.62753")
                        /*self.viewModel.getBranchesList(longitude: self.locationManager.longitudeVar, latitude: self.locationManager.latitudeVar)*/
                        viewModel.showLoader = false
                    }
                    
                }
                
                
                
            }.background(Color("background")).edgesIgnoringSafeArea(.all)
            if viewModel.showLoader{
                VStack {
                    LoaderComponent()
                }.frame(maxWidth:.infinity,maxHeight: .infinity).background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
                
            }
        }
        
        
        
    }
    
}


struct BranchesList_Previews: PreviewProvider {
    static var previews: some View {
        BranchesList()
    }
}
