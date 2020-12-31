//
//  UIView+Extension.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/25.
//

import UIKit

extension UIView {
    public func addAnchorConstraintToView(view:UIView,edgeInsets:UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if edgeInsets == .zero {
            self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        } else {
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: edgeInsets.left).isActive = true
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: edgeInsets.right).isActive = true
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top).isActive = true
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: edgeInsets.bottom).isActive = true
        }
        
    }
    
    var center:CGPoint {
        get {
            return CGPoint(x: frame.origin.x + frame.width * 0.5, y: frame.origin.y + frame.height * 0.5)
        }
        set {
            self.frame = CGRect(x: newValue.x - frame.width * 0.5, y: frame.height * 0.5, width: frame.width, height: frame.height)
        }
    }
    
}
