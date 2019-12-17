//
//  UIColorExtension.swift
//  romanisme
//
//  Created by Alex Aron on 13/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(
            red: r / 255,
            green: g / 255,
            blue: b / 255,
            alpha: a
        )
    }
    
    // Custom Application Colors
    
    static let themeLightBlue = UIColor(r: 28, g: 191, b: 255)
    static let themeBlue = UIColor(r: 14, g: 155, b: 227)
    static let themeDarkBlue = UIColor(r: 26, g: 137, b: 193)
    static let themeGreen = UIColor(r: 35, g: 210, b: 143)
    static let themeDarkGreen = UIColor(r: 45, g: 181, b: 129)
    static let themeDark = UIColor(r: 11, g: 12, b: 27)
    static let themeMedium = UIColor(r: 73, g: 77, b: 97)
    static let themeLight = UIColor(r: 184, g: 184, b: 204)
    
}
