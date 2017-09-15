//
//  BulletView.h
//  danMu
//
//  Created by Shaoting Zhou on 2017/9/11.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MoveStatus){
    Start,
    Enter,
    End,
};
@interface BulletView : UIView
@property (nonatomic,assign) int trajectory;  //弹幕弹道
@property (nonatomic,copy) void(^ moveStatusBlock)(MoveStatus status);  //弹幕状态回调 开始  运行中 结束

-(instancetype)initWithCommentDic:(NSDictionary *)dic;   //初始化弹幕

-(void)startAnimation;  //开始动画
-(void)stopAnimation; //结束动画

@end
