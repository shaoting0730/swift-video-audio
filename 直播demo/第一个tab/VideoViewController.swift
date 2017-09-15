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
import SDWebImage

class VideoViewController: UIViewController {
    var  ijkPlayVC:IJKFFMoviePlayerController!
    var stream_addr:String!  //视频地址
    var viewBgImg:UIImageView!
    var bullteManager:BulletManager!
    var portrait:String?  //背景图
    {
        didSet{
            let url = URL.init(string: portrait!)
            viewBgImg?.sd_setImage(with: url)
        }
    }
    fileprivate lazy var backBtn:UIButton  = {
        var backBtn = UIButton.init(frame: CGRect.zero)
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.addTarget(self, action: #selector(VideoViewController.backAction), for: .touchUpInside)
        return backBtn
    }()
    fileprivate lazy var heartBtn:UIButton  = {
        var heartBtn = UIButton.init(frame: CGRect.zero)
        heartBtn.setTitleColor(UIColor.white, for: .normal)
        heartBtn.setImage(#imageLiteral(resourceName: "点赞"), for: .normal)
        heartBtn.addTarget(self, action: #selector(VideoViewController.heartAction), for: .touchUpInside)
        return heartBtn
    }()
    fileprivate lazy var giftBtn:UIButton  = {
        var giftBtn = UIButton.init(frame: CGRect.zero)
        giftBtn.setTitleColor(UIColor.white, for: .normal)
        giftBtn.setImage(#imageLiteral(resourceName: "gift"), for: .normal)
        giftBtn.addTarget(self, action: #selector(VideoViewController.giftAction), for: .touchUpInside)
        return giftBtn
    }()
    fileprivate lazy var enangeDanmu:UIButton  = {
        var giftBtn = UIButton.init(frame: CGRect.zero)
        giftBtn.setTitleColor(UIColor.white, for: .normal)
        giftBtn.setImage(#imageLiteral(resourceName: "NO"), for: .normal)
        giftBtn.addTarget(self, action: #selector(VideoViewController.enangeDanmuAction), for: .touchUpInside)
        
        return giftBtn
    }()
    fileprivate lazy var sendBullet:UITextField  = {
        var sendBullet = UITextField.init(frame: CGRect.zero)
        sendBullet.placeholder = "  弹幕攻击 "
        sendBullet.setValue(UIFont.systemFont(ofSize: 20), forKeyPath: "_placeholderLabel.font")
        sendBullet.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        sendBullet.layer.masksToBounds = true
        sendBullet.layer.borderWidth = 1.0
        sendBullet.layer.borderColor = UIColor.white.cgColor
        sendBullet.layer.cornerRadius = 20
        sendBullet.delegate = self
        return sendBullet
    }()
    fileprivate lazy var sendGift:UIButton  = {
        var backBtn = UIButton.init(frame: CGRect.zero)
        backBtn.setTitle("刷礼物", for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.addTarget(self, action: #selector(VideoViewController.sendGiftAction), for: .touchUpInside)
        backBtn.layer.masksToBounds = true
        backBtn.layer.borderWidth = 1.0
        backBtn.layer.cornerRadius = 15
        backBtn.layer.borderColor = UIColor.white.cgColor
        return backBtn
    }()
    //礼物
    let gitViewVC = giftViewController.init()
    
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
    
    
    
    //发送礼物
    func sendGiftAction(){
        let size = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.8) {
            self.gitViewVC.giftView.frame = CGRect.init(x: 0, y: size.height - 240, width: size.width, height: 240)
            self.gitViewVC.sendGiftBtn.frame = CGRect.init(x: 0, y: size.height - 280, width: size.width, height: 40)
        }
        
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
        addChildViewController(gitViewVC)
        self.view.addSubview(gitViewVC.giftView)
        self.view.addSubview(gitViewVC.sendGiftBtn)

        
        
        bullteManager = BulletManager.init()
        weak var weakSelf = self
        bullteManager.generateViewBlock = {(view: BulletView!) -> Void in
            weakSelf?.addBulletView(view)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: Notification.Name.UIKeyboardDidHide, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.giftAnimation), name: NSNotification.Name(rawValue: "didSelected"), object: nil);
        
        
        
        //        添加自定义按钮
        addCustomKeyboard()
    }
    //MARK: 礼物动画
    func giftAnimation(noti:Notification){
      let str = noti.object!  //选中第几个item
        let size = UIScreen.main.bounds.size

      let gview = UIView.init(frame: CGRect.init(x: 0, y: size.height/2 - 50, width: 150, height: 40))
      gview.backgroundColor = UIColor.init(r: 124, g: 252, b: 0, alpha: 0.8)
      gview.layer.masksToBounds = true
      gview.layer.cornerRadius = 10
      self.view.addSubview(gview)

      let label = UILabel.init(frame: CGRect.init(x: 5, y: 0, width: 100, height: 40))
      label.text = "赠送一个 🎁"
      label.textColor = UIColor.white
      gview.addSubview(label)
       
      let imgView = UIImageView.init(frame: CGRect.init(x: 110, y: -10, width: 50, height: 50))
        let imgName = "gif" + String(describing: str)
        let path = Bundle.main.path(forResource: imgName, ofType: ".gif")
        let data = NSData.init(contentsOfFile: path!)
        imgView.image = UIImage.sd_animatedGIF(with: data! as Data)
      gview.addSubview(imgView)
        
      UIView.animate(withDuration: 1.5, animations: {
        gview.frame = CGRect.init(x: 0, y: size.height/2 - 100, width: 150, height: 40)
        gview.alpha = 0.0
      }) { (true) in
        label.removeFromSuperview()
        imgView.removeFromSuperview()
        gview.removeFromSuperview()
      }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let size = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.8) {
            self.gitViewVC.giftView.frame = CGRect.init(x: 0, y: size.height, width: size.width, height: 240)
            self.gitViewVC.sendGiftBtn.frame = CGRect.init(x: 0, y: size.height, width: size.width, height: 40)
        }
        self.sendBullet.resignFirstResponder()
        bullteManager.stop()
        enangeDanmu.setImage(#imageLiteral(resourceName: "NO"), for: .normal)
        
    }
    //打开/关闭弹幕
    func enangeDanmuAction(btn:UIButton){
        if(enangeDanmu.currentImage == #imageLiteral(resourceName: "NO")){
            enangeDanmu.setImage(#imageLiteral(resourceName: "OK"), for: .normal)
            bullteManager.start()
        }else{
            enangeDanmu.setImage(#imageLiteral(resourceName: "NO"), for: .normal)
            bullteManager.stop()
        }
    }
    //添加视图
    func addSubView(){
        //背景虚化
        viewBgImg = UIImageView.init(frame: UIScreen.main.bounds)
        let blurEffect = UIBlurEffect.init(style: .light)
        let effetView = UIVisualEffectView.init(effect: blurEffect)
        effetView.frame = UIScreen.main.bounds
        viewBgImg.addSubview(effetView)
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
        view.insertSubview(sendGift, aboveSubview: ijkPlayVC.view)
        view.insertSubview(sendBullet, aboveSubview: ijkPlayVC.view)
        view.insertSubview(enangeDanmu, aboveSubview: ijkPlayVC.view)

        
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
        enangeDanmu.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.rightMargin.equalTo(self.heartBtn.snp.left).offset(-15)
            make.topMargin.equalTo(self.view.snp.bottom).offset(-50)
        }
        sendBullet.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.rightMargin.equalTo(self.enangeDanmu.snp.left).offset(-15)
            make.topMargin.equalTo(self.view.snp.bottom).offset(-50)
        }
        sendGift.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.rightMargin.equalTo(self.sendBullet.snp.left).offset(-20)
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
    
    deinit {
        NotificationCenter.default.removeObserver("didSelected")
    }
    
}
extension VideoViewController:UITextFieldDelegate{
    //MARK: 添加自定义按钮
    func addCustomKeyboard(){
        let doneToolbar = UIToolbar.init()
        //左侧的空隙
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //        右侧的完成按钮
        let done: UIBarButtonItem = UIBarButtonItem.init(title: "弹幕攻击!", style: .done, target: self, action: #selector(self.addDanmuAction))
        
        var items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.sendBullet.inputAccessoryView = doneToolbar
        
    }
    
    
    //    MARK:键盘显示
    func keyboardWillShow(_ note : NSNotification)-> Void{
        bullteManager.start()
    }
    //    MARK:键盘隐藏
    func keyboardWillHide(_ note : NSNotification)-> Void{
        sendBullet.text = "";
        
    }
    //增加弹幕
    func addDanmuAction() {
        let dic: [AnyHashable: Any] = ["userPhoto": "https://ws1.sinaimg.cn/large/610dc034ly1fiz4ar9pq8j20u010xtbk.jpg", "danmu": sendBullet.text ?? "~~~"]
        bullteManager.createBulletView(dic, trajectory: 0)
    }
    //添加弹幕视图
    func addBulletView(_ view: BulletView) {
        let width: CGFloat = UIScreen.main.bounds.size.width
        view.frame = CGRect(x: width, y: CGFloat(300 + view.trajectory * 60), width: view.bounds.width, height: view.bounds.height)
        self.view.addSubview(view)
        view.startAnimation()
    }
    
    
    
}
