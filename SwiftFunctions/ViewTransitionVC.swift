//
//  ViewTransitionVC.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/21.
//

import UIKit

class ViewTransitionVC: UIViewController {
    let first:UIView = {
        let view = UIView()
        view.frame = CGRect(x: 100, y: 100, width: 300, height: 300)
        view.backgroundColor = .red
        return view
    }()
    let second:UIView = {
        let view = UIView()
        view.frame = CGRect(x: 100, y: 100, width: 300, height: 300)
        view.backgroundColor = .blue
        view.isHidden = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "第一个view的动画转场,屏幕旋转"
        // Do any additional setup after loading the view.
        view.addSubview(first)
        view.addSubview(second)
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(secondTransitionVC))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dealTransition()
    }
    @objc
    func secondTransitionVC() {
        navigationController?.pushViewController(SecondViewTransitionVC(), animated: true)
    }
    
    func dealTransition() {
        if first.isHidden {
            transition(from: second, to: first)

        } else {
            transition(from: first, to: second)        }
        
    }
    
    func transition(from:UIView,to:UIView)  {
        UIView.transition(from: from, to: to, duration: 0.2, options: .transitionFlipFromTop) {(result) in
            to.isHidden = false
            from.isHidden = true
        }
    }
}


