//
//  ViewController.swift
//  导航栏渐变
//
//  Created by ty on 16/1/3.
//  Copyright © 2016年 ty. All rights reserved.
//

import UIKit

// 顶部图片的高度
private let topImageHeight: CGFloat = 200
// 顶部图片
private var topImag: UIImageView?
// 自定义导航栏
private var customNavc: UIView?
// 自定义返回按钮
private var customBackBtn: UIButton?
// 当导航栏透明的时候 加载在view上的按钮
private var viewBackBtn: UIButton?
// 自定义导航栏标题
private var customTitleLabel: UILabel?
// // 当导航栏透明的时候 加载在view上的标题
private var viewTitleLabel: UILabel?

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 顶部图片
        let topImage = UIImageView(frame: CGRect(x: 0, y:-topImageHeight, width: view.bounds.width, height: topImageHeight))
        topImage.image = UIImage(named: "ceshi.jpg")
        topImage.contentMode = .scaleAspectFill
        topImage.clipsToBounds = true
        topImag = topImage
        
        // tableView
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        tableView.delegate = self
        tableView.dataSource = self;
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(topImageHeight, 0, 0, 0)
        tableView.addSubview(topImage)
        
        // 自定义导航栏
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 64))
        view.addSubview(backView)
        backView.backgroundColor = UIColor.white
        backView.alpha = 0.0
        customNavc = backView
        
        // 自定义返回按钮
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        backBtn.setImage(UIImage(named: "back_0"), for: UIControlState())
        backView.addSubview(backBtn)
        customBackBtn = backBtn
        
        // 返回按钮
        let btn = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        btn.setImage(UIImage(named: "back_0"), for: UIControlState())
        view.addSubview(btn)
        viewBackBtn = btn
        
        // 自定义标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        titleLabel.center = CGPoint(x: view.frame.width / 2, y: 20 + 22)
        titleLabel.text = "标题"
        titleLabel.textColor = UIColor.white
        customTitleLabel = titleLabel
        customNavc?.addSubview(titleLabel)
        
        // 标题
        let viewTitleLabe = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        viewTitleLabe.center = CGPoint(x: view.frame.width / 2, y: 20 + 22)
        viewTitleLabe.text = "标题"
        viewTitleLabe.textColor = UIColor.black
        viewTitleLabel = viewTitleLabe
        view?.addSubview(titleLabel)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell!.textLabel!.text = "cell\(indexPath.row)"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offY = scrollView.contentOffset.y
        // 根据偏移量改变alpha的值
        customNavc?.alpha = (offY + 64) / (topImageHeight - 64) + 1
        // 设置图片的高度 和 Y 值
        if offY < -topImageHeight {
            topImag?.frame.origin.y = offY
            topImag?.frame.size.height = -offY
        }
        
        // 改变导航栏（自定义View）返回按钮的图片 和 标题颜色
        if offY >= -64 {
            customBackBtn?.setImage(UIImage(named: "back_1"), for: UIControlState())
            viewBackBtn?.isHidden = true
            customTitleLabel?.textColor = UIColor.black
        } else {
            customBackBtn?.setImage(UIImage(named: "back_0"), for: UIControlState())
            viewBackBtn?.isHidden = false
            customTitleLabel?.textColor = UIColor.white
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

