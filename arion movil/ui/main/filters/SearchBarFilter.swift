//
//  SearchBarFilter.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct SearchBarFilter: View {
    var body: some View {
        HStack{
            TextWithCustomFonts("Canción, artísta o albúm",color: Color("title-row"))
            Spacer()
            Image(systemName: "magnifyingglass").foregroundColor(Color("secondary-background"))
            }.padding().frame(height:60).background(Color("searchbar"))
    }
}

struct SearchBarFilter_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarFilter()
    }
}
