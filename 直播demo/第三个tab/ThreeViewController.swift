//
//  ThreeViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/5.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {
    let SCREENW =  UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn1  = UIButton.init(frame: CGRect.init(x: 0, y: 74, width: SCREENW * 0.5 - 5, height: 50))
        btn1.setTitle("tableView联动", for: .normal)
        btn1.setTitleColor(UIColor.red, for: .normal)
        btn1.addTarget(self, action: #selector(ThreeViewController.tableAction), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        let btn2  = UIButton.init(frame: CGRect.init(x: SCREENW * 0.5, y: 74, width: SCREENW * 0.5 - 5, height: 50))
        btn2.setTitle("collectionView联动", for: .normal)
        btn2.setTitleColor(UIColor.red, for: .normal)
        btn2.addTarget(self, action: #selector(ThreeViewController.collectionAction), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let btn3  = UIButton.init(frame: CGRect.init(x: 0, y: 74 + 60, width: SCREENW * 0.5 - 5, height: 50))
        btn3.setTitle("按钮扩展", for: .normal)
        btn3.setTitleColor(UIColor.red, for: .normal)
        btn3.addTarget(self, action: #selector(ThreeViewController.btnExtensionAction), for: .touchUpInside)
        self.view.addSubview(btn3)
        
        let btn4  = UIButton.init(frame: CGRect.init(x: SCREENW * 0.5, y: 74 + 60, width: SCREENW * 0.5 - 5, height: 50))
        btn4.setTitle("时间轴", for: .normal)
        btn4.setTitleColor(UIColor.red, for: .normal)
        btn4.addTarget(self, action: #selector(ThreeViewController.timeLineAction), for: .touchUpInside)
        self.view.addSubview(btn4)
        
        let btn5  = UIButton.init(frame: CGRect.init(x: 0, y: 74 + 60 + 60, width: SCREENW * 0.5 - 5, height: 50))
        btn5.setTitle("下拉放大+导航栏渐变", for: .normal)
        btn5.setTitleColor(UIColor.red, for: .normal)
        btn5.addTarget(self, action: #selector(ThreeViewController.navigationAction), for: .touchUpInside)
        self.view.addSubview(btn5)
        
        let btn6  = UIButton.init(frame: CGRect.init(x: SCREENW * 0.5, y: 74 + 60 + 60, width: SCREENW * 0.5 - 5, height: 50))
        btn6.setTitle("分页控制器", for: .normal)
        btn6.setTitleColor(UIColor.red, for: .normal)
        btn6.addTarget(self, action: #selector(ThreeViewController.pageViewControllerAction), for: .touchUpInside)
        self.view.addSubview(btn6)
        
        let btn7  = UIButton.init(frame: CGRect.init(x: 0, y: 74 + 60 + 60 + 60, width: SCREENW * 0.5 - 5, height: 50))
        btn7.setTitle("刮刮卡", for: .normal)
        btn7.setTitleColor(UIColor.red, for: .normal)
        btn7.addTarget(self, action: #selector(ThreeViewController.guaguakaControllerAction), for: .touchUpInside)
        self.view.addSubview(btn7)
        
        let btn8  = UIButton.init(frame: CGRect.init(x: SCREENW * 0.5, y: 74 + 60 + 60 + 60, width: SCREENW * 0.5 - 5, height: 50))
        btn8.setTitle("检测人脸并打码", for: .normal)
        btn8.setTitleColor(UIColor.red, for: .normal)
        btn8.addTarget(self, action: #selector(ThreeViewController.PixFaceAction), for: .touchUpInside)
        self.view.addSubview(btn8)
        
        let btn9  = UIButton.init(frame: CGRect.init(x: 0, y: 74 + 60 + 60 + 60 + 60, width: SCREENW * 0.5 - 5, height: 50))
        btn9.setTitle("数字键盘", for: .normal)
        btn9.setTitleColor(UIColor.red, for: .normal)
        btn9.addTarget(self, action: #selector(ThreeViewController.numberKeyboardAction), for: .touchUpInside)
        self.view.addSubview(btn9)
        
        let btn10  = UIButton.init(frame: CGRect.init(x: SCREENW * 0.5, y: 74 + 60 + 60 + 60 + 60, width: SCREENW * 0.5 - 5, height: 50))
        btn10.setTitle("iOS10.3后修改icon", for: .normal)
        btn10.setTitleColor(UIColor.red, for: .normal)
        btn10.addTarget(self, action: #selector(ThreeViewController.changeIcon), for: .touchUpInside)
        self.view.addSubview(btn10)

    }
    
    func tableAction(){
       self.navigationController?.pushViewController(TableViewController(), animated: true)
    }
    
    func collectionAction(){
       self.navigationController?.pushViewController(CollectionViewController(), animated: true)
    }
    
    func btnExtensionAction(){
        self.navigationController?.pushViewController(BtnViewController(), animated: false)
    }
    
    func timeLineAction(){
        self.navigationController?.pushViewController(TimeLineViewController(), animated: false)
    }
    
    func navigationAction(){
        self.navigationController?.pushViewController(NavigationAndDownViewController(), animated: false)
    }
    
    func pageViewControllerAction(){
         self.navigationController?.pushViewController(PageViewController(), animated: false)
    }
    
    func guaguakaControllerAction(){
        self.navigationController?.pushViewController(GuaGuaKaViewController(), animated: false)
    }
    
    func PixFaceAction(){
       self.navigationController?.pushViewController(PixFaceViewController(), animated: false)
    }
    
    func numberKeyboardAction(){
        self.navigationController?.pushViewController(NumberpadViewController(), animated: false)
    }
    
    func changeIcon(){
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                print("you can change this app's icon")
            }else {
                print("you cannot change this app's icon")
                return
            }
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 10.3, *) {
            if let name = UIApplication.shared.alternateIconName {
                // CHANGE TO PRIMARY ICON
                UIApplication.shared.setAlternateIconName(nil) { (err:Error?) in
                    print("set icon error：\(String(describing: err))")
                }
                print("the alternate icon's name is \(name)")
            }else {
                // CHANGE TO ALTERNATE ICON
                UIApplication.shared.setAlternateIconName("otherIcon") { (err:Error?) in
                    print("set icon error：\(String(describing: err))")
                }
            }
        } else {
            // Fallback on earlier versions
        }
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
