//
//  Queue.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct Queue: View {
    @StateObject var viewModel = QueueViewModel()
    @State var navigationToLogin: Bool = false
    @EnvironmentObject var appSettings: AppHelper
    
    var userId = UserDefaults.standard.string(forKey: Constants.keyUserId)
    var playerId = UserDefaults.standard.string(forKey: Constants.keyPlayerId)
    var locationId = UserDefaults.standard.string(forKey: Constants.keyLocationId)
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                NavigationLink(destination: LoginView(), isActive: self.$navigationToLogin) {
                   Spacer().fixedSize()
                }
                AvailableCredits()
                ScrollView {
                    VStack {
                        HStack {
                            TextWithCustomFonts("Termina en",customFont: CustomFont(type: .bold, size: 17))
                            TextWithCustomFonts(" 00:30",customFont: CustomFont(type: .bold, size: 17),color: Color("secondary-background"))
                            Spacer()
                        }
                        .padding([.top, .leading, .trailing])
                        ZStack {
                            ProgressView()
                                .opacity(viewModel.showLoader ? 1 : 0)
                            if(viewModel.songs.count > 0) {
                                VStack {
                                    ForEach(viewModel.songs.indices) { song in
                                            QueueRow(
                                                song: viewModel.songs[song],
                                                creditsFirst: viewModel.songs[0].credits,
                                                creditsNext: viewModel.songs[(song - 1) < 0 ? 0 : song - 1].credits,
                                                hiddenButtons: song == 0,
                                                nav: self.$navigationToLogin,
                                                position: song,
                                                totalList: viewModel.songs.count
                                            ) { result, position in
                                                viewModel.addQueue(body: AddQueue(userId: userId!, locationId: locationId!, playerId: playerId!, mediaTitleId: viewModel.songs[song].titleID, creditsToCharge: result, positionToAdvance: position))
                                            }
                                            .environmentObject(viewModel)
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: {
                    self.viewModel.getQueue()
                    self.appSettings.showCurrentSong = true
                })
            }
            .navigationBarTitle("En fila", displayMode: .inline)
        }
    }

}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        Queue()
    }
}
