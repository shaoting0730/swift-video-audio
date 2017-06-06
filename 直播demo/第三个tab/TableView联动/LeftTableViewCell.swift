//
//  LeftTableViewCell.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/6.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

     lazy var nameLabel = UILabel()
    fileprivate lazy var yellowView = UIView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        nameLabel.frame = CGRect(x: 10, y: 10, width: 60, height: 40)
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(nameLabel)

        yellowView.frame = CGRect(x: 0, y: 5, width: 5, height: 45)
        yellowView.backgroundColor = UIColor.yellow
        contentView.addSubview(yellowView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        yellowView.isHidden = !selected
    }

}
