//
//  OneTableViewCell.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/23.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
class OneTableViewCell: UITableViewCell {
    //头像
    lazy var userimageView:UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.zero)
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 6
        return imgView
    }()
    //名字
    lazy var nameLabel:UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        return label
    }()
    //城市
    lazy var cityLabel:UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        return label
    }()
    //大图
    lazy var userBigImg:UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.zero)
        imgView.alpha = 0
        return imgView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.addCons()
        UIView.animate(withDuration: 2, animations: {
            self.userBigImg.alpha = 1
        })
        
    }
    func setupUI(){
        contentView.addSubview(userimageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(userBigImg)
    }
    func addCons(){
        userimageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.leading.equalTo(5)
            make.top.equalTo(5)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width-65)
            make.height.equalTo(30)
            make.leftMargin.equalTo(userimageView.snp.right).offset(10)
            make.top.equalTo(5)
        }
        cityLabel.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width-65)
            make.height.equalTo(30)
            make.leftMargin.equalTo(userimageView.snp.right).offset(10)
            make.topMargin.equalTo(nameLabel.snp.bottom).offset(5)
        }
        userBigImg.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(230)
            make.topMargin.equalTo(userimageView.snp.bottom).offset(10)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
