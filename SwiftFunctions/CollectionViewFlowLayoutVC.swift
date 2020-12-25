//
//  CollectionViewFlowLayoutVC.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/23.
//

import UIKit

class WaterFlowLayout: UICollectionViewFlowLayout {

    private var columnHeights:[CGFloat] = [CGFloat]()
    private var allAttributes:[UICollectionViewLayoutAttributes] = []
    init(itemSize:CGSize) {
        super.init()
        self.itemSize = itemSize
        minimumLineSpacing = 20
        minimumInteritemSpacing = 15
        sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            return
        }
        let n = getClumn()
        columnHeights.removeAll()
        for _ in 0..<n {
            ///初始化每列的高度
            columnHeights.append(sectionInset.top)
        }
        allAttributes.removeAll()
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        for i in 0..<itemsCount {
            if let attr = self.layoutAttributesForItem(at: IndexPath(item: i, section: 0)) {
                allAttributes.append(attr)
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        let maxHeight = columnHeights.max() ?? 0
        return CGSize(width: collectionView?.frame.size.width ?? 0, height: maxHeight + sectionInset.bottom)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return allAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView,
              let attributes = super.layoutAttributesForItem(at: indexPath) else {
            return nil
        }
        
        
        
//        let minHeights = columnHeights.enumerated().min { (e1, e2) -> Bool in
//            e1.element.value < e2.value
//        }
        var minColumn = 0
        var minHeight:CGFloat?
        for (index,value) in columnHeights.enumerated() {
            if minHeight == nil {
                minHeight = value
                minColumn = index
            } else if minHeight! > value {
                minHeight = value
                minColumn = index
            }
        }
        if minHeight == nil {
            return nil
        }
        
        let frame = attributes.frame
        ///除去标准的多出来的宽度,为了剧中，x坐标加上addtion * 0.5
        let addtion = collectionView.frame.width - sectionInset.left * 2 - (itemSize.width + minimumInteritemSpacing) * CGFloat(getClumn() - 1) - itemSize.width
        
        let x = sectionInset.left + (itemSize.width + minimumInteritemSpacing) * CGFloat(minColumn) + addtion * 0.5
        
        let y = (minHeight ?? 0) + minimumLineSpacing
        
        attributes.frame = CGRect(x: x, y: y, width: frame.width, height: frame.height)
        columnHeights[minColumn] = y + frame.height
        return attributes
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///根据设置的itemSize和sectionLeft，sectionRight，itemSpacing计算列数
    private func getClumn() -> Int {
        ///内容的宽度，除去左右边距
        guard let collectionView = collectionView else {
            return 0
        }
        let contentWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right
        ///计算item宽度+空隙的个数
        let itemAndSpaceWidth = itemSize.width + minimumInteritemSpacing
        var n: Int = Int(contentWidth / itemAndSpaceWidth)
        ///如果余数大于itemSize.width那么n加1
        let remainder = contentWidth.truncatingRemainder(dividingBy: itemAndSpaceWidth)
        
        if remainder > itemSize.width {
            n = n + 1
        }
        return n
    }
    
}

fileprivate let LabelFont = UIFont.systemFont(ofSize: 18)
class LXCollectionViewCell: UICollectionViewCell {
    let label:UILabel = UILabel(frame: CGRect.zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(label)
        label.font = LabelFont
        label.text = "测试"
        label.numberOfLines = 0
        self.addConstraintsToLabel()
        
    }
    

    
    func addConstraintsToLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        print("apply attributes \(layoutAttributes)")
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private let itemWidth = 60

class CollectionViewFlowLayoutVC: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    var dataSource :[String] = {
        var datas = [String]()
        for j in 0..<100 {
            var str:String = "\(j)\n"
            for i in 0...Int.random(in: 5...20) {
                str.append("\(i)")
            }
            datas.append(str)
        }
        return datas
    }()
    
    var collectionView:UICollectionView = {
        let layout = WaterFlowLayout(itemSize: CGSize(width: itemWidth, height: 50))
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.register(LXCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LXCollectionViewCell
        cell.backgroundColor = .red
        cell.label.text =  dataSource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = dataSource[indexPath.item]
        let size = (text as NSString).boundingRect(with: CGSize(width: itemWidth,height: 500), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:LabelFont], context: nil)
        return CGSize(width: itemWidth, height: max(Int(size.height), 50) + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView.bounds,collectionView.contentSize)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "纵向瀑布流"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushLeftWaterFlow))
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        collectionView.addAnchorConstraintToView(view: view)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    @objc
    func pushLeftWaterFlow() {
        navigationController?.pushViewController(BasicCollectionViewController(), animated: true)
    }
    
    

    

}
