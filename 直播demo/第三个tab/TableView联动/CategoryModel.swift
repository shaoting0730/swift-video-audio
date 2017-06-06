//
//  CategoryModel.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/5.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class CategoryModel :  NSObject {
    var name:String?
    var food:[FoodModel]?

    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "spus"{
            food = Array()
            let datas = value as? [[String:AnyObject]]
            for dict in datas! {
                let foodModel = FoodModel.init(dict: dict)
                food?.append(foodModel)
            }
        }
    }

    //防止崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
