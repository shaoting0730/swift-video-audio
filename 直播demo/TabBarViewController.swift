//
//  TabBarViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/21.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
class TabBarViewController: UITabBarController {
    var launchview:UIImageView!
    var shapeLayer:CAShapeLayer!
    var goHomeBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //播放启动画面动画
        launchAnimation()

        //添加tabBar NavigationBar 国际化
         addChildVCandRootVC(navTitle: NSLocalizedString("videoList", comment: "") ,tabTitle: NSLocalizedString("video", comment: ""), rootVC: OneViewController(),img: #imageLiteral(resourceName: "1_"),img_selected: #imageLiteral(resourceName: "1_selected"))
         addChildVCandRootVC(navTitle:NSLocalizedString("audioList", comment: ""), tabTitle: NSLocalizedString("audio", comment: ""), rootVC: TwoViewController(),img: #imageLiteral(resourceName: "2_"),img_selected: #imageLiteral(resourceName: "2_selected"))
         addChildVCandRootVC(navTitle: NSLocalizedString("other", comment: ""), tabTitle: NSLocalizedString("other", comment: ""), rootVC: ThreeViewController(),img: #imageLiteral(resourceName: "3_"),img_selected: #imageLiteral(resourceName: "3_selected"))
    }
    
    //播放广告页面
    private func launchAnimation() {
        let statusBarOrientation = UIApplication.shared.statusBarOrientation
        if let imgg = splashImageForOrientation(statusBarOrientation,
                                               size: self.view.bounds.size) {
            let imgAry = ["https://ws1.sinaimg.cn/large/610dc034gy1fh9utulf4kj20u011itbo.jpg","http://7xi8d6.com1.z0.glb.clouddn.com/2017-03-24-17438359_1470934682925012_1066984844010979328_n.jpg","http://ww1.sinaimg.cn/large/610dc034ly1fhxe0hfzr0j20u011in1q.jpg","http://ww4.sinaimg.cn/mw690/9844520fjw1f4fqribdg1j21911w0kjn.jpg"]
            let index = (Int)(0 + arc4random() % (3 - 0 + 1))
            var img:UIImage!
            do {
                let url:URL = URL.init(string: imgAry[index])!
                img = try UIImage.init(data: Data.init(contentsOf: url))!
            } catch  {
                img  = UIImage.init(named: imgg)  //如果没有网络播放启动页面
            }
            
            //获取启动图片
            let launchImage = img
            launchview = UIImageView(frame: UIScreen.main.bounds)
            launchview.image = launchImage
            
            goHomeBtn = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width - 50, y: 20, width: 40, height: 40))
            goHomeBtn.setTitle("跳过", for: .normal)
            goHomeBtn.setTitleColor(UIColor.white, for: .normal)
            goHomeBtn.addTarget(self, action: #selector(self.goHomeViewAction), for: .touchUpInside)
            
            
            
            //将图片添加到视图上（分两种情况）
            //情况1:没有导航栏
            self.view.addSubview(launchview)
            self.view.insertSubview(goHomeBtn, aboveSubview: self.view)
            self.launchview.layer.addSublayer(progressView())
            //情况2:有导航栏
//            let delegate = UIApplication.shared.delegate
//            let mainWindow = delegate?.window
//            mainWindow!!.addSubview(launchview)
            
            
            //播放动画效果，完毕后将其移除
            UIView.animate(withDuration: 1, delay: 3, options: .beginFromCurrentState,
                           animations: {
                            self.launchview.alpha = 0.0
                            self.launchview.layer.transform = CATransform3DScale(
                                CATransform3DIdentity, 1.5, 1.5, 1.0)
            }) { (finished) in
                self.launchview.removeFromSuperview()
                self.goHomeBtn.removeFromSuperview()
            }
        }
    }
//    MARK:进入首页
    func goHomeViewAction(){
        self.launchview.removeFromSuperview()
        self.goHomeBtn.removeFromSuperview()
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
//    MARK:进度圆环
    func progressView() -> CAShapeLayer{
        //创建一个Layer用于显示
        shapeLayer = CAShapeLayer()
        //设置区域
        shapeLayer.frame = view.bounds
        //边框颜色
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = nil
        //边框宽度
        shapeLayer.lineWidth = 2
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x:UIScreen.main.bounds.size.width - 50 , y: 20, width:40, height :40 ), cornerRadius: 20).cgPath
        //创建动画
        let drawLineAni = CABasicAnimation.init(keyPath: "strokeEnd")
        drawLineAni.fromValue = 0
        drawLineAni.toValue = 1
        drawLineAni.duration = 3
        shapeLayer.add(drawLineAni, forKey: "drawLineAnimation")
        return shapeLayer
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


