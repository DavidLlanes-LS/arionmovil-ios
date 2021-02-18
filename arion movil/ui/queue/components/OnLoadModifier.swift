//
//  OnLoadModifier.swift
//  arion movil
//
//  Created by Daniel Luna on 28/01/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//
import Foundation
import SwiftUI

struct OnLoadModifier: ViewModifier {
    // MARK: - variables
    @State var didAppear = false

    var work : () -> Void

    

    func body(content: Content) -> some View {

        content

            .onAppear(perform: onLoad)

    }

    func onLoad() {

        if !didAppear {
            work()
        }

        didAppear = true

    }

}
