//
//  OneViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/3/21.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation
fileprivate let UITableViewCellIdentifier = "UITableViewCellIdentifier"
class OneViewController: UIViewController {
    var oneModel = [OneModel]()
    var isAnimation:Bool?
    var y:CGFloat = 0
    var player: AVAudioPlayer?

    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: UIScreen.main.bounds)
        tableView.register(OneTableViewCell.self, forCellReuseIdentifier: UITableViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 300
        view.addSubview(tableView)
        self.player?.delegate = self

        OneModel.loadData { (data) in
            self.oneModel = data
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension OneViewController:UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return oneModel.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCellIdentifier, for: indexPath) as! OneTableViewCell
       
        cell.nameLabel.text = oneModel[indexPath.row].user?.nick
        
        let imgStr = oneModel[indexPath.row].user?.portrait
        cell.userimageView.sd_setImage(with: URL.init(string: imgStr!))
        cell.userBigImg.sd_setImage(with: URL.init(string: imgStr!))
        
       let city = oneModel[indexPath.row].city!
        var newCity:NSMutableAttributedString?
        if city.characters.count > 0 {
            newCity =  NSMutableAttributedString.init(string: "来自:"+city)
            newCity?.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange.init(location: 0, length: 3))
        }
        cell.cityLabel.attributedText = newCity
        cell.contentView.transform = CGAffineTransform.init(scaleX: 0.9, y: 1)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        UIView.animate(withDuration: 0.8, animations: {
            cell.contentView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        })
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let path = Bundle.main.path(forResource: "start", ofType: "mp3")
        let data = NSData.init(contentsOfFile: path!)
        self.player = try? AVAudioPlayer.init(data: data! as Data)
        self.player?.updateMeters()
        self.player?.prepareToPlay()
        self.player?.play()
        
    
        let  stream_addr = oneModel[indexPath.row].stream_addr
        let portrait = oneModel[indexPath.row].user?.portrait
        let videoVC = VideoViewController()
        videoVC.stream_addr = stream_addr
        videoVC.portrait = portrait
        self.present(videoVC, animated: true, completion: nil)
    }

}

