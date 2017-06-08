//
//  foodModel.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/6.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class FoodModel: NSObject {
    var name:String?       //名字
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    //防止崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
