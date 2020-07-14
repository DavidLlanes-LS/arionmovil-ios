//
//  ProfileImage.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
        Image("profile")
        .resizable()
        .clipShape(Circle())
            .aspectRatio(contentMode: .fit)
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage()
    }
}
