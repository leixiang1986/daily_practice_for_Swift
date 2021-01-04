//
//  HomeTableViewController.swift
//  SwiftFunctions
//
//  Created by mac on 2020/12/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var titles:[String] = []
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        ///知识点 点击或上下滑动隐藏导航栏
        navigationController?.hidesBarsOnSwipe = true
//        navigationController?.hidesBarsOnTap = true
        ///知识点 TableView编辑时是否可以点击
        tableView.allowsSelectionDuringEditing = true
        addTitles()
        ///知识点 设置导航栏背景图片
//        let image = UIImage(named: "")
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        ///设置下一界面的返回按钮文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.barTintColor = .cyan
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setTableEditing))
        
        self.clearsSelectionOnViewWillAppear = true
        self.tableView.tableFooterView = UIView()
        
        ///知识点 设置分割线为0
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    @objc
    func setTableEditing() {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
    func addTitles() {
        titles.append("自定义tableView事件--左滑和选中背景")
        titles.append("view 转场动画")
        titles.append("UICollectionView 流水布局")
        titles.append("系统分享")
        titles.append("CALayer相关")
    }
    ///知识点 是否隐藏状态栏,对非留海屏有效
    ///调用setNeedsStatusBarAppearanceUpdate会重新更新
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row];
        let selectedView = UIView()
        selectedView.backgroundColor = .yellow
        ///知识点，设置选中背景
        cell.selectedBackgroundView = selectedView
        // Configure the cell...
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        if title == "view 转场动画" {
            let vc = ViewTransitionVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if title == "UICollectionView 流水布局" {
            let vc = CollectionViewFlowLayoutVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if title == "系统分享" {
            let image = UIImage(named: "image0")!
           let vc = UIActivityViewController(activityItems: [image,
            "内容"], applicationActivities: nil)
            present(vc, animated: true, completion: nil)
        } else if title == "CALayer相关" {
            let vc = LayerAboutViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
//            知识点 强制调用 prefersStatusBarHidden更新状态
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        print("willPerformPreviewActionForMenuWith")
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .delete
        } else if indexPath.row == 1 {
            return .insert
        } else {
            return .none
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            titles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//                // delete item at indexPath
//            }
//
//            let share = UITableViewRowAction(style: .normal, title: "Disable") { (action, indexPath) in
//                // share item at indexPath
//            }
//
//            share.backgroundColor = UIColor.blue
//
//            return [delete, share]
//    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action0 = UIContextualAction(style: .normal, title: "测试") { (action, view, complete) in
            view.backgroundColor = .yellow
            print("点击了测试")
            complete(true)
        }
        action0.backgroundColor = .yellow
        let action1 = UIContextualAction(style: .normal, title: "分享") { (action, view, complete) in
            view.backgroundColor = .yellow
            print("点击了分享")
            complete(true)
        }
        let action2 = UIContextualAction(style: .destructive, title: "删除") { (action, view, complete) in
            view.backgroundColor = .cyan
            print("点击了删除")
            complete(true)
        }
        action2.backgroundColor = .cyan
        let config = UISwipeActionsConfiguration(actions: [action0,action1,action2])
        return config
        
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("开始摇一摇")
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
