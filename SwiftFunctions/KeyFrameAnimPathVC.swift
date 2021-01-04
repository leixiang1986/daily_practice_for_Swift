//
//  KeyFrameAnimPathVC.swift
//  SwiftFunctions
//
//  Created by mac on 2021/1/4.
//

import UIKit

class KeyFrameAnimPathVC: UIViewController {
    var animation = CAKeyframeAnimation(keyPath: "position")
    let shipLayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let bezierPath = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 200, height: 300))
        
        ///注意图层没有frame
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.lightGray.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        self.view.layer.addSublayer(pathLayer)
        
        shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        shipLayer.backgroundColor = UIColor.yellow.cgColor
        shipLayer.position = CGPoint(x: 0, y: 30)
        self.view.layer.addSublayer(shipLayer)
        
        
        animation.duration = 4.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        ///设置跟随动画转动动画物体
        animation.rotationMode = .rotateAuto
        animation.path = bezierPath.cgPath
        
        shipLayer.add(animation, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shipLayer.add(animation, forKey: nil)
    }

    

}
