//
//  Transform3DViewController.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/29.
//

import UIKit
///知识点：layer的sublayerTransform属性设置了子view或子layer的共同变换，可以共用一个灭点
class Transform3DViewController: UIViewController {
    var imageView0 :UIImageView!
    var imageView1: UIImageView!
    var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.frame = CGRect(x: 10, y: 100, width: 400, height: 200)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageView0 = createImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView1 = createImageView(frame: CGRect(x: 250, y: 0, width: 150, height: 150))
        containerView.addSubview(imageView0)
        containerView.addSubview(imageView1)
        view.addSubview(containerView)
        
        // Do any additional setup after loading the view.
    }
    
    func createImageView(frame:CGRect) -> UIImageView {
        let image = UIImage(named: "image0")
        let  imageView = UIImageView(image: image)
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if CATransform3DEqualToTransform(imageView0.transform3D, CATransform3DIdentity) {
            var transform3D = CATransform3DIdentity
            transform3D.m34 = -1.0 / 500.0
            ///知识点：layer的sublayerTransform属性设置了子view或子layer的共同变换，可以共用一个灭点
            containerView.layer.sublayerTransform = transform3D
            UIView.animate(withDuration: 0.5) {[unowned self] in
                
                transform3D = CATransform3DMakeRotation(CGFloat(Double.pi / 4), 0, 1, 0)
                self.imageView0.transform3D = transform3D
                transform3D = CATransform3DMakeRotation(-CGFloat(Double.pi / 4), 0, 1, 0)
                self.imageView1.transform3D = transform3D
            }
        } else {
            UIView.animate(withDuration: 0.5) {[unowned self] in
                self.imageView0.transform3D = CATransform3DIdentity
                self.imageView1.transform3D = CATransform3DIdentity
            }
        }
        
        
    }
    
    

}
