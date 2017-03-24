//
//  TabBarViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/21.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
         addChildVCandRootVC(navTitle: "直播列表", tabTitle: "直播", rootVC: OneViewController())
         addChildVCandRootVC(navTitle: "歌曲列表", tabTitle: "歌曲", rootVC: TwoViewController())
    }
    
    func addChildVCandRootVC(navTitle:String,tabTitle:String,rootVC:UIViewController){
        let rNav = UINavigationController.init(rootViewController: rootVC)
        rootVC.title = navTitle
        rNav.title =  tabTitle
        self.addChildViewController(rNav)
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
