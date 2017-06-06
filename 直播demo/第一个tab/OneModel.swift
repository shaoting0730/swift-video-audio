//
//  OneModel.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/23.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class OneModel: NSObject {
   var name:String?//标签
   var city:String?  //所在城市
   var stream_addr:String?  //视频地址
   var user:UserModel?  //用户信息模型
    class func loadData(OK: @escaping ([OneModel])->()){
        NetWorkManager.post(url: "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1") { (data) in
            let livesAry = data["lives"]
            let model  = dict2Model(list: livesAry as! [[String : AnyObject]])
            OK(model)
        }
    }
    
    class func dict2Model(list:[[String:AnyObject]])->[OneModel]{
     var models = [OneModel]()
        for dict in list{
           models.append(OneModel.init(dict: dict))
        }
        return models
    }
    
    init(dict:[String:AnyObject]) {
       super.init()
       setValuesForKeys(dict)
    }
    
     override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if "creator" == key {
            user = UserModel.init(dict: value as! [String : AnyObject])//创建一个Usermodel
        }
    }
    
    //防止崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
