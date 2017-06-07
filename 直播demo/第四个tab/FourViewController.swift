//
//  FourViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/5.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {
  let SCREENW =  UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn1  = UIButton.init(frame: CGRect.init(x: 0, y: 74, width: SCREENW * 0.5 - 5, height: 50))
        btn1.setTitle("按钮扩展", for: .normal)
        btn1.setTitleColor(UIColor.red, for: .normal)
        btn1.addTarget(self, action: #selector(FourViewController.btnExtensionAction), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        let btn2  = UIButton.init(frame: CGRect.init(x: SCREENW * 0.5, y: 74, width: SCREENW * 0.5 - 5, height: 50))
        btn2.setTitle("时间轴", for: .normal)
        btn2.setTitleColor(UIColor.red, for: .normal)
        btn2.addTarget(self, action: #selector(FourViewController.timeLineAction), for: .touchUpInside)
        self.view.addSubview(btn2)
        
    }

    func btnExtensionAction(){
        self.navigationController?.pushViewController(BtnViewController(), animated: false)
    }
    
    func timeLineAction(){
         self.navigationController?.pushViewController(TimeLineViewController(), animated: false)
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
