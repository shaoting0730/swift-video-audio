//
//  BtnViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/7.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class BtnViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn1 = UIButton.init(frame: CGRect.init(x: 50, y: 100, width: 200, height: 100))
        self.view.addSubview(btn1)
        let btn2 = UIButton.init(frame: CGRect.init(x: 50, y: 200, width: 200, height: 100))
        self.view.addSubview(btn2)
        let btn3 = UIButton.init(frame: CGRect.init(x: 50, y: 300, width: 200, height: 100))
        self.view.addSubview(btn3)
        let btn4 = UIButton.init(frame: CGRect.init(x: 50, y: 400, width: 200, height: 100))
        self.view.addSubview(btn4)
        
        btn1.setImageAndTitle(imageName: "gift", title: "我是按钮", type: .PositionTop, Space: 0.0)
        btn2.setImageAndTitle(imageName: "gift", title: "我是按钮", type: .PositionBottom, Space: 0.0)
        btn3.setImageAndTitle(imageName: "gift", title: "我是按钮", type: .Positionleft, Space: 0.0)
        btn4.setImageAndTitle(imageName: "gift", title: "我是按钮", type: .PositionRight, Space: 0.0)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
