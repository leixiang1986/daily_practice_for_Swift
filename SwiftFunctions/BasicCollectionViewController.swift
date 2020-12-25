//
//  BasicCollectionViewController.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/23.
//

import UIKit

private let reuseIdentifier = "Cell"
fileprivate let LabelFont = UIFont.systemFont(ofSize: 18)
class BasicCollectionCell: UICollectionViewCell {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.addSubview(label)
        label.font = LabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        print("apply attributes \(label.text)")
        super.apply(layoutAttributes)
    }
    
    
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        print("preferredLayoutAttributesFitting  \(label.text!),\(layoutAttributes.indexPath.item)")
//
//
//        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        var frame = attributes.frame
//        attributes.
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - LeftFlowLayout布局实现
class LeftFlowLayout: UICollectionViewFlowLayout {
    var allAttributes:[UICollectionViewLayoutAttributes] = []
    
    override init() {
        super.init()
        itemSize = CGSize(width: 50, height: 50)
        minimumInteritemSpacing = 15
        minimumLineSpacing = 20
        sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let allAttris = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        var lastAttributes :UICollectionViewLayoutAttributes? = nil
        for attr in allAttris {
            if lastAttributes == nil || attr.frame.origin.y != lastAttributes?.frame.origin.y {
                var frame = attr.frame
                frame.origin.x = sectionInset.left
                attr.frame = frame
            } else {
                
                var frame = attr.frame
                frame.origin.x = (lastAttributes?.frame.maxX ?? sectionInset.left) + minimumInteritemSpacing
                attr.frame = frame
            }
            lastAttributes = attr
        }
        return allAttris
    }
    
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return super.layoutAttributesForItem(at: indexPath)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BasicCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var layout:LeftFlowLayout = LeftFlowLayout()
    var dataSource :[String] = {
        var datas = [String]()
        for j in 0..<100 {
            var str:String = "\(j) "
            for i in 0...Int.random(in: 5...20) {
                str.append("\(i)")
            }
            datas.append(str)
        }
        return datas
    }()
    
    init() {
        super.init(collectionViewLayout: self.layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "左对齐瀑布流"
        self.view.backgroundColor = .white
        self.collectionView.backgroundColor = .white
        self.collectionView!.register(BasicCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasicCollectionCell
    
        cell.label.text = self.dataSource[indexPath.item]
    
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = dataSource[indexPath.item]
        let width = (text as NSString).boundingRect(with: CGSize(width: collectionView.bounds.width - layout.sectionInset.left * 2,height: 50), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:LabelFont], context: nil).width
        return CGSize(width: width + 5, height: 50)
    }
    
    // MARK: UICollectionViewDelegate

//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
