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
            DatePicker(selection: $dateSelection, in: ...Date(), displayedComponents: .date){
                TextWithCustomFonts(title, customFont: CustomFont(type: .light, size: 16)).padding()
            }
        }
    }
}
