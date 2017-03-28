//
//  PlayerViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/21.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import SnapKit

class PlayerViewController: UIViewController {
    
    private lazy var needle:UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.zero)
        imgView.image = #imageLiteral(resourceName: "CD_needle")
        return imgView
    }()
    private lazy var song_bg:UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.zero)
        imgView.image = #imageLiteral(resourceName: "song_bg")
        return imgView
    }()
    private lazy var noSoundBtn:UIButton = {
        let btn = UIButton.init(frame: CGRect.zero)
        btn.setImage(#imageLiteral(resourceName: "noSound"), for: .normal)
        btn.addTarget(self, action: #selector(PlayerViewController.noSound), for: .touchUpInside)
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
        imgView.image  = #imageLiteral(resourceName: "green")
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 155/2
        return imgView
    }()
    
    func noSound(){
        print(#function)
    }
    
    func playAction(){
        print(#function)
    }
    
    func nextAction(){
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        addCons()
    }
    func addSubView(){
        view.addSubview(song_bg)
        view.addSubview(needle)
        view.addSubview(bottomView)
        view.addSubview(noSoundBtn)
        view.addSubview(playBtn)
        view.addSubview(nextBtn)
        view.addSubview(singerImg)
    }
    func addCons(){
         needle.snp.makeConstraints { (make) in
                make.width.equalTo(80)
                make.height.equalTo(180)
                make.centerX.equalTo(view.center.x)
                make.topMargin.equalTo(35)
          }
        song_bg.snp.makeConstraints { (make) in
            make.width.height.equalTo(250)
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y  - 50)
        }
        bottomView.snp.makeConstraints { (make) in
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(50)
            make.bottomMargin.equalTo(self.view.snp.bottom).offset(-50)
        }
        let noSoundC =  self.view.center.x/2
        noSoundBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.bottomMargin.equalTo(self.view.snp.bottom).offset(-60)
            make.centerX.equalTo(noSoundC)
        }
        playBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.bottomMargin.equalTo(self.view.snp.bottom).offset(-60)
            make.centerX.equalTo(view.snp.centerX)
        }
        let nextBtnC = self.view.center.x * 3/2
         nextBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.bottomMargin.equalTo(self.view.snp.bottom).offset(-60)
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
