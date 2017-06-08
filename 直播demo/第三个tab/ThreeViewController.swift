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
        btn5.setTitle("导航栏渐变+下拉放大", for: .normal)
        btn5.setTitleColor(UIColor.red, for: .normal)
        btn5.addTarget(self, action: #selector(ThreeViewController.navigationAction), for: .touchUpInside)
        self.view.addSubview(btn5)

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
//        self.navigationController?.pushViewController(NavigationAndDownViewController(), animated: false)
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
