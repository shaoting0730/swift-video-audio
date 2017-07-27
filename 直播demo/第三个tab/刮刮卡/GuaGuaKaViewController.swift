//
//  GuaGuaKaViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/7/27.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class GuaGuaKaViewController: UIViewController, ScratchCardDelegate {
    var label:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建刮刮卡组件
        let scratchCard = ScratchCard(frame: CGRect(x:20, y:70, width:241, height:106),
                                      couponImage: UIImage(named: "coupon.png")!,
                                      maskImage: UIImage(named: "mask.png")!)
        //设置代理
        scratchCard.delegate = self
        self.view.addSubview(scratchCard)
        
        
        //创建label
        label = UILabel.init(frame: CGRect.init(x: 16, y: 209, width: 187, height: 21))
        self.view.addSubview(label)
        
    }
    
    //滑动开始
    func scratchBegan(point: CGPoint) {
        print("开始刮奖：\(point)")
    }
    
    //滑动过程
    func scratchMoved(progress: Float) {
        print("当前进度：\(progress)")
        
        //显示百分比
        let percent = String(format: "%.1f", progress * 100)
        label.text = "刮开了：\(percent)%"
    }
    
    //滑动结束
    func scratchEnded(point: CGPoint) {
        print("停止刮奖：\(point)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
