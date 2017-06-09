//
//  PageViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/8.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1,创建需要的样式
        let style = SKFPageStyle()
        style.isScrollEnabel=true
        style.isShowBottomLine=true
        style.isScaleEnable=true
        
        //2.获取所有的标题
        let  titles = ["精选","电影","小龙虾","皮皮虾","京酱肉丝","还有啥","可口可乐","百事可乐","雪碧芬达"]
        
        //3,获取所有的内容控制器
        var childVcs = Array<UIViewController>()
        for _ in 0..<titles.count {
            let vc=UIViewController()
            vc.view.backgroundColor=UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
            childVcs.append(vc)
        }
        //4,创建SKFPageView
        automaticallyAdjustsScrollViewInsets=false
        
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height-64)
        let pageView=SKFPageView(frame: pageFrame, style: style, titles: titles, childVcs: childVcs,parentVc:self)
        pageView.backgroundColor = .blue
        view.addSubview(pageView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
