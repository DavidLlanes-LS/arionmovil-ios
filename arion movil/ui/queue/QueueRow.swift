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
    
    @StateObject var viewModel = QueueViewModel()
    @State var showAlert: Bool = false
    @State var authAlert: Bool = false
    @State var sendToNext: Bool = false
    @EnvironmentObject var pageSettings: AppHelper
    var isAuth = UserDefaults.standard.bool(forKey: Constants.keyIsAuth)
    
    var body: some View {
        HStack(){
            VStack(alignment:.leading){
                TextWithCustomFonts(song.titleName, customFont: CustomFont(type: .bold, size: 16))
                TextWithCustomFonts(song.titleArtist)
            }
            Spacer()
            HStack(spacing:16){
                IconBtn("arrow.right.circle", hidden: hiddenButtons) {
                    if (pageSettings.userId != nil) {
                        viewModel.addQueue(body: AddQueue(userId: pageSettings.userId!, locationId: pageSettings.locationId!, playerId: pageSettings.playerId!, mediaTitleId: song.titleID, creditsToCharge: 20, positionToAdvance: 1))
                    } else {
                        showAlert = true
                    }
                    sendToNext = true
                }
                IconBtn("arrowtriangle.up.circle", hidden: hiddenButtons) {
                    if (pageSettings.userId != nil) {
                        viewModel.addQueue(body: AddQueue(userId: pageSettings.userId!, locationId: pageSettings.currentBranchId, playerId: pageSettings.playerId!, mediaTitleId: song.titleID, creditsToCharge: 20, positionToAdvance: 1))
                    } else {
                        showAlert = true
                    }
                    sendToNext = false
                }
            }
            Text("\(song.credits)").bold()
        }
        .frame(height:60)
        .padding(.horizontal)
        .alert(isPresented: $showAlert, content: {
            let result:Int = sendToNext ? creditsNext - song.credits + 1 : creditsFirst - song.credits + 1
            
            if (isAuth) {
                return Alert(
                    title:Text(String("Atención").capitalized),
                    message: Text(String("¿Quieres adelantar la canción de posición por \(result) créditos?")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                    secondaryButton: .default(Text(String("Aceptar").capitalized)) {
                        
                    }
                )
            } else {
                return Alert(
                    title:Text(String("Inicia sesión para continuar")),
                    message: Text(String("Iniciar sesión o crear una cuenta para poder realizar esta acción.")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                    secondaryButton: .default(Text(String("Aceptar").capitalized)) {
                        
                    }
                )
            }
        })
    }
}

struct QueueRow_Previews: PreviewProvider {
    static var previews: some View {
        QueueRow(song: TitleInQueue(id: "", playerID: "", titleID: "", titleName: "Loco", titleArtist: "Olwa", credits: 1), creditsFirst: 1, creditsNext: 1, hiddenButtons: false)
    }
}
