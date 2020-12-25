//
//  SecondViewTransitionVC.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/23.
//

import UIKit
/**
 UIView.transition(with:...这个方法是通过具体的view进行转场操作
 上一个界面用的是UIVIew.transition(from:to:)这个是整个控制器的view进行转场操作
 */
class SecondViewTransitionVC: UIViewController {
    var firstView:UIView!
    var secondView:UIView!
    var timer:Timer?
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "第二个view的转场动画"
        // Do any additional setup after loading the view.
        firstView = UIView(frame: CGRect(x: 60, y: 100, width: 300, height: 300))
        secondView = UIView(frame: CGRect(x: 60, y: 100, width: 300, height: 300))
        firstView.backgroundColor = .red
        secondView.backgroundColor = .blue
        secondView.isHidden = true
        view.addSubview(firstView)
        view.addSubview(secondView)
         
       timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self](_) in
            guard let self = self else {
                print("控制器已经销毁")
                return
            }
            self.flip()
        }
        
        
    }
    
    deinit {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        print("SecondViewTransitionVC deinit")
    }
    
    func flip(fromView:UIView,toView:UIView) {
        view.sendSubviewToBack(toView)
        fromView.isHidden = false
        UIView.transition(with: fromView, duration: 1, options: [.transitionCurlDown,.showHideTransitionViews]) {
//            first.isHidden = true
        } completion: { (result) in
            toView.isHidden = true
        }
        
//        UIView.transition(with: toView, duration: 1, options: [.transitionCurlDown,.showHideTransitionViews]) {
////            second.isHidden = false
//        } completion: { (result) in
//
//        }
    }
    
    @objc
    func flip() {
        if index == 0 {
            flip(fromView: secondView, toView: firstView)
            index = 1
        } else {
            flip(fromView: firstView, toView: secondView)
            index = 0
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
