//
//  BranchRow.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct BranchRow: View {
    var branch:Branch
    var body: some View {
        HStack{
            LogoImage(imageName: "burger")
                .frame(width: 40, height: 40, alignment: .center)
            VStack{
                TextWithCustomFonts(branch.name,customFont: CustomFont(type: .bold, size: 16),color: Color("title-row")).frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                TextWithCustomFonts(branch.location,color: Color("title-row")).frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
            }
            .frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
            
        }.frame(height:60)
        
    }
}

struct BranchRow_Previews: PreviewProvider {
    static var previews: some View {
        BranchRow(branch: Branch(id: 1, name: "Burger King", location: "Av Chapultepec Sur 45", image: "burger"))
    }
}
