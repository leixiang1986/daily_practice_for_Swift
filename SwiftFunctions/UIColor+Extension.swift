//
//  UIColor+Extension.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/31.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat(Double.random(in: 0...1))
        let green = CGFloat(Double.random(in: 0...1))
        let blue = CGFloat(Double.random(in: 0...1))
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
