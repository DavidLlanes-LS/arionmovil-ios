//
//  LogoImage.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI
extension Image {
    func data(url:URL)->Self{
        if let data = try? Data(contentsOf: url){
            return Image(uiImage: UIImage(data:data)!).resizable()
        }
        return self.resizable()
    }
}
struct LogoImage: View {
    @State var imageName:String
    var body: some View {
        Image(systemName: "building.fill").data(url: URL(string: imageName)!)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
    }
    
    
}

struct LogoImage_Previews: PreviewProvider {
    static var previews: some View {
        LogoImage(imageName: "burger")
    }
}
