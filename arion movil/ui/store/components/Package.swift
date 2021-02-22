//
//  Package.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct Package: View {
    var package:Packages
    init(package:Packages){
        self.package = package
    }
    var body: some View {
        HStack{
            HStack{
                TextWithCustomFonts(package.name!,customFont: CustomFont(type: .bold, size: 16), color: Color("secondary-background"))
                TextWithCustomFonts("- \(package.amount!) Créditos",customFont: CustomFont(type: .semibold, size: Constants.sizeTextBody), color: Color("light-gray"), font: .body).frame(minWidth:0,maxWidth: .infinity, alignment: .leading)
                TextWithCustomFonts("$\(package.price!)",customFont: CustomFont(type: .bold, size: Constants.sizeTextBody), color: Color("title"), font: .body).frame(width:60).frame(width:40)
            }.padding()
        }
    }
}

struct Package_Previews: PreviewProvider {
    static var previews: some View {
        let package:Packages =  Packages()
        Package(package: package)
            .environment(\.colorScheme, .dark)
    }
}
