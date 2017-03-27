//
//  VideoViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/24.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import IJKMediaFramework
import SnapKit

class VideoViewController: UIViewController {
    var  ijkPlayVC:IJKFFMoviePlayerController!
    var stream_addr:String?  //视频地址
    var portrait:String?  //背景图
        {
        didSet{
            let url = URL.init(string: portrait!)
            viewBgImg.sd_setImage(with: url)
        }
    }
    private lazy var backBtn:UIButton  = {
        var backBtn = UIButton.init(frame: CGRect.zero)
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.addTarget(self, action: #selector(VideoViewController.backAction), for: .touchUpInside)
        return backBtn
    }()
    private lazy var heartBtn:UIButton  = {
        var heartBtn = UIButton.init(frame: CGRect.zero)
        heartBtn.setTitleColor(UIColor.white, for: .normal)
        heartBtn.setImage(#imageLiteral(resourceName: "点赞"), for: .normal)
        heartBtn.addTarget(self, action: #selector(VideoViewController.heartAction), for: .touchUpInside)
        return heartBtn
    }()
    private lazy var giftBtn:UIButton  = {
        var giftBtn = UIButton.init(frame: CGRect.zero)
        giftBtn.setTitleColor(UIColor.white, for: .normal)
        giftBtn.setImage(#imageLiteral(resourceName: "gift"), for: .normal)
        giftBtn.addTarget(self, action: #selector(VideoViewController.giftAction), for: .touchUpInside)
        return giftBtn
    }()
    //虚化
    private lazy var viewBgImg:UIImageView = UIImageView()
    private lazy var viewBg:UIVisualEffectView = {
        let blurEffect = UIBlurEffect.init(style: .light)
        let effetView = UIVisualEffectView.init(effect: blurEffect)
        effetView.frame = UIScreen.main.bounds
        return effetView
    }()
    
    //点击返回按钮事件
    func backAction (){
        self.dismiss(animated: true, completion: nil)
    }
    // 点击爱心事件
    func heartAction (btn:UIButton) {
        let heart = DMHeartFlyView.init(frame: CGRect.init(x: 0, y: 0, width: 48, height: 48))
        heart.center = CGPoint.init(x: heartBtn.frame.origin.x, y:  heartBtn.frame.origin.y)
        view.insertSubview(heart, aboveSubview: ijkPlayVC.view)
        heart.animate(in: view)
        
        //按钮大小动画
        let btnAnime = CAKeyframeAnimation.init(keyPath: "transform.scale")
        btnAnime.values =       [1.0, 0.7, 0.5, 0.3, 0.5, 0.7, 1.0, 1.2, 1.4, 1.2, 1.0]
        btnAnime.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 ]
        btnAnime.duration = 0.2
        btn.layer.add(btnAnime, forKey: "SHOW")

    }
    //点击礼物事件
    func giftAction(btn:UIButton) {
        //跑车动画
        let duration = 3.0
        let carWidth:CGFloat = 250
        let carHeight:CGFloat = 125
        let car  = UIImageView.init(image: #imageLiteral(resourceName: "porsche"))
        car.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
        view.insertSubview(car, aboveSubview: ijkPlayVC.view)
        
        UIView.animate(withDuration: duration, animations: { 
            car.frame = CGRect.init(x: self.view.center.x - carWidth/2, y: self.view.center.y - carHeight/2, width: carWidth, height: carHeight)
        }) { (true) in
            car.removeFromSuperview()
        }
       //烟花特效
        let layerFw = CAEmitterLayer()
        view.layer.addSublayer(layerFw)
        emmitParticles(from: btn.center, emitter: layerFw, in: view)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            layerFw.removeFromSuperlayer()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        addCons()
      }
    //添加视图
    func addSubView(){
        //背景虚化
        viewBgImg.addSubview(viewBg)
        self.view.addSubview(viewBgImg)
        //播放
        let url = URL.init(string: stream_addr!)
        ijkPlayVC = IJKFFMoviePlayerController.init(contentURL: url, with: nil)
        ijkPlayVC.view.frame = UIScreen.main.bounds
        self.view.addSubview(ijkPlayVC.view)
        ijkPlayVC.prepareToPlay()
        
         //返回按钮
        view.insertSubview(backBtn, aboveSubview: ijkPlayVC.view)
        view.insertSubview(heartBtn, aboveSubview: ijkPlayVC.view)
        view.insertSubview(giftBtn, aboveSubview: ijkPlayVC.view)

    }
    //点击控件约束
    func  addCons() {
        backBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.topMargin.equalTo(self.view.snp.top).offset(20)
            make.leading.equalTo(5)
        }
        giftBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.leading.equalTo(20)
            make.topMargin.equalTo(self.view.snp.bottom).offset(-50)
        }
        heartBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.trailing.equalTo(-20)
            make.topMargin.equalTo(self.view.snp.bottom).offset(-50)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        /* 释放 */
        if	ijkPlayVC != nil {
            ijkPlayVC.pause()
            ijkPlayVC.stop()
            ijkPlayVC.shutdown()
        }
    }
    
}
