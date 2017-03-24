//
//  UserModel.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/24.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var nick:String?       //名字
    var portrait:String?  //大图
    
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
