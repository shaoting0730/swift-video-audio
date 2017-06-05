//
//  TableViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/5.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
fileprivate let  LEFTTABLECELL = "LEFTTABLECELL"
fileprivate let RIGHTTABLECELL = "RIGHTTABLECELL"

class TableViewController: UIViewController {
    fileprivate lazy var leftTableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: LEFTTABLECELL)
        return tableView
    }()
    
    fileprivate lazy var rightTableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: RIGHTTABLECELL)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        addCons()
    }
    
    func addSubView(){
         self.view.addSubview(leftTableView)
         self.view.addSubview(rightTableView)
    }
    
    func addCons(){
         leftTableView.snp.makeConstraints { (make) in
             make.leading.equalTo(0)
             make.top.equalTo(64)
             make.height.equalTo(UIScreen.main.bounds.size.height)
             make.width.equalTo(80)
        }
        
        rightTableView.snp.makeConstraints { (make) in
            make.leading.equalTo(80)
            make.top.equalTo(64)
            make.height.equalTo(UIScreen.main.bounds.size.height)
            make.width.equalTo(UIScreen.main.bounds.size.width - 80)
        }
    }
    
}

extension TableViewController:UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 122
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: LEFTTABLECELL, for: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: RIGHTTABLECELL, for: indexPath)
            return cell
        }
    }
}
