//
//  TopCornersRoundedRectangle.swift
//  arion movil
//
//  Created by David Israel Llanes Ordaz on 19/02/21.
//  Copyright © 2021 David Pacheco Rodriguez. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftUI
struct CustomShape: Shape {
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let tl = CGPoint(x: rect.minX, y: rect.minY)
        let tlc = CGPoint(x: rect.minX+radius, y: rect.minY+radius)
        let tr = CGPoint(x: rect.maxX-radius, y: rect.minY)
        let trc = CGPoint(x: rect.maxX-radius, y: rect.minY+radius)
        let br = CGPoint(x: rect.maxX, y: rect.maxY)
        let bl = CGPoint(x: rect.minX, y: rect.maxY)
        
        // Do stuff here to draw the outline of the mask
        path.move(to: tl)
        path.addRelativeArc(center: tlc, radius: radius,
                 startAngle: Angle.degrees(180), delta: Angle.degrees(90))
        path.addLine(to: tr)
        path.addRelativeArc(center: trc, radius: radius,
                 startAngle: Angle.degrees(270), delta: Angle.degrees(90))
        path.addLine(to: br)
        path.addLine(to: bl)
        path.addLine(to: tl)
        
        return path
    }
}
