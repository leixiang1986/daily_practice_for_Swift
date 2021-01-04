//
//  LayerAboutViewController.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/31.
//

import UIKit

class LayerAboutViewController: UITableViewController {
    var titles = [(title:String,vc:UIViewController.Type)]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "图层相关"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        setupData()
    }
    
    private func setupData() {
        titles.append(("同一个灭点",Transform3DViewController.self))
        titles.append(("立方体",Transform3DCubeVC.self))
        titles.append(("反射",ReplicatorLayerVC.self))
        titles.append(("隐式动画",DefaultAnimationVC.self))
        titles.append(("CALayer转场动画",TransitionLayerVC.self))
        titles.append(("呈现图层响应点击事件",PresentionLayerViewController.self))
        titles.append(("基础动画",Animation1VC.self))
        titles.append(("关键帧动画",KeyFrameAnimationVC.self))
        titles.append(("关键帧path动画",KeyFrameAnimPathVC.self))
        titles.append(("虚拟属性动画-transform",VirtualPropertyAnimationVC.self))
        titles.append(("groupAnimation",GroupAnimationVC.self))
        titles.append(("过渡动画-CATransition",TransitionAnimationVC.self))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")
        cell?.textLabel?.text = titles[indexPath.row].title
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if titles[indexPath.row].title == "立方体"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Transform3DCubeVC")
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vcClass = titles[indexPath.row].vc
            let vc =  vcClass.init()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    

    

}
