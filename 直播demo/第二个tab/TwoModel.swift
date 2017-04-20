//
//  TwoModel.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/27.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class TwoModel: NSObject {
    var playUrl32:String?  //歌曲链接
    var title:String?  //歌曲名
    var nickname:String?  //作者
    var smallLogo:String?   //小图
    var coverLarge:String?  //大图
    class func loadData(OK: @escaping ([TwoModel])->()){
        NetWorkManager.post(url: "http://mobile.ximalaya.com/mobile/others/ca/album/track/242825/true/1/20") { (data) in
            let songAry = data["tracks"]?["list"]
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
