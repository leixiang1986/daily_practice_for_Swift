//
//  GroupAnimationVC.swift
//  SwiftFunctions
//
//  Created by mac on 2021/1/4.
//

import UIKit

class GroupAnimationVC: UIViewController {

    var animation1 = CAKeyframeAnimation(keyPath: "position")
    var animation2 = CAKeyframeAnimation(keyPath: "backgroundColor")
    let groupAnimation = CAAnimationGroup()
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
        
        
//        animation1.duration = 4.0
//        animation1.fillMode = .forwards
//        animation1.isRemovedOnCompletion = false
        ///设置跟随动画转动动画物体
        animation1.rotationMode = .rotateAuto
        animation1.path = bezierPath.cgPath
        
        animation2.values = [UIColor.red.cgColor,UIColor.orange.cgColor,UIColor.yellow.cgColor,UIColor.green.cgColor]
//        animation2.fillMode = CAMediaTimingFillMode.forwards
//        animation2.isRemovedOnCompletion = false
//        animation2.duration = 4.0
        
        groupAnimation.animations = [animation1,animation2]
        groupAnimation.fillMode = .removed
        groupAnimation.isRemovedOnCompletion = true
        groupAnimation.duration = 4.0
        shipLayer.add(groupAnimation, forKey: "groupAnimation")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shipLayer.add(groupAnimation, forKey: "groupAnimation")
    }
}
