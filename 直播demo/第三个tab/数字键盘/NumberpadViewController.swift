//
//  NumberpadViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/8/25.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit

class NumberpadViewController: UIViewController,UITextFieldDelegate {
    var textField:UITextField!
    var doneButton:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //      创建并添加一个 UITextField
        textField = UITextField.init(frame: CGRect.init(x: 20, y: 90, width: 200, height: 30))
        //        设置边框样式
        textField.borderStyle = .roundedRect
        //        设置键盘类型
        textField.keyboardType = .numberPad
        self.view.addSubview(textField)
        //        添加自定义按钮
        addCustomKeyboard()
        
        
        //创建按钮并添加到键盘上
        doneButton = UIButton.init()
        doneButton.setTitle("我缩!", for: .normal)
        doneButton.setTitleColor(UIColor.red, for: .normal)
        doneButton.frame = CGRect.init(x: 5, y: 0, width: 106, height: 53)
        doneButton.adjustsImageWhenHighlighted = false
        doneButton.addTarget(self, action: #selector(self.doneAction), for: .touchUpInside)
        
        //        监听键盘弹出通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        //        监听键盘隐藏通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    //    MARK:键盘显示
    func keyboardWillShow(_ note : NSNotification)-> Void{
        DispatchQueue.main.async {
//            找到键盘的window
            let keyBoardWindow = UIApplication.shared.windows.last
//            将 我缩 按钮添加到键盘中
            keyBoardWindow?.addSubview(self.doneButton)
            keyBoardWindow?.bringSubview(toFront: self.doneButton)
//            显示 我缩 按钮
            self.doneButton.isHidden = false
//            计算 我缩 按钮最终要显示的y坐标
            let btnY = (keyBoardWindow?.frame.size.height)! - 53
            
            if let userInfo = note.userInfo,
                let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
                let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt{
                   let frame = value.cgRectValue
//                获取虚拟键盘实际的位置和尺寸
                let intersection = frame.intersection(self.view.frame)
//                设置 我缩 按钮最开始的y坐标
                self.doneButton.frame.origin.y = btnY + intersection.height
//                让 我缩 按钮跟随键盘移动
                UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.init(rawValue: curve), animations: { 
                      self.doneButton.frame.origin.y = btnY
                }, completion: nil)
            }
        }
    }
    //    MARK:键盘隐藏
    func keyboardWillHide(_ note : NSNotification)-> Void{
        //隐藏“完成”按钮
        self.doneButton.isHidden = true
    }
    
    
    //MARK: 添加自定义按钮
    func addCustomKeyboard(){
        let doneToolbar = UIToolbar.init()
        //左侧的空隙
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //        右侧的完成按钮
        let done: UIBarButtonItem = UIBarButtonItem.init(title: "回去!", style: .done, target: self, action: #selector(self.doneAction))
        
        var items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.textField.inputAccessoryView = doneToolbar
        
    }
    //MARK:回去 点击事件
    func doneAction(){
        //收起键盘
        self.textField.resignFirstResponder()
        print("您输入的是:\(textField.text!)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
