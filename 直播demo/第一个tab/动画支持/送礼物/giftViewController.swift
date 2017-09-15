//
//  giftViewController.swift
//  sendGift
//
//  Created by Shaoting Zhou on 2017/9/13.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import SDWebImage
private let  CellIdentifier = "EmojiCellIdentifier"

class giftViewController: UIViewController {
    var cellNum = -1
    var lastPath:IndexPath!
    lazy var giftView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: 60, height: 60)
        let size = UIScreen.main.bounds.size
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: size.height, width: size.width, height: 240), collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.init(r: 255, g: 192, b: 203, alpha: 0.7)
        return collectionView
    }()
     lazy var sendGiftBtn:UIButton  = {
        let size = UIScreen.main.bounds.size
        var sendGiftBtn = UIButton.init(frame: CGRect.init(x: 0, y: size.height, width: size.width, height: 40))
        sendGiftBtn.setTitle("点我就送!", for: .normal)
        sendGiftBtn.setTitleColor(UIColor.white, for: .normal)
        sendGiftBtn.addTarget(self, action: #selector(giftViewController.noificationAction), for: .touchUpInside)
        sendGiftBtn.backgroundColor = UIColor.init(r: 255, g: 192, b: 203, alpha: 0.8)
        return sendGiftBtn
    }()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        self.view.addSubview(sendGiftBtn)
        self.view.addSubview(giftView)
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: 添加自定义按钮
  

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension giftViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 15;
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath)
        let imgView = UIImageView.init(frame: CGRect.init(x: 2, y: 2, width: 60, height: 60))
        let imgName = "gif" + String(indexPath.item)
        let path = Bundle.main.path(forResource: imgName, ofType: ".gif")
        let data = NSData.init(contentsOfFile: path!)
        imgView.image = UIImage.sd_animatedGIF(with: data! as Data)
        cell.addSubview(imgView)
        
//        let row = indexPath.item
//        let oldRow = lastPath.item
//        if(row == oldRow && lastPath != nil){
//            cell.accessibilityIdentifier = "OK"
//        }else{
//            cell.accessibilityIdentifier = "NO"
//
//        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.layer.borderColor = UIColor.clear.cgColor
        cell?.contentView.layer.borderWidth = 0
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

        cellNum = indexPath.item
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.layer.borderColor = UIColor.white.cgColor
        cell?.contentView.layer.borderWidth = 1
                
        
    }
    
    func noificationAction(){
     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelected"), object: cellNum)
    }
    
}


