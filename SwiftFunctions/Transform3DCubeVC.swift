//
//  Transform3DCubeVC.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/30.
//

import UIKit

class Transform3DCubeVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet var faces: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "立方体"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "反射", style: .plain, target: self, action: #selector(pushReflaction))
        configFaces()
        
    }
    
    @objc
    func pushReflaction() {
        navigationController?.pushViewController(ReplicatorLayerVC(), animated: true)
    }
    
    private let kAngle = CGFloat(Double.pi / 2.0)
    func configFaces()  {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        perspective = CATransform3DRotate(perspective, -CGFloat(Double.pi / 4), 1, 0, 0)
        perspective = CATransform3DRotate(perspective, -CGFloat(Double.pi / 4), 0, 1, 0)
        ///知识点,设置父控件的统一透视变换
        containerView.layer.sublayerTransform = perspective
        ///face0
        var transform = CATransform3DMakeTranslation(0, 0, 25)
        addFace(index: 0, transform: transform)
        ///face1
        transform = CATransform3DMakeTranslation(25, 0, 0)
        transform = CATransform3DRotate(transform, kAngle, 0, 1, 0)
        addFace(index: 1, transform: transform)
        ///face2
        transform = CATransform3DMakeTranslation(0, -25, 0)
        transform = CATransform3DRotate(transform, kAngle, 1, 0, 0)
        addFace(index: 2, transform: transform)
        ///face3
        transform = CATransform3DMakeTranslation(0, 25, 0)
        transform = CATransform3DRotate(transform, kAngle, -CGFloat(Double.pi / 2), 0, 0)
        addFace(index: 3, transform: transform)
        ///face4
        transform = CATransform3DMakeTranslation(-25, 0, 0)
        transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2.0), 0, 1, 0)
        addFace(index: 4, transform: transform)
        ///face5
        transform = CATransform3DMakeTranslation(0, 0, -25)
        transform = CATransform3DRotate(transform, kAngle * 2, 0, 1, 0)
        addFace(index: 5, transform: transform)
    }
    
    func addFace(index:Int ,transform:CATransform3D) {
        guard index < faces.count else {
            return
        }
        let face = faces[index]
        self.containerView.addSubview(face)
        let containerSize = containerView.frame.size
        let center = CGPoint(x: containerSize.width * 0.5, y: containerSize.height * 0.5)
        face.center = center
        face.layer.transform = transform
        
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
