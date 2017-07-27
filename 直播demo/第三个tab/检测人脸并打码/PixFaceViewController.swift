//
//  PixFaceViewController.swift
//  直播demo
//
//  Created by Shaoting Zhou on 2017/7/27.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

import UIKit
import ImageIO

class PixFaceViewController: UIViewController {
    var imageView:UIImageView!  //图片 d1.jpg
    var btn:UIButton! //打码按钮
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView.init(frame: CGRect.init(x: 20, y: 100, width: 280, height: 170))
        imageView.image = UIImage.init(named: "d1.jpg")
        self.view.addSubview(imageView)
        
        btn = UIButton.init(frame: CGRect.init(x: 20, y: 298, width: 200, height: 45))
        btn.setTitle("检测人脸并打码", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(PixFaceViewController.detectAndPixFace), for: .touchUpInside)
        
    }
    
    func detectAndPixFace() {
        // 用CIPixellate滤镜对原图先做个完全马赛克
        let filter = CIFilter(name: "CIPixellate")!
        print(filter.attributes)
        let inputImage = CIImage(image: UIImage.init(named: "d1.jpg")!)!
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let inputScale = max(inputImage.extent.size.width, inputImage.extent.size.height) / 80
        filter.setValue(inputScale, forKey: kCIInputScaleKey)
        let fullPixellatedImage = filter.outputImage
        
        // 检测人脸，并保存在faceFeatures中
        let detector = CIDetector(ofType: CIDetectorTypeFace,
                                  context: context,
                                  options: nil)
        let faceFeatures = detector?.features(in: inputImage)
        // 初始化蒙版图，并开始遍历检测到的所有人脸
        var maskImage: CIImage!
        for faceFeature in faceFeatures! {
            print(faceFeature.bounds)
            // 基于人脸的位置，为每一张脸都单独创建一个蒙版，所以要先计算出脸的中心点，对应为x、y轴坐标，
            // 再基于脸的宽度或高度给一个半径，最后用这些计算结果初始化一个CIRadialGradient滤镜
            let centerX = faceFeature.bounds.origin.x + faceFeature.bounds.size.width / 2
            let centerY = faceFeature.bounds.origin.y + faceFeature.bounds.size.height / 2
            let radius = min(faceFeature.bounds.size.width, faceFeature.bounds.size.height)
            let radialGradient = CIFilter(name: "CIRadialGradient",
                                          withInputParameters: [
                                            "inputRadius0" : radius,
                                            "inputRadius1" : radius + 1,
                                            "inputColor0" : CIColor(red: 0, green: 1, blue: 0, alpha: 1),
                                            "inputColor1" : CIColor(red: 0, green: 0, blue: 0, alpha: 0),
                                            kCIInputCenterKey : CIVector(x: centerX, y: centerY)
                ])!
            print(radialGradient.attributes)
            // 由于CIRadialGradient滤镜创建的是一张无限大小的图，所以在使用之前先对它进行裁剪
            let radialGradientOutputImage = radialGradient.outputImage!
                .cropping(to: inputImage.extent)
            if maskImage == nil {
                maskImage = radialGradientOutputImage
            } else {
                print(radialGradientOutputImage)
                maskImage = CIFilter(name: "CISourceOverCompositing",
                                     withInputParameters: [
                                        kCIInputImageKey : radialGradientOutputImage,
                                        kCIInputBackgroundImageKey : maskImage
                    ])!.outputImage
            }
        }
        // 用CIBlendWithMask滤镜把马赛克图、原图、蒙版图混合起来
        let blendFilter = CIFilter(name: "CIBlendWithMask")!
        blendFilter.setValue(fullPixellatedImage, forKey: kCIInputImageKey)
        blendFilter.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
        blendFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)
        // 输出，在界面上显示
        let blendOutputImage = blendFilter.outputImage
        let blendCGImage = context.createCGImage(blendOutputImage!,
                                                 from: blendOutputImage!.extent)
        imageView.image = UIImage(cgImage: blendCGImage!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
