//
//  LoaderComponent.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 25/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct LoaderComponent: View {
    @State var animate = false
    var body: some View {
        VStack(alignment:.center) {
            Circle().trim(from:0,to: 0.8)
                .stroke(AngularGradient(gradient: .init(colors:[.red,.orange]),center:.center),style: StrokeStyle(lineWidth:8,lineCap: .round)).frame(width: 45, height: 45).rotationEffect(.init(degrees: self.animate ? 360 : 0)).animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
        }.padding(20).background(Color.white).cornerRadius(15).onAppear{
            self.animate.toggle()
        }
    }
}

struct LoaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        LoaderComponent()
        
    }
}
