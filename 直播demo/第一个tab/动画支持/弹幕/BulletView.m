//
//  BulletView.m
//  danMu
//
//  Created by Shaoting Zhou on 2017/9/11.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import "BulletView.h"

#define padding 10
#define imgHeight 30
@interface BulletView()
@property (nonatomic,strong) UILabel * lbComment;
@property (nonatomic,strong) UIImageView * imgView;

@end

@implementation BulletView

//MARK: 初始化弹幕
-(instancetype)initWithCommentDic:(NSDictionary *)dic{
    if(self = [super init]){
        self.layer.cornerRadius = 30/2;
        
        CGFloat colorR = arc4random()%255;
        CGFloat colorG = arc4random()%255;
        CGFloat colorB = arc4random()%255;
        self.backgroundColor = [UIColor colorWithRed:colorR/255 green:colorG/255 blue:colorB/255 alpha:1.0];
        
        //计算弹幕的实际宽度
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        NSString * comment = dic[@"danmu"];
        CGFloat width = [comment sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width + 2 * padding + imgHeight , 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(padding + imgHeight, 0, width, 30);
        //头像
        self.imgView.frame = CGRectMake(-padding, -padding, imgHeight + padding,  imgHeight + padding);
        self.imgView.layer.cornerRadius =  (imgHeight + padding)/2;
        NSURL * url = [NSURL URLWithString:dic[@"userPhoto"]];
        self.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];;
        
//        NSLog(@"%@",comment);
    }
    return self;
}

-(UILabel *)lbComment{
    if(!_lbComment){
        self.lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        self.lbComment.font = [UIFont systemFontOfSize:14];
        self.lbComment.textColor = [UIColor whiteColor];
        self.lbComment.textAlignment =  NSTextAlignmentCenter;
        [self addSubview:self.lbComment];

    }
    return _lbComment;
}

-(UIImageView *)imgView{
    if(!_imgView){
        self.imgView = [UIImageView new];
        self.imgView.clipsToBounds = YES;
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imgView];
    }
    return _imgView;
}



//MARK:开始动画
-(void)startAnimation{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    
//    弹幕开始
    if(self.moveStatusBlock){
        self.moveStatusBlock(Start);
    }
    
    CGFloat speed = wholeWidth/duration;   // v =  s/t
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;  //完全进入屏幕所需时间
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
    
    
    //v = s/t   时间相同,弹幕越长,速度越快
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x = -wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview] ;
    
//        回调状态
        if(self.moveStatusBlock){
            self.moveStatusBlock(End);
        }
        
    }];
    
    
}

//MARK:结束动画
-(void)stopAnimation{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

//MARK: 弹幕完全入屏幕调用
-(void)enterScreen{
    if(self.moveStatusBlock){
        self.moveStatusBlock(Enter);
    }
}

@end
