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
    var totalList: Int
    
    @State var showAlert: Bool = false
    @State var authAlert: Bool = false
    @State var sendToNext: Bool = false
    @Binding var nav: Bool
    @EnvironmentObject var pageSettings: AppHelper
    
    init(song: TitleInQueue, creditsFirst: Int, creditsNext: Int, hiddenButtons:Bool, nav:Binding<Bool>, position:Int, totalList:Int, funct:@escaping (_ result:Int, _ positionAdvance:Int)->()) {
        self.song = song
        self.creditsFirst = creditsFirst
        self.creditsNext = creditsNext
        self.hiddenButtons = hiddenButtons
        self.position = position
        _nav = nav
        self.totalList = totalList
        self.funct = funct
    }
    
    var funct:(_ result:Int, _ positionAdvance:Int) -> ()
    
    var body: some View {
        HStack(){
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
            }
            Text("\(song.credits)").bold()
        }
        .frame(height:60)
        .padding(.horizontal)
        .alert(isPresented: $showAlert, content: {
            let result:Int = sendToNext ? creditsNext - song.credits + 1 : creditsFirst - song.credits + 1
            let positionAdvance:Int = sendToNext ? 1 : totalList - position
            
            if (UserDefaults.standard.bool(forKey: Constants.keyIsAuth)) {
                return Alert(
                    title:Text(String("Atención").capitalized),
                    message: Text(String("¿Quieres adelantar la canción de posición por \(result) créditos?")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                    secondaryButton: .default(Text(String("Aceptar").capitalized)) {
                        funct(result, positionAdvance)
                    }
                )
            } else {
                return Alert(
                    title:Text(String("Inicia sesión para continuar")),
                    message: Text(String("Iniciar sesión o crear una cuenta para poder realizar esta acción.")),
                    primaryButton: .cancel(Text(String("Cancelar").capitalized)),
                    secondaryButton: .default(Text(String("Aceptar").capitalized)) {
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
        QueueRow(song: TitleInQueue(id: "", playerID: "", titleID: "", titleName: "Loco", titleArtist: "Olwa", credits: 1), creditsFirst: 1, creditsNext: 1, hiddenButtons: false, nav: $nav, position: 0, totalList: 0) { result, position in }
    }
}
