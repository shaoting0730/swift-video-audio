//
//  CollectionViewHeaderView.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/6.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class CollectionViewHeaderView: UICollectionReusableView {
  
    private lazy var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        titleLabel.frame = CGRect(x: 0, y: 5, width: UIScreen.main.bounds.size.width - 80, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    
    func setDatas(model : CollectionViewCategoryModel) {
        
        let name = model.name 
        
        titleLabel.text = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
