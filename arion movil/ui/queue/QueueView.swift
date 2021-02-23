//
//  Queue.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct QueueView: View {
    @StateObject var viewModel = QueueViewModel()
    @StateObject var storeViewModel = StoreViewModel()
    @EnvironmentObject var appSettings: AppHelper
    @State var navigationToLogin: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing:0) {
                    NavigationLink(destination: LoginView(), isActive: self.$navigationToLogin) {
                        Spacer().fixedSize()
                    }
                    AvailableCredits(credits:$appSettings.userCredits)
                    VStack {
                        HStack {
                            TextWithCustomFonts("Termina en",customFont: CustomFont(type: .bold, size: Constants.sizeTextBody), font: .body)
                            TextWithCustomFonts(appSettings.signalRResponse!,customFont: CustomFont(type: .bold, size: Constants.sizeTextBody),color: Color("secondary-background"), font: .body)
                            Spacer().background(Color("background"))
                        }
                        .padding([.top, .leading, .trailing]).background(Color("background"))
                        List{
                            ForEach(0..<self.viewModel.songs.count, id: \.self) { index in
                                QueueRow(
                                    song: viewModel.songs[index],
                                    creditsFirst: viewModel.songs[0].credits,
                                    creditsNext: viewModel.songs[(index - 1) < 0 ? 0 : index - 1].credits,
                                    hiddenButtons: index == 0,
                                    nav: self.$navigationToLogin,
                                    position: index,
                                    totalList: viewModel.songs.count
                                ).listRowBackground(Color("background"))
                                .environmentObject(viewModel)
                            }
                        }
                        .animation(.default)
                        .listStyle(PlainListStyle())
                        
                    }.background(Color("background"))
                    .onAppear(perform: {
                        self.viewModel.getQueue()
                        
                    })
                }
                VStack{
                    if viewModel.showLoader {
                        ProgressView()
                    }
                }
            }.navigationBarTitle(String("En fila"), displayMode: .inline)
        }.onAppear{
            viewModel.appSettings = appSettings
            self.storeViewModel.appSettings = self.appSettings
            storeViewModel.getCreditsUser()
        }.background(Color("background"))
    }
    
}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        QueueView()
    }
}
