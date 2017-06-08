//
//  CollectionViewCategoryModel.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/6.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//
import UIKit

class CollectionViewCategoryModel :  NSObject {
    var name:String?
    var subcategories : [SubCategoryModel]?

    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "subcategories" {
            subcategories = Array()
            guard let datas = value as? [[String : Any]] else { return }
            for dict in datas {
                let subModel = SubCategoryModel(dict: dict as [String : AnyObject])
                subcategories?.append(subModel)
            }
        }
    }
    
    //防止崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
