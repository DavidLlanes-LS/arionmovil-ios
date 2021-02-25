//
//  PickerRounded.swift
//  arion movil
//
//  Created by Daniel Luna on 09/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct PickerRounded: View {
    @Binding var selection:Int
    var title:String
    var data:[Any]
    var textError:String
    @State var transparent:Bool 
    var body: some View {
        VStack(alignment: .leading) {
            Picker(
                selection: $selection,
                label: HStack {
                    if selection < 0 {
                        TextWithCustomFonts(title, customFont: CustomFont(type: .semibold, size: Constants.sizeTextBody), color: Color.gray)
                    } else {
                        if self.data[selection] is Country {
                            TextWithCustomFonts((self.data[selection] as! Country).name,customFont: CustomFont(type: .bold, size: Constants.sizeTextBody))
                        }
                        if self.data[selection] is String {
                            TextWithCustomFonts((self.data[selection] as! String),customFont: CustomFont(type: .bold, size: Constants.sizeTextBody))
                        }
                        if self.data[selection] is Int {
                            TextWithCustomFonts(("\(self.data[selection] as! Int)"),customFont: CustomFont(type: .bold, size: Constants.sizeTextBody))
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.gray)
                }
                .padding()
                .background(!transparent ? Color("background"): Color("background_text"))
                .opacity(0.8)
                .cornerRadius(4.0)
            ) {
                ForEach(0..<self.data.count, id: \.self) { index in

                    if self.data[index] is String {
                        TextWithCustomFonts((self.data[index] as! String)).tag(index)
                    }
                    else {
                        TextWithCustomFonts(("\(self.data[index])")).tag(index)
                        //getText(data: self.data[index])
                    }
//                    else if self.data[index] is Country{
//                        TextWithCustomFonts(("\(self.data[index])")).tag(index)
//                    }
                    
                }
            }
            .pickerStyle(MenuPickerStyle())
            if !textError.isEmpty {
                TextWithCustomFonts(
                    textError,
                    customFont: CustomFont(type: .light, size: Constants.sizeTextCaption),
                    color: Color("error")
                ).padding(.horizontal)
            }
        }
    }
    
    func getText(data:Any)->TextWithCustomFonts{
       
        if data is Country{
            return  TextWithCustomFonts(("\(((self.data) as! Country).name)"))
        }
        else{
        return  TextWithCustomFonts(("\(self.data)"))
        }
    }
}
