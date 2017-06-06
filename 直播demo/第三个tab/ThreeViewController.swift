//
//  ThreeViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/6/5.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {
    fileprivate lazy var tableBtn:UIButton = {
        let btn = UIButton.init(frame: CGRect.zero)
        btn.setTitle("tableView联动", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action:#selector(ThreeViewController.tableAction) , for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var collectionBtn:UIButton = {
        let btn = UIButton.init(frame: CGRect.zero)
        btn.setTitle("colletionView联动", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(ThreeViewController.collectionAction), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        addCons()
        // Do any additional setup after loading the view.
    }
    
    func addSubView(){
        view.addSubview(tableBtn)
        view.addSubview(collectionBtn)
    }
    
    func addCons(){
        tableBtn.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(50)
            make.top.equalTo(64)
        }
        
        collectionBtn.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(50)
            make.top.equalTo(tableBtn.snp.bottom).offset(1)
        }
        
    }
    
    func tableAction(){
       self.navigationController?.pushViewController(TableViewController(), animated: true)
    }
    
    func collectionAction(){
        
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
