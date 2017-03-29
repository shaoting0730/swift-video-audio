//
//  TwoViewModel.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/28.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

typealias  cellRenderBlock = (_ indexPath:NSIndexPath,_ tableView:UITableView) -> UITableViewCell!
typealias  cellDidSelectBlcok = (_ indexPath:NSIndexPath,_ tableView:UITableView) -> Void

class TwoViewModel:NSObject,UITableViewDataSource,UITableViewDelegate  {
    var cellRender:cellRenderBlock!   //渲染cell回调
    var cellDidSelect:cellDidSelectBlcok?   //渲染点击cell回调
    var rawCount:Int = 0 //行数
    var sectionCount:Int = 0 //区数
    /** 区数 */
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionCount
    }
    //几个cell
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
      return rawCount
    }
   //返回cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = cellRender(indexPath as NSIndexPath,tableView)
        return cell!
    }
    
    /** 点击事件 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectBlock = cellDidSelect else{
            print("cell的选中block没有实例")
            return
        }
        selectBlock(indexPath as NSIndexPath,tableView)
    }

}


