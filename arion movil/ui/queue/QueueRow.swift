//
//  QueueRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 03/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//
import SwiftUI

struct QueueRow: View {
    var song: TitleInQueue
    var creditsFirst: Int
    var creditsNext: Int
    var hiddenButtons: Bool
    var position: Int
    @EnvironmentObject var appSettings: AppHelper
    var totalList: Int
    @StateObject var storeViewModel = StoreViewModel()
    @State var showAlert: Bool = false
    @State var authAlert: Bool = false
    @State var sendToNext: Bool = false
    @Binding var nav: Bool
    @EnvironmentObject var pageSettings: AppHelper
    @EnvironmentObject var viewModel: QueueViewModel
    
    var userId = UserDefaults.standard.string(forKey: Constants.keyUserId)
    var playerId = UserDefaults.standard.string(forKey: Constants.keyPlayerId)
    var locationId = UserDefaults.standard.string(forKey: Constants.keyLocationId)
    var isAuth = UserDefaults.standard.bool(forKey: Constants.keyIsAuth)
    
    init(song: TitleInQueue, creditsFirst: Int, creditsNext: Int, hiddenButtons:Bool, nav:Binding<Bool>, position:Int, totalList:Int) {
        self.song = song
        self.creditsFirst = creditsFirst
        self.creditsNext = creditsNext
        self.hiddenButtons = hiddenButtons
        self.position = position
        _nav = nav
        self.totalList = totalList
    }
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                TextWithCustomFonts(song.titleName, customFont: CustomFont(type: .bold, size: 16))
                TextWithCustomFonts(song.titleArtist)
            }
            Spacer()
            HStack(spacing:16){
                IconBtn("arrow.right.circle", hidden: hiddenButtons) {
                    showAlert = true
                    sendToNext = true
                }
                IconBtn("arrowtriangle.up.circle", hidden: hiddenButtons) {
                    showAlert = true
                    sendToNext = false
                }
                Text("\(song.credits)").bold()
            }
        }
        .buttonStyle(PlainButtonStyle())
        .alert(isPresented: $showAlert, content: {
            let result:Int = sendToNext ? creditsNext - song.credits + 1 : creditsFirst - song.credits + 1
            let positionAdvance:Int = sendToNext ? 1 : totalList - position
            
            if (isAuth) {
                return Alert(
                    title:Text(String("Atención").capitalized),
                    message: Text(String("¿Quieres adelantar la canción de posición por \(result) créditos?")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                    secondaryButton: .default(Text(String("Aceptar").capitalized)) {
                        viewModel.addQueue(body: AddQueue(userId: userId!, locationId: locationId!, playerId: playerId!, mediaTitleId: song.titleID, creditsToCharge: result, positionToAdvance: positionAdvance)) { result, error in
                            storeViewModel.appSettings = self.appSettings
                            storeViewModel.getCreditsUser()
                            if (result != nil) {
                                //viewModel.getQueue()
                            } else if (error != nil) {
                                UserDefaults.standard.set(false, forKey: Constants.keyIsAuth)
                                self.showAlert = true
                            }
                        }
                    }
                )
            } else {
                return Alert(
                    title:Text(String("Inicia sesión para continuar")),
                    message: Text(String("Iniciar sesión o crear una cuenta para poder realizar esta acción.")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                    secondaryButton: .default(Text(String("Iniciar sesión").capitalized)) {
                        nav = true
                    }
                )
            }
        })
    }
}

struct QueueRow_Previews: PreviewProvider {
    
    @State static var nav: Bool = false
    
    static var previews: some View {
        QueueRow(song: TitleInQueue(id: "", playerID: "", titleID: "", titleName: "Loco", titleArtist: "Olwa", credits: 1), creditsFirst: 1, creditsNext: 1, hiddenButtons: false, nav: $nav, position: 0, totalList: 0)
    }
}
