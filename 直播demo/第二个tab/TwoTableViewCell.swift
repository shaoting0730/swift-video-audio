//
//  TwoTableViewCell.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/28.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import SnapKit

class TwoTableViewCell: UITableViewCell {
     lazy var titleAuthorLabel:UILabel = {
          let label = UILabel.init(frame: CGRect.zero)
          label.textColor  = UIColor.white
          return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupUI()
        addCons()
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        //设置渐变的主颜色
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        //将gradientLayer作为子layer添加到主layer上
        titleAuthorLabel.layer.addSublayer(gradientLayer)
    }
    
    func setupUI(){
      contentView.addSubview(titleAuthorLabel)
    }
    
    func addCons(){
        titleAuthorLabel.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.trailingMargin.equalTo(0)
            make.leading.equalTo(0)
            make.centerY.equalTo(22)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
