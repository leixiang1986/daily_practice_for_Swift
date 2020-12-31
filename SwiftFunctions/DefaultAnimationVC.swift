//
//  DefaultAnimationVC.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/30.
//

import UIKit
///知识点：1,UIView是如何屏蔽隐式动画的?
///CALayer在实现动画时会向 CALayerDelegate 协议指定的 - actionForLayer:forKey方法获取动画，如果没有就从atcions中获取。
///UIView中没有实现 - actionForLayer:forKey所以，动画为nil，即不执行动画。
///要是UIView有动画功能使用UIView.animate...方法，或者继承UIView实现- actionForLayer:forKey

///2,屏蔽CALayer的隐式动画
/// CATransaction.setDisableActions(true)
class DefaultAnimationVC: UIViewController {
    let colorView = UIView()
    
    let colorLayer = CALayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CALayer转场动画", style: .plain, target: self, action: #selector(pushToLayerTransition))
        
        view.backgroundColor = .white
        colorView.frame = CGRect(x: 100, y: 150, width: 200, height: 200)
        colorView.layer.backgroundColor = UIColor.blue.cgColor
        view.addSubview(colorView)
        
        colorLayer.frame = CGRect(x: 100, y: 350, width: 200, height: 200)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        
        view.layer.addSublayer(colorLayer)
        // Do any additional setup after loading the view.
    }
    
    @objc
    func pushToLayerTransition() {
        let vc = TransitionLayerVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        changeViewColor()
        changeLayerColor()
    }
    
    func changeViewColor()  {
        CATransaction.begin()
        CATransaction.setCompletionBlock {[unowned self] in
            var transform = self.colorView.layer.transform
            transform = CATransform3DRotate(transform, CGFloat(Double.pi / 4), 0, 0, 1)
            self.colorView.layer.transform = transform
        }

        CATransaction.setAnimationDuration(1.0)

        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)

        colorView.layer.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        CATransaction.commit()
        
    }
    
    func changeLayerColor() {
        
        let i:Int = Int.random(in: 0...1)
        let disableActions = i == 0
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {[unowned self] in
            var transform = self.colorLayer.transform
            transform = CATransform3DRotate(transform, CGFloat(Double.pi / 4), 0, 0, 1)
            self.colorLayer.transform = transform
        }

        CATransaction.setAnimationDuration(1.0)

        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        ///这里随机关闭隐式动画
        CATransaction.setDisableActions(disableActions)
        colorLayer.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        CATransaction.commit()
        
        
        
    }

}
