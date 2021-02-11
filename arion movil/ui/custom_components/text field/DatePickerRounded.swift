//
//  DatePickerRounded.swift
//  arion movil
//
//  Created by Daniel Luna on 09/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct DatePickerRounded: View {
    @Binding var dateSelection:Date
    var title:String
    var textError:String
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker(selection: $dateSelection, in: ...dateSelection, displayedComponents: .date){
                TextWithCustomFonts(title, customFont: CustomFont(type: .semibold, size: 16), color: Color.gray)
            }
        }
        .padding()
        .background(Color.white)
        .opacity(0.8)
        .cornerRadius(4.0)
    }
}
