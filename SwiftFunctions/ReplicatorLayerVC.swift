//
//  ReplicatorLayerVC.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/30.
//

import UIKit

class ReplicatorView: UIView {
    static override var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        let reLayer = layer as! CAReplicatorLayer
        reLayer.instanceCount = 2
        
        var transform = CATransform3DIdentity
        let vOffset = bounds.height + 2.0
        transform = CATransform3DTranslate(transform, 0, vOffset, 0)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi), 1, 0, 0)
        reLayer.instanceTransform = transform
        reLayer.instanceAlphaOffset = -0.6
    }
}

class ReplicatorLayerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "隐式动画", style: .plain, target: self, action: #selector(pushDefaultAnimation))
        
        let reflectView = ReplicatorView()
        reflectView.frame = CGRect(x: 100, y: 100, width: 250, height: 300)
//        reflectView.backgroundColor = UIColor.red
        view.addSubview(reflectView)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        imageView.image = UIImage(named: "image0")
        reflectView.addSubview(imageView)
        // Do any additional setup after loading the view.
    }
    
    @objc
    func pushDefaultAnimation() {
        navigationController?.pushViewController(DefaultAnimationVC(), animated: true)
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
