//
//  SymbolView.swift
//  SetGame
//
//  Created by T  on 2021-03-15.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let yHeight = (rect.midX - rect.minX)/2
        var p = Path()
        p.move(to: start)
        p.addLine(to: CGPoint(x: rect.midX, y: rect.midY+yHeight))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))

        p.addLine(to: CGPoint(x: rect.midX, y: rect.midY-yHeight))
        p.addLine(to: start)
        return p
    }
}


struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = (rect.midX - rect.minX)/2
        let start =  CGPoint(x: rect.minX + radius, y: rect.midY-radius)
        let leftCenter = CGPoint(x: rect.minX + radius, y: rect.midY)
        let rightCenter = CGPoint(x: rect.maxX - radius, y: rect.midY)

        var p = Path()
        p.move(to: start)
        p.addArc(center: leftCenter, radius: radius, startAngle: Angle.degrees(-90), endAngle: Angle.degrees(180-90), clockwise: true)

        p.addLine(to: CGPoint(x: rect.maxX - radius, y:rect.midY+radius))
        p.addArc(center: rightCenter, radius: radius, startAngle: Angle.degrees(90), endAngle: Angle.degrees(-90), clockwise: true)

        p.addLine(to: start)
        return p
    }
}


struct SetRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        let yHeight = (rect.midX - rect.minX)/2
        let start = CGPoint(x: rect.minX, y: rect.midY-yHeight)
        var p = Path()
        p.move(to: start)
        p.addLine(to: CGPoint(x: rect.minX, y: rect.midY+yHeight))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY+yHeight))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY-yHeight))
        p.addLine(to: start)
        return p
    }
}

struct SymbolView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Diamond()
            Oval()
            SetRectangle()
        }
        .foregroundColor(.blue)
        .opacity(0.5)

    }
}

