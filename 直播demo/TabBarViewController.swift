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
        //播放启动画面动画
        launchAnimation()

        
         addChildVCandRootVC(navTitle: "直播列表", tabTitle: "直播", rootVC: OneViewController(),img: #imageLiteral(resourceName: "1_"),img_selected: #imageLiteral(resourceName: "1_selected"))
         addChildVCandRootVC(navTitle: "歌曲列表", tabTitle: "歌曲", rootVC: TwoViewController(),img: #imageLiteral(resourceName: "2_"),img_selected: #imageLiteral(resourceName: "2_selected"))
         addChildVCandRootVC(navTitle: "Other", tabTitle: "其他", rootVC: ThreeViewController(),img: #imageLiteral(resourceName: "3_"),img_selected: #imageLiteral(resourceName: "3_selected"))
    }
    
    //播放启动画面动画
    private func launchAnimation() {
        let statusBarOrientation = UIApplication.shared.statusBarOrientation
        if let img = splashImageForOrientation(statusBarOrientation,
                                               size: self.view.bounds.size) {
            //获取启动图片
            let launchImage = UIImage(named: img)
            let launchview = UIImageView(frame: UIScreen.main.bounds)
            launchview.image = launchImage
            //将图片添加到视图上（分两种情况）
            //情况1:没有导航栏
            self.view.addSubview(launchview)
            //情况2:有导航栏
//            let delegate = UIApplication.shared.delegate
//            let mainWindow = delegate?.window
//            mainWindow!!.addSubview(launchview)
            
            //播放动画效果，完毕后将其移除
            UIView.animate(withDuration: 1, delay: 1.5, options: .beginFromCurrentState,
                           animations: {
                            launchview.alpha = 0.0
                            launchview.layer.transform = CATransform3DScale(
                                CATransform3DIdentity, 1.5, 1.5, 1.0)
            }) { (finished) in
                launchview.removeFromSuperview()
            }
        }
    }
    
    //获取启动图片名（根据设备方向和尺寸）
    func splashImageForOrientation(_ orientation: UIInterfaceOrientation, size: CGSize)
        -> String?{
            //获取设备尺寸和方向
            var viewSize = size
            var viewOrientation = "Portrait"
            
            if UIInterfaceOrientationIsLandscape(orientation) {
                viewSize = CGSize(width: size.height, height: size.width)
                viewOrientation = "Landscape"
            }
            
            //遍历资源库中的所有启动图片，找出符合条件的
            if let imagesDict = Bundle.main.infoDictionary  {
                if let imagesArray = imagesDict["UILaunchImages"] as? [[String: String]] {
                    for dict in imagesArray {
                        if let sizeString = dict["UILaunchImageSize"],
                            let imageOrientation = dict["UILaunchImageOrientation"] {
                            let imageSize = CGSizeFromString(sizeString)
                            if imageSize.equalTo(viewSize)
                                && viewOrientation == imageOrientation {
                                if let imageName = dict["UILaunchImageName"] {
                                    return imageName
                                }
                            }
                        }
                    }
                }
            }
            
            return nil
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
