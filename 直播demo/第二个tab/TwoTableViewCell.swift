//
//  TwoTableViewCell.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/28.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
protocol TwoTableViewCellDatasource {
    var title:String{get}
    var author:String{get}
}

protocol TwoTableViewCellDelegate{
    func didSelectCell()
}

class TwoTableViewCell: UITableViewCell {
    fileprivate var dataSource:TwoTableViewCellDatasource?
    fileprivate var delegate:TwoTableViewCellDelegate?
    
    func configure(withDataSource dataSource:TwoTableViewCellDatasource,delegate:TwoTableViewCellDelegate){
        self.dataSource = dataSource
        self.delegate  = delegate
        
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
