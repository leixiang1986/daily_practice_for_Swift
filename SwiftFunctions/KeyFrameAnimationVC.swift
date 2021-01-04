//
//  KeyFrameAnimationVC.swift
//  SwiftFunctions
//
//  Created by mac on 2021/1/4.
//

import UIKit

///知识点：用动画代理方法获取结束，然后通过kvc获取动画作用的view，在动画结束后修改view的结束属性
class KeyFrameAnimationVC: UIViewController,CAAnimationDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColor()
        
    }
    
    private func changeColor() {
        let animation = CAKeyframeAnimation(keyPath: "backgroundColor")
        animation.values = [UIColor.red.cgColor,UIColor.orange.cgColor,UIColor.yellow.cgColor,UIColor.green.cgColor]
        animation.repeatCount = 1
        animation.duration = 4
        ///repeatCuration循环的总时间
//        animation.repeatDuration = 4
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self

        animation.setValue(self.view.layer, forKey: "handleLayer")
        self.view.layer.add(animation, forKey: nil)
    }
}

// MARK: - 动画
extension KeyFrameAnimationVC {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        ///通过KVC获取对应的操作对象
        let handleLayer = anim.value(forKey: "handleLayer") as? CALayer
        guard let layer = handleLayer else {
            return
        }
        let animation = anim as! CAKeyframeAnimation
        if let bgColor = animation.values?.last {
            layer.backgroundColor = (bgColor as! CGColor)
        }
        layer.removeAllAnimations()
        
    }
}
