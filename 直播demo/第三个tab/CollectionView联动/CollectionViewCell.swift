//
//  CollectionViewCell.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/6.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    private lazy var imageV = UIImageView()
    private lazy var nameLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageV.frame = CGRect(x: 2, y: 2, width: frame.size.width - 4, height: frame.size.width - 4)
        imageV.contentMode = .scaleAspectFit
        contentView.addSubview(imageV)
        
        nameLabel.frame = CGRect.init(x: 2, y: frame.size.width + 2, width: frame.size.width - 4, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
    }
    func setDatas(){
        nameLabel.text = "33"
        imageV.image = #imageLiteral(resourceName: "1_selected")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
