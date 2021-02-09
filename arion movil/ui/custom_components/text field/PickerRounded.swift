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
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selection, label: TextWithCustomFonts(self.title, customFont: CustomFont(type: .light, size: 16)).padding()) {
                ForEach(0..<self.data.count, id: \.self) { index in
                    if (self.data[index] is Country) {
                        TextWithCustomFonts((self.data[index] as! Country).name).tag(index)
                    }
                    if (self.data[index] is String) {
                        TextWithCustomFonts((self.data[index] as! String)).tag(index)
                    }
                }
            }
            if !textError.isEmpty {
                TextWithCustomFonts(
                    textError,
                    customFont: CustomFont(type: .light, size: 14),
                    color: Color("error")
                ).padding(.horizontal)
            }
        }
    }
}
