//
//  NetWorkManager.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/21.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import Alamofire
class NetWorkManager: NSObject {
    public class func requestData(url:String,result:@escaping ([NSString:AnyObject])->()){
        Alamofire.request(url).responseJSON { (response) in
           result(response.result.value as! [NSString : AnyObject])
        }
    }
}
