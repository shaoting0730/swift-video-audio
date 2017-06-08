//
//  TableViewHeaderView.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/6.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class TableViewHeaderView: UIView {
    lazy var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        nameLabel.frame = CGRect.init(x: 15, y: 0, width: 200, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(nameLabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
