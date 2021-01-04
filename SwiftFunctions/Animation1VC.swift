//
//  Animation1VC.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/31.
//

import UIKit

class Animation1VC: UIViewController, CAAnimationDelegate {
    let colorLayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "显示动画1"
        setup()
    
    }
    
    private func setup() {
        view.layer.addSublayer(colorLayer)
        colorLayer.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        colorLayer.backgroundColor = UIColor.cyan.cgColor
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let alert = UIAlertController(title: "事件", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "事件1", style: .default, handler: { [unowned self](_) in
            let animation = CABasicAnimation(keyPath: "backgroundColor")
            animation.toValue = UIColor.blue.cgColor
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            animation.delegate = nil

            self.colorLayer.add(animation, forKey: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "事件2，有代理，动画后设置为最终值 ", style: .default, handler: { [unowned self](_) in
            let animation = CABasicAnimation(keyPath: "backgroundColor")
            animation.toValue = UIColor.yellow.cgColor
            animation.delegate = self
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            self.colorLayer.add(animation, forKey: nil)
        }))
        present(alert, animated: true)
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        let baseAnim = anim as! CABasicAnimation
        ///禁止隐式动画
        CATransaction.setDisableActions(false)
        self.colorLayer.backgroundColor = (baseAnim.toValue as! CGColor)
        CATransaction.commit()
    }

}
