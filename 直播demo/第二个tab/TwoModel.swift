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
    var song_id:String?  //歌曲id
    class func loadData(OK: @escaping ([TwoModel])->()){
        NetWorkManager.post(url: "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=1&size=20&offset=0") { (data) in
            let songAry = data["song_list"]
            let model  = dict2Model(list: songAry as! [[String : AnyObject]])
            OK(model)
        }
    }
    
    class func dict2Model(list:[[String:AnyObject]])->[TwoModel]{
        var models = [TwoModel]()
        for dict in list{
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
