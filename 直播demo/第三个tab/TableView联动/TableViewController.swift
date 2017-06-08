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
    var categoryModel = [CategoryModel]()
    var foodModel = [[FoodModel]]()
    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    
    fileprivate lazy var leftTableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55
        tableView.register(LeftTableViewCell.self, forCellReuseIdentifier: LEFTTABLECELL)
        return tableView
    }()
    
    fileprivate lazy var rightTableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.rowHeight = 80
        tableView.register(RightTableViewCell.self, forCellReuseIdentifier: RIGHTTABLECELL)
        return tableView
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
        let path = Bundle.main.path(forResource: "food", ofType: "json")   //加载本地数据
        let data = NSData.init(contentsOfFile: path!)! as Data
        let anyObject = try?   JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        let dict = anyObject as? [String:AnyObject]
        let ary =  dict?["food_spu_tags"] as? [[String : AnyObject]]
        
        for dict in ary! {
              let model = CategoryModel.init(dict: dict)
              categoryModel.append(model)
            
            let spus = model.food
            var datas = [FoodModel]()
            for food in spus! {
                 datas.append(food)
            }
            foodModel.append(datas)
        }
        
        
    }
    //添加视图
    func addSubView(){
         self.view.addSubview(leftTableView)
         self.view.addSubview(rightTableView)
    }
    //添加约束
    func addCons(){
         leftTableView.snp.makeConstraints { (make) in
             make.leading.equalTo(0)
             make.top.equalTo(0)
             make.height.equalTo(UIScreen.main.bounds.size.height)
             make.width.equalTo(80)
        }
        rightTableView.snp.makeConstraints { (make) in
            make.leading.equalTo(80)
            make.topMargin.equalTo(69)
            make.height.equalTo(UIScreen.main.bounds.size.height)
            make.width.equalTo(UIScreen.main.bounds.size.width - 80)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension TableViewController:UITableViewDelegate,UITableViewDataSource{
    //row
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == leftTableView {
             return categoryModel.count
        } else {
             return foodModel[section].count
        }
    }
    //section
    public func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == leftTableView {
           return 1
        }else{
            return categoryModel.count
        }
    }
    //cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: LEFTTABLECELL, for: indexPath) as! LeftTableViewCell
            cell.nameLabel.text = categoryModel[indexPath.row].name
             return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: RIGHTTABLECELL, for: indexPath) as! RightTableViewCell
            cell.nameLabel.text = foodModel[indexPath.section][indexPath.row].name
            return cell
        }
    }
    //header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == leftTableView {
           return nil
        }
        let headerView = TableViewHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 80, height: 20))
        let model = categoryModel[section]
        headerView.nameLabel.text = model.name
        return headerView
    }
    //headerView height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == leftTableView {
             return 0
        }else {
             return 20
        }
    }
    // 选中row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if leftTableView == tableView {
            selectIndex = indexPath.row
            rightTableView.scrollToRow(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: true)
            leftTableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        }
    }
    // 当拖动右边 TableView 的时候，处理左边 TableView
    private func selectRow(index : Int) {
        leftTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
    }
    // TableView 分区标题即将展示
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if (rightTableView == tableView) && !isScrollDown && rightTableView.isDragging {
            selectRow(index: section)
        }
    }
        // TableView分区标题展示结束
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
               if (rightTableView == tableView) && isScrollDown && rightTableView.isDragging {
            selectRow(index: section + 1)
        }
    }
    // 标记一下 RightTableView 的滚动方向，是向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = scrollView as! UITableView
        if rightTableView == tableView {
            isScrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        }
    }
    
}
