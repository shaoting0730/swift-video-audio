//
//  TwoViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/27.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
private let TwoTableViewCellIdentifie = "TwoTableViewCellIdentifie"
class TwoViewController: UIViewController {
    let viewModel = TwoViewModel()
//    let model = TwoModel()
    private lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        
        tableView.register(TwoTableViewCell.self, forCellReuseIdentifier: TwoTableViewCellIdentifie)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
