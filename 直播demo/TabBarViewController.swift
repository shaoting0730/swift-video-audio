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
         addChildVCandRootVC(navTitle: "直播列表", tabTitle: "直播", rootVC: OneViewController(),img: #imageLiteral(resourceName: "1_"),img_selected: #imageLiteral(resourceName: "1_selected"))
         addChildVCandRootVC(navTitle: "歌曲列表", tabTitle: "歌曲", rootVC: TwoViewController(),img: #imageLiteral(resourceName: "2_"),img_selected: #imageLiteral(resourceName: "2_selected"))
         addChildVCandRootVC(navTitle: "3", tabTitle: "三", rootVC: ThreeViewController(),img: #imageLiteral(resourceName: "3_"),img_selected: #imageLiteral(resourceName: "3_selected"))
         addChildVCandRootVC(navTitle: "4", tabTitle: "四", rootVC: FourViewController(),img: #imageLiteral(resourceName: "4_"),img_selected: #imageLiteral(resourceName: "4_selected"))
        
    }
    
    func addChildVCandRootVC(navTitle:String,tabTitle:String,rootVC:UIViewController,img:UIImage,img_selected:UIImage){
        let rNav = UINavigationController.init(rootViewController: rootVC)
        rootVC.title = navTitle
        rootVC.tabBarItem.image = img
        rootVC.tabBarItem.selectedImage = img_selected
        rootVC.tabBarItem.title = tabTitle
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
