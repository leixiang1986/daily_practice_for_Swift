//
//  TransitionLayerVC.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/30.
//

import UIKit

class TransitionLayerVC: UIViewController {
    let layerView = UIView()
    let colorLayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CALayer的转场动画"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "呈现图层", style: .plain, target: self, action: #selector(pushToPresentationLayer))
        setupUI()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc
    func pushToPresentationLayer() {
        navigationController?.pushViewController(PresentionLayerViewController(), animated: true)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        layerView.backgroundColor = .lightGray
        layerView.frame = CGRect(x: 50, y: 120, width: 300, height: 300)
        view.addSubview(layerView)
        
        colorLayer.backgroundColor = UIColor.red.cgColor
        colorLayer.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        
        ///转场动画
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.colorLayer.actions = ["backgroundColor":transition]
        self.layerView.layer.addSublayer(colorLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)

        colorLayer.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
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
