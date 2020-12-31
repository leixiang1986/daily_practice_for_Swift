//
//  CALayer+Extension.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/31.
//

import UIKit

extension CALayer {
    var center:CGPoint {
        get {
            return CGPoint(x: frame.origin.x + frame.width * 0.5, y: frame.origin.y + frame.height * 0.5)
        }
        set {
            self.frame = CGRect(x: newValue.x - frame.width * 0.5, y: newValue.y - frame.height * 0.5, width: frame.width, height: frame.height)
        }
    }
    
}
