//
//  VirtualPropertyAnimationVC.swift
//  SwiftFunctions
//
//  Created by mac on 2021/1/4.
//

import UIKit
///CABasicAnimation和CAKeyFrameAnimation都是CAPropertyAnimation的子类,都是对单一属性进行操作的类
///用transform.rotation作为keypath比transform相比更好，
///1,可以通过byValue的相对值进行控制，对于大于180度的角度也可以旋转，而用transform在360度时不会旋转
///2,对于角度值不用创建transform3D，而只是角度数值.
///不会和其他的如transform.scale等冲突

class VirtualPropertyAnimationVC: UIViewController {
    var animation = CABasicAnimation()
    var shipLayer = CALayer()
    let label = UILabel(frame: CGRect(x: 10, y: 300, width: 300, height: 30))
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "虚拟属性-keyPath动画"
        view.backgroundColor = .white
        label.textColor = .black
        view.addSubview(label)
        
        shipLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        shipLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(shipLayer)

        let button1 = UIButton(type: .custom)
        button1.frame = CGRect(x: 10, y: 250, width: 100, height: 30)
        button1.addTarget(self, action: #selector(animation1), for: .touchUpInside)
        button1.backgroundColor = .lightGray
        button1.setTitle("transform", for: .normal)
        view.addSubview(button1)
        
        let button2 = UIButton(type: .custom)
        button2.frame = CGRect(x: 160, y: 250, width: 180, height: 30)
        button2.addTarget(self, action: #selector(animation2), for: .touchUpInside)
        button2.backgroundColor = .lightGray
        button2.setTitle("transform.rotation", for: .normal)
        view.addSubview(button2)
    }
    
    ///直接使用transform进行动画
    @objc
    private func animation1() {
        animation.keyPath = "transform"
        ///旋转2PI不会旋转
        if index % 2 == 1 {
            label.text = "旋转360度不会旋转"
            animation.toValue = CATransform3DMakeRotation(CGFloat(Double.pi * 2), 0, 0, 1)
        } else {
            label.text = "旋转180度"
            animation.toValue = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 0, 1)
        }
        index += 1
        
        shipLayer.add(animation, forKey: nil)
    }
    ///用transform.rotation动画
    @objc
    private func animation2() {
        animation.keyPath = "transform.rotation"
        animation.duration = 2.0
        animation.toValue = CGFloat(Double.pi * 2)
        shipLayer.add(animation, forKey: nil)
    }

}
