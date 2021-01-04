//
//  PresentionLayerViewController.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/31.
//

import UIKit
///知识点，动画过程中要判断是否点击到要用presentation()方法获取呈现图层来判断，不能用layer本身来判断
class PresentionLayerViewController: UIViewController {
    let colorLayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "呈现图层"
        colorLayer.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        colorLayer.backgroundColor = UIColor.random().cgColor
        view.layer.addSublayer(colorLayer)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: view)
        guard let presentationLayer = colorLayer.presentation() else {
            colorLayer.center = location
            return
        }
        
        if presentationLayer.frame.contains(location) {
            colorLayer.backgroundColor = UIColor.random().cgColor
        } else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(2)
            colorLayer.center = location
            CATransaction.commit()
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
