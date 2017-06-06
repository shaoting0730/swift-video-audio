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
fileprivate let  RIGHTCOLLECTIONHEADER = "RIGHTCOLLECTIONHEADER"
class CollectionViewController: UIViewController {
    fileprivate lazy var categoryModel = [CollectionViewCategoryModel]()
    fileprivate lazy var subCategoryModel = [[SubCategoryModel]]()
    
    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    
    fileprivate lazy var leftTableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
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
        collectionView.register(CollectionViewHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: RIGHTCOLLECTIONHEADER)
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
        
        for category in categories! {
            let model = CollectionViewCategoryModel.init(dict: category)
            categoryModel.append(model)
            
            guard let subcategories = model.subcategories else { continue }
            
            var datas = [SubCategoryModel]()
            for subcategory in subcategories {
                datas.append(subcategory)
            }
            subCategoryModel.append(datas)
        }
        
        
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
       return categoryModel.count
    }
    //cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: LEFTTABLECELL, for: indexPath) as! LeftTableViewCell
        cell.nameLabel.text = categoryModel[indexPath.row].name
        return cell
    }

}

extension CollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategoryModel[section].count
    }
    //section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return subCategoryModel.count
    }
    //cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RIGHTCOLLECTIONCELL, for: indexPath) as! CollectionViewCell
        let model = subCategoryModel[indexPath.section][indexPath.row]
        cell.setDatas(model: model)
        return cell
    }
    //header height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 30)
    }
    //headerVIew
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: RIGHTCOLLECTIONHEADER, for: indexPath) as! CollectionViewHeaderView
            let model = categoryModel[indexPath.section]
            view.setDatas(model: model)
        return view
    }
}
