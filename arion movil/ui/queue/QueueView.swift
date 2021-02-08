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
            VStack(spacing:0) {
                NavigationLink(destination: LoginView(), isActive: self.$navigationToLogin) {
                    Spacer().fixedSize()
                }
                AvailableCredits(credits:$appSettings.userCredits)
                VStack {
                    HStack {
                        TextWithCustomFonts("Termina en",customFont: CustomFont(type: .bold, size: 17))
                        TextWithCustomFonts(" 00:30",customFont: CustomFont(type: .bold, size: 17),color: Color("secondary-background"))
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing])
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
                            )
                            .environmentObject(viewModel)
                        }
                    }
                    .animation(.default)
                    .listStyle(PlainListStyle())
                    if viewModel.showLoader {
                        ProgressView()
                    }
                }
                .onAppear(perform: {
                    self.viewModel.getQueue()
                   
                })
            }
            .navigationBarTitle("En fila", displayMode: .inline)
        }.onAppear{
            self.storeViewModel.appSettings = self.appSettings
            storeViewModel.getCreditsUser()
        }
    }
    
}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        QueueView()
    }
}
