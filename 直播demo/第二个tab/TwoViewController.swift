//
//  TwoViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/27.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
fileprivate let TwoTableViewCellIdentifie = "TwoTableViewCellIdentifie"
class TwoViewController: UIViewController {
    let viewModel = TwoViewModel()
    var twoModel = [TwoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }

    func layoutUI(){
        let tableView = UITableView.init(frame: self.view.bounds)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        viewModel.sectionCount = 1
        tableView.register(TwoTableViewCell.self, forCellReuseIdentifier: TwoTableViewCellIdentifie)
        self.view.addSubview(tableView)
        
        // 创建cell
        viewModel.cellRender = { indexPath,tablleView in
            let cell = tablleView.dequeueReusableCell(withIdentifier: TwoTableViewCellIdentifie, for: indexPath as IndexPath) as! TwoTableViewCell
            cell.twoModel = self.twoModel[indexPath.row]
            return cell
        }
        // cell点击事件
        viewModel.cellDidSelect = { indexPath,tablleView in
            let  playerVC = PlayerViewController()
            playerVC.song_id = self.twoModel[indexPath.row].song_id
            playerVC.songidAry = TwoModel.songidAry
            playerVC.currentIndex = indexPath.row
             self.navigationController?.pushViewController(playerVC, animated: false)
        }
        //获取数据
        TwoModel.loadData { (data) in
            self.viewModel.rawCount = data.count
            self.twoModel = data
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  }


