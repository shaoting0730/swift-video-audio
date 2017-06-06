//
//  RightTableViewCell.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/6.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {
    lazy var nameLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.frame = CGRect(x: 10, y: 10, width: 200, height: 60)
        contentView.addSubview(nameLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
