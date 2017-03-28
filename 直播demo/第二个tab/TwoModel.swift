//
//  TwoModel.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/27.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class TwoModel: NSObject {
    var author:String?  //作者
    var title:String?  //歌曲名
    
    func dict2Model(list:[[String:AnyObject]])->[TwoModel]{
      var models = [TwoModel]()
        for dict in list {
              models.append(TwoModel.init(dict: dict))
        }
        return models
    }
    
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
