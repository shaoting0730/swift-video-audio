//
//  CollectionViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/6.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
fileprivate let  LEFTTABLECELL = "LEFTTABLECELL"
fileprivate let  RIGHTCOLLECTIONCELL = "RIGHTCOLLECTIONCELL"
class CollectionViewController: UIViewController {
    fileprivate lazy var leftTableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55
        tableView.register(LeftTableViewCell.self, forCellReuseIdentifier: LEFTTABLECELL)
        return tableView
    }()
    
    fileprivate lazy var flowLayout:UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize.init(width: 100, height: 100)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        return flowLayout
    }()
    
    fileprivate lazy var rightCollectionView:UICollectionView = {
         let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: RIGHTCOLLECTIONCELL)
        return collectionView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()  //加载数据
        addSubView()  //添加视图
        addCons()   //添加约束
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        
    }
    //加载数据
    func loadData(){
        let path = Bundle.main.path(forResource: "liwushuo", ofType: "json")   //加载本地数据
        let data = NSData.init(contentsOfFile: path!)! as Data
        let anyObject = try?   JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        let dict = anyObject as? [String:AnyObject]
        let datas =  dict?["data"] as? [String : AnyObject]
        let categories = datas?["categories"] as? [[String:AnyObject]]
        
        
        
    }
    //添加视图
    func addSubView(){
        self.view.addSubview(leftTableView)
        self.view.addSubview(rightCollectionView)
    }
    //添加约束
    func addCons(){
        leftTableView.snp.makeConstraints { (make) in
            make.leading.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(UIScreen.main.bounds.size.height)
            make.width.equalTo(80)
        }
        rightCollectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(80)
            make.topMargin.equalTo(69)
            make.height.equalTo(UIScreen.main.bounds.size.height)
            make.width.equalTo(UIScreen.main.bounds.size.width - 80)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

extension CollectionViewController:UITableViewDelegate,UITableViewDataSource{
    //row
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       return 11
    }
    //cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: LEFTTABLECELL, for: indexPath) as! LeftTableViewCell
        return cell
    }

}

extension CollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RIGHTCOLLECTIONCELL, for: indexPath) as! CollectionViewCell
        cell.setDatas()
        return cell
    }

}
