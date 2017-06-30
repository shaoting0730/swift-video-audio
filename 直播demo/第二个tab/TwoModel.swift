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
    var smallLogo:String?   //小图
    var coverLarge:String?  //大图
    var song_id:String? //歌曲id
    var title:String?  //歌曲名
    var author:String?  //作者
    static var songidAry:[String] = []   //songid数组
    class func loadData(OK: @escaping ([TwoModel])->()){
        NetWorkManager.requestData(url: "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=22&size=20&offset=0") { (data) in
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
        if(key == "song_id"){
            //把所有歌曲的songid放进数组中
            TwoModel.songidAry.append(value! as! String)
        }
    }
    
    //防止崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
