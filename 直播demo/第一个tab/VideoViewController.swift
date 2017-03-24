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
    
    private lazy var backBtn:UIButton  = {
          var backBtn = UIButton.init(frame: CGRect.zero)
          backBtn.setTitle("返回", for: .normal)
          backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.addTarget(self, action: #selector(VideoViewController.backAction), for: .touchUpInside)
          return backBtn
    }()
    
    func backAction (){
       self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //播放
        let url = URL.init(string: stream_addr!)
        ijkPlayVC = IJKFFMoviePlayerController.init(contentURL: url, with: nil)
        ijkPlayVC.view.frame = UIScreen.main.bounds
        self.view.addSubview(ijkPlayVC.view)
        ijkPlayVC.prepareToPlay()
        //返回按钮
        view.insertSubview(backBtn, aboveSubview: ijkPlayVC.view)
        backBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.topMargin.equalTo(self.view.snp.top).offset(20)
            make.leading.equalTo(5)
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
