//
//  LogoImage.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct LogoImage: View {
    var imageName:String
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
    }
}

struct LogoImage_Previews: PreviewProvider {
    static var previews: some View {
        LogoImage(imageName: "burger")
    }
}
