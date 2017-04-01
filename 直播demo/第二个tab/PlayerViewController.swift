//
//  PlayerViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/21.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import SnapKit
import IJKMediaFramework

class PlayerViewController: UIViewController {
    var isPlaying:Bool = false   //是否播放标示
    var  ijkPlayVC:IJKFFMoviePlayerController!
    var twoModel = [TwoModel]()
    var smallLogo:String!  //小图
    var coverLarge:String!  //大图
    var playUrl32:String! //歌曲链接
    var currentIndex:Int = 0   //上一个控制器点击第几行(数组下标)
    let audioVC = FSAudioStream.init()  //音乐播放器
    var pauseTag = false  //暂停tag

    //虚化
    private lazy var viewBgImg:UIImageView = {
        let  imgView = UIImageView.init(frame: UIScreen.main.bounds)
        return imgView
    }()
    private lazy var viewBg:UIVisualEffectView = {
        let blurEffect = UIBlurEffect.init(style: .light)
        let effetView = UIVisualEffectView.init(effect: blurEffect)
        effetView.frame = UIScreen.main.bounds
        return effetView
    }()
    private lazy var needle:UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.zero)
        imgView.layer.anchorPoint = CGPoint.init(x: 0.25, y: 0.16)
        imgView.image = #imageLiteral(resourceName: "CD_needle")
        return imgView
    }()
    private lazy var song_bg:UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.zero)
        imgView.image = #imageLiteral(resourceName: "song_bg")
        return imgView
    }()
    private lazy var prevBtn:UIButton = {
        let btn = UIButton.init(frame: CGRect.zero)
        btn.setImage(#imageLiteral(resourceName: "prev"), for: .normal)
        btn.tag = -1
        btn.addTarget(self, action: #selector(PlayerViewController.prevAction), for: .touchUpInside)
        return btn
    }()
    private lazy var playBtn:UIButton = {
        let btn = UIButton.init(frame: CGRect.zero)
        btn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        btn.addTarget(self, action: #selector(PlayerViewController.playAction), for: .touchUpInside)
        return btn
    }()
    private lazy var nextBtn:UIButton = {
        let btn = UIButton.init(frame: CGRect.zero)
        btn.setImage(#imageLiteral(resourceName: "next"), for: .normal)
        btn.addTarget(self, action: #selector(PlayerViewController.nextAction), for: .touchUpInside)
        return btn
    }()
    private lazy var bottomView:UIView = {
        let view = UIView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    private lazy var singerImg:UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.zero)
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 155/2
        return imgView
    }()
    //上一曲事件
    func prevAction(){
        if(currentIndex == 0){
            currentIndex = twoModel.count //如果是第一首歌曲,改为最后一首
        }
        let smallLogoNext = twoModel[currentIndex - 1].smallLogo
        singerImg.sd_setImage(with: URL.init(string: smallLogoNext!))
        
        let coverLargeNextr = twoModel[currentIndex -  1].coverLarge
        viewBgImg.sd_setImage(with: URL.init(string: coverLargeNextr!))
        
        if(isPlaying == true){
            audioVC.play(from: URL.init(string: twoModel[currentIndex -  1].playUrl32!))
        }
        currentIndex -= 1
        self.view.setNeedsDisplay()
        
    }
    //播放按钮点击事件
    func playAction(btn:UIButton){
        self.rotatesinger()
        
        if(isPlaying == false){
            self.playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            rotateNeedle(isPlaying: true)
            audioVC.play(from: URL.init(string:  playUrl32))
             isPlaying = true
        }else{
            self.playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            rotateNeedle(isPlaying: false)
            audioVC.stop()
            pauseTag = false
            isPlaying = false
        }
    }
    //图片旋转动画
    func rotatesinger(){
        let singerAnim = singerImg.layer.animation(forKey: "transform.rotation")
        if (singerAnim != nil) {
            if(singerImg.layer.speed == 0){
                self.resumeAnimation()
            }else{
                self.pauseAnimation()  //暂停动画
            }
        }else{
               self.rotationAnimation()
        }
    }
    //图片旋转动画
    func rotationAnimation(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")   //图片旋转动画
        anim.toValue = 2.0 * Double.pi
        anim.duration = 5
        anim.repeatCount = MAXFLOAT
        anim.isCumulative = true
        self.singerImg.layer.add(anim, forKey: "transform.rotation")
    }
    //图片暂停动画
    func pauseAnimation() {
        //1.取出当前时间,转成动画暂停的时间
        let pauseTime = singerImg.layer.convertTime(CACurrentMediaTime(), from: nil)
        //2.设置动画时间的偏移量,让动画定格在该时间点的位置上
        singerImg.layer.timeOffset = pauseTime
        //3.将动画的运行速度设置为0,默认速度为1.0
        singerImg.layer.speed = 0
    }
    //图片恢复旋转动画
    func resumeAnimation(){
          //1.将动画的时间偏移量作为暂停的时间点
        let pauseTime = singerImg.layer.timeOffset;
        //2.计算出开始时间
        let begin = CACurrentMediaTime() - pauseTime
        singerImg.layer.timeOffset = 0
        singerImg.layer.beginTime = begin
        singerImg.layer.speed = 1
    }
    
    
    //下一曲
    func nextAction(){

        if(currentIndex == twoModel.count - 1 ){
            currentIndex = -1     //如果是最后一首歌曲,就从头开始
        }
        
        let smallLogoNext = twoModel[currentIndex + 1].smallLogo
        singerImg.sd_setImage(with: URL.init(string: smallLogoNext!))
        
        let coverLargeNextr = twoModel[currentIndex +  1].coverLarge
        viewBgImg.sd_setImage(with: URL.init(string: coverLargeNextr!))

        playUrl32 = twoModel[currentIndex +  1].playUrl32!
        if(isPlaying == true){
            audioVC.play(from: URL.init(string: playUrl32))
        }
        
        currentIndex +=  1
        self.view.setNeedsDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置图片
        singerImg.sd_setImage(with: URL.init(string: smallLogo))
        viewBgImg.sd_setImage(with: URL.init(string: coverLarge))
        addSubView()
        addCons()
        //进入前先让唱针置于未播放
        UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
            self.needle.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/6))
        }, completion: nil)
        //请求数据
        TwoModel.loadData { (data) in
            self.twoModel = data
        }
        //播放
        
        
    }
    // 唱针动画
    func rotateNeedle(isPlaying : Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            if !isPlaying {
                self.needle.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/6))
            } else {
                self.needle.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/6))
            }
        }, completion: nil)
    }
    
    func addSubView(){
        //背景虚化
        viewBgImg.addSubview(viewBg)
        view.addSubview(viewBgImg)
        //加载控件
        view.addSubview(song_bg)
        view.addSubview(needle)
        view.addSubview(bottomView)
        view.addSubview(prevBtn)
        view.addSubview(playBtn)
        view.addSubview(nextBtn)
        view.addSubview(singerImg)
    }
    //空间布局约束
    func addCons(){
        needle.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(170)
            make.centerX.equalTo(view.center.x)
            make.topMargin.equalTo(-5)
        }
        song_bg.snp.makeConstraints { (make) in
            make.width.height.equalTo(250)
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y  - 50)
        }
        bottomView.snp.makeConstraints { (make) in
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(50)
            make.bottomMargin.equalTo(self.view.snp.bottom)
        }
        let noSoundC =  self.view.center.x/2
        prevBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.bottomMargin.equalTo(self.view.snp.bottom).offset(-10)
            make.centerX.equalTo(noSoundC)
        }
        playBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.bottomMargin.equalTo(self.view.snp.bottom).offset(-10)
            make.centerX.equalTo(view.snp.centerX)
        }
        let nextBtnC = self.view.center.x * 3/2
        nextBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.bottomMargin.equalTo(self.view.snp.bottom).offset(-10)
            make.centerX.equalTo(nextBtnC)
        }
        singerImg.snp.makeConstraints { (make) in
            make.width.height.equalTo(155)
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y  - 50)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
