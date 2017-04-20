//
//  PlayerViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/21.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
private let UITableViewCellIdentifier = "UITableViewCellIdentifier"
class PlayerViewController: UIViewController {
    var audioPlaying:Bool = true   //是否播放标示 默认播放
    var twoModel = [TwoModel]()
    var song_id:String!   //歌曲id
    var songidAry:[String]!  //songid数组
    var currentIndex:Int = 0   //上一个控制器点击第几行(数组下标)
    var player:AVPlayer = AVPlayer.init()
    var isplayer:Bool = true //播放状态 默认播放
    var songlryAry:[[String:Any]] =  [[String:Any]]() //歌词数组
    var file_duration:Int = 0 //歌曲总长度
    var songIryDic:[String:Any] = ["lry" : " " , "total" : 0]  //单句歌词字典   时间:XX  歌词:XX
    var y = 40

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
        btn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
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
    
    private lazy var songlryTab:UITableView = {
        let songlryTab = UITableView.init(frame: CGRect.zero)
        songlryTab.delegate = self
        songlryTab.dataSource = self
        songlryTab.backgroundColor = UIColor.clear
        songlryTab.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCellIdentifier)
        return songlryTab
    }()
    
    //上一曲事件
    func prevAction(){
        if(currentIndex == 0 ){
            currentIndex = songidAry.count //如果是第一首歌曲,改为最后一首
        }
        currentIndex -= 1
        song_id = songidAry[currentIndex]
        loadSonginfo()
        loadSonglry()
        self.view.setNeedsDisplay()
    }
    //播放按钮点击事件
    func playAction(btn:UIButton){
        self.rotatesinger()  //图片旋转
        if(isplayer == false){
            isplayer = true
            playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            player.play()
        }else{
            isplayer = false
            playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            player.pause()
        }
        
    }
    //图片旋转动画
    func rotatesinger(){
        let singerAnim = singerImg.layer.animation(forKey: "transform.rotation")
        if (singerAnim != nil) {
            if(singerImg.layer.speed == 0){
                self.resumeAnimation()  //恢复动画
                self.needleWorking() //唱针工作
            }else{
                self.pauseAnimation()  //暂停动画
                self.needleWorked()   //唱针不工作
            }
        }else{
            self.rotationAnimation()  //开始动画
            self.needleWorking() //唱针工作
        }
    }
    //图片开始旋转动画
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
    //唱针工作
    func needleWorking(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.needle.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/6))
        }, completion: nil)
    }
    //唱针不工作
    func needleWorked(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.needle.transform = CGAffineTransform(rotationAngle:  -CGFloat(Double.pi/6))
        }, completion: nil)
    }
    
    
    //下一曲
    func nextAction(){
        if(currentIndex == songidAry.count - 1 ){
            currentIndex = -1     //如果是最后一首歌曲,就从头开始
        }
        currentIndex += 1
        song_id = songidAry[currentIndex]
        loadSonginfo()
        loadSonglry()
        self.view.setNeedsDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //加载歌曲信息
    func loadSonginfo(){
        let url = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.play&songid=" + song_id
        NetWorkManager.post(url: url) { (data) in
            var  songinfoDic = data as [String : AnyObject]  //歌曲信息字典
            var songinfo:[String:AnyObject] = songinfoDic["songinfo"] as! [String : AnyObject]
            var bitrate:[String:AnyObject] = songinfoDic["bitrate"] as! [String:AnyObject]
            self.singerImg.sd_setImage(with: URL.init(string: songinfo["pic_small"] as! String))
            self.viewBgImg.sd_setImage(with: URL.init(string: songinfo["pic_big"] as! String))
            self.player = AVPlayer.init(url: URL.init(string: bitrate["file_link"] as! String)!)
            self.file_duration = bitrate["file_duration"] as! Int
            self.player.play()
//            let time = self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1.0), Int32(1.0)), queue: DispatchQueue.main, using: { (time) in
//                let current = CMTimeGetSeconds(time)
//                let currentD = current as! Double
//                for  dic in self.songlryAry{
//                    let total = dic["total"] as! Double
//                    if(currentD >= total){
//                        print("歌词该动额")
//                        }
//                }
//            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //加载歌词文件
    func loadSonglry(){
        //先清除数组和字典
        songlryAry.removeAll()
        
        let url = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.lry&songid=" + song_id
        NetWorkManager.post(url: url) { (data) in
            var  songinfoDic = data as [String : AnyObject]  //歌曲信息字典
            let lrcContent = songinfoDic["lrcContent"] as! String  //歌词
            self.dealWithSonglry(lrcContent: lrcContent)
        }
    }
    
    //处理歌词
    func dealWithSonglry(lrcContent:String){
        let lryAry:[String] =  lrcContent.components(separatedBy: "\n")
        
        for lry in lryAry {
            //歌词处理 部分情况尚未考虑到
            if(lry.characters.count > 1){
                let strStart = (lry as NSString).substring(with: NSRange.init(location: 1, length: 1)) //先获取到第二个元素
                if(Int(strStart) != nil){  //判断是否是数字字符
                    let min = Double( (lry as NSString).substring(with: NSMakeRange(1, 2)))
                    let sec  = Double(  (lry as NSString).substring(with: NSMakeRange(4, 2)))
                    let ms =  Double(  (lry as NSString).substring(with: NSMakeRange(7, 2)))
                    let total = min! * 60 + sec! + ms! * 0.01  //秒数
                    let length = lry.characters.count   // 总长
                    let songlry = (lry as NSString).substring(with: NSMakeRange(10, length - 10))
                    songIryDic.updateValue(total, forKey: "total");   //更新字典
                    songIryDic.updateValue(songlry, forKey: "lry");
                    songlryAry.append(songIryDic)  //添加数组
                }
                songlryTab.reloadData()   //刷新tableView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        addCons()
        rotatesinger()
        
        loadSonginfo()
        loadSonglry()
        
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
        view.addSubview(songlryTab)
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
        songlryTab.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.bounds.width)
            make.bottomMargin.equalTo(self.view.snp.bottom).offset(-49)
            make.topMargin.equalTo(song_bg.snp.bottom).offset(5)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


extension PlayerViewController:UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return songlryAry.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.clear
        let lryDic =  songlryAry[indexPath.row]
        cell.textLabel?.text = lryDic["lry"]! as? String
        return cell;
    }
}

