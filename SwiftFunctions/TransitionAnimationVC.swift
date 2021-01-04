//
//  TransitionAnimationVC.swift
//  SwiftFunctions
//
//  Created by mac on 2021/1/4.
//

import UIKit
///CATransition 个 type  和 subtype  来标识变换效果
class TransitionAnimationVC: UIViewController {
    var images:[UIImage] = [UIImage(named: "0")!,
                            UIImage(named: "1")!,
                            UIImage(named: "2")!,
                            UIImage(named: "3")!]
    var imageView = UIImageView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFit
        imageView.image = images.first
        view.addSubview(imageView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switchImages()
    }
    
    private func switchImages() {
        let transition = CATransition()
        transition.type = .fade
        transition.subtype = .fromLeft
        self.imageView.layer.add(transition, forKey: nil)
        
        let cur = self.imageView.image
        var index = images.firstIndex(of: cur!) ?? 0
        index = (index + 1) % images.count
        imageView.image = images[index]
    }
    

}
