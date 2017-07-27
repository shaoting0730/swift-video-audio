//
//  ScratchCard.swift
//  hangge_1660
//
//  Created by hangge on 2017/7/10.
//  Copyright © 2017年 hangge.com. All rights reserved.
//

import UIKit

//刮刮卡代理协议
@objc protocol ScratchCardDelegate {
    @objc optional func scratchBegan(point: CGPoint)
    @objc optional func scratchMoved(progress: Float)
    @objc optional func scratchEnded(point: CGPoint)
}

//刮刮卡
class ScratchCard: UIView {
    //涂层
    var scratchMask: ScratchMask!
    //底层券面图片
    var couponImageView: UIImageView!

    //刮刮卡代理对象
    weak var delegate: ScratchCardDelegate?
    {
        didSet
        {
            scratchMask.delegate = delegate
        }
    }
    
    public init(frame: CGRect, couponImage: UIImage, maskImage: UIImage,
                scratchWidth: CGFloat = 15, scratchType: CGLineCap = .square) {
        super.init(frame: frame)
        
        let childFrame = CGRect(x: 0, y: 0, width: self.frame.width,
                                height: self.frame.height)
        
        //添加底层券面
        couponImageView = UIImageView(frame: childFrame)
        couponImageView.image = couponImage
        self.addSubview(couponImageView)
        
        //添加涂层
        scratchMask = ScratchMask(frame: childFrame)
        scratchMask.image = maskImage
        scratchMask.lineWidth = scratchWidth
        scratchMask.lineType = scratchType
        self.addSubview(scratchMask)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
