//
//  BranchRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct BranchRow: View {
    var branch:Location
    @State var ImageUrl:String = ""
    
    var body: some View {
       // background(Color.red)
        VStack{
            HStack{
                LogoImage(imageName:branch.logoImage == nil ? "image": branch.logoImage!)
                    .frame(width: 40, height: 40, alignment: .center)
                VStack(alignment: .leading){
                    TextWithCustomFonts(branch.name,customFont: CustomFont(type: .bold, size: 17),color: Color("title"), font: .body)
                    TextWithCustomFonts(branch.locationDescription, customFont: CustomFont(type: .light, size: 17), color: Color("title"), font: .body)
                }
                .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
               
            }
            .frame(height:60)
            .padding(EdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20))
        }
    }
}

struct BranchRow_Previews: PreviewProvider {
    static var previews: some View {
        BranchRow(branch: Location(id:"2" , playerID: "sdwdwdw", name: "juanjo", locationDescription: "mansdmanmdns", addressLine: "sndnsbnbds", spatialLocation: "jsdjsdj", logoImage: "jsdjshjd"))
            .preferredColorScheme(.dark)
    }
}
