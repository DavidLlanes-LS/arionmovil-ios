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
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
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
                                                hiddenButtons: song == 0
                                            )
                                            .environmentObject(viewModel)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .modifier(
                OnLoadModifier(work: self.viewModel.getQueue)
            )
            .navigationBarTitle("En fila", displayMode: .inline)
        }
    }

}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        Queue()
    }
}
