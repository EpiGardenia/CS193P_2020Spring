//
//  Color_extension.swift
//  Memorize
//
//  Created by T  on 2021-04-27.
//

import SwiftUI

/* Required Task #2 */
enum ColorName {
    case orange, purple, blue, yellow, pink, green
}

let colorDict: [ColorName: UIColor.RGB] = [
    .blue: UIColor.RGB(red: 0, green: 122/255, blue: 255/255, alpha: 1),
    .orange: UIColor.RGB(red: 255/255, green: 149/255, blue: 0, alpha: 1),
    .pink: UIColor.RGB(red: 255/255, green: 45/255, blue: 85/255, alpha: 1),
    .purple:UIColor.RGB(red: 175/255, green: 82/255, blue: 222/255, alpha: 1),
    .yellow: UIColor.RGB(red: 255/255, green: 204/255, blue: 0/255, alpha: 1),
    .green: UIColor.RGB(red: 52/255, green: 199/255, blue: 89/255, alpha: 1),
]

extension Color {
    init(_ rgb: UIColor.RGB) {
        self.init(UIColor(rgb))
    }
}

extension UIColor {
    public struct RGB: Hashable, Codable {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }

    convenience init(_ rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
    }

    public var rgb: RGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return RGB(red: red, green: green, blue: blue, alpha: alpha)
    } }
