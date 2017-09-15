//
//  BulletManager.m
//  danMu
//
//  Created by Shaoting Zhou on 2017/9/11.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@interface BulletManager()
@property (nonatomic,strong) NSMutableArray * datasource;   //弹幕数据源
@property (nonatomic,strong) NSMutableArray * bulletComments;  //弹幕使用过程中的数组变量
@property (nonatomic,strong) NSMutableArray * bulletViews;  //存放弹幕view的数组变量
@property BOOL stopAnimation;  //动画结束标示
@end

@implementation BulletManager

-(instancetype)init{
    if(self = [super init]){
        self.stopAnimation = YES;
    }
    return self;
}

-(void)start{
    if(!self.stopAnimation){
        return;
    }
    self.stopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.datasource];
    
    [self initBulletComment];

}

-(void)stop{
    if(self.stopAnimation){
        return;
    }
    self.stopAnimation = YES;
    
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView * view = obj;
        [view stopAnimation];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}


//MARK:初始化弹幕,随机分配弹幕轨迹
-(void)initBulletComment{
    NSMutableArray *  trajectorys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2),@(3)]];
    for (int i = 0; i < 4; i++) {
        if(self.bulletComments.count > 0){
            //        通过随机数获取弹幕轨迹
            NSInteger  index = arc4random()%trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            //    从弹幕数组中取出弹幕数据
            NSDictionary * commentDic = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            
            [self createBulletView:commentDic trajectory:trajectory];
        }

    }
    
}



//MARK: 创建弹幕视图
-(void)createBulletView:(NSDictionary *)commentDic trajectory:(int)trajectory {
    if(self.stopAnimation){
        return;
    }
    BulletView * bulletView = [[BulletView alloc]initWithCommentDic:commentDic];
//    NSLog(@"%@",commentDic);
    bulletView.trajectory = trajectory;
    [self.bulletViews addObject:bulletView];
    
    __weak typeof (bulletView) weakView = bulletView;
    __weak typeof(self) weakSelf = self;
    bulletView.moveStatusBlock = ^(MoveStatus status){
        if(weakSelf.stopAnimation){
            return;
        }
        
        switch (status) {
            case Start:{
                //                弹幕开始,将view加入到弹幕管理的变量bulletViews中
                [weakSelf.bulletViews addObject:weakView];
                break;
            }
            case Enter:{
                //                弹幕完全进入屏幕,判断是否还有弹幕,有的话则在该弹幕轨迹中创建弹幕视图
                NSDictionary * commentDic = [self nextComment];
                if(commentDic){
                    [weakSelf createBulletView:commentDic trajectory:trajectory];  //递归即可
                }
                break;
            }
            case End:{
//            弹幕飞出屏幕后,从bulletViews删除,移除资源
                if([weakSelf.bulletViews containsObject:weakView]){
                    [weakView stopAnimation];
                    [weakSelf.bulletViews removeObject:weakView];
                }
                //已经木有弹幕了,循环播放
                if(weakSelf.bulletViews.count == 0){
                    self.stopAnimation = YES;
                    [weakSelf start];
                }
                break;
            }
            default:
                break;
        }

    };
    
//    回调view给viewControlller
    if(self.generateViewBlock){
        self.generateViewBlock(bulletView);
    }
    
}

//MARK:  取出下一条弹幕
-(NSDictionary *)nextComment{
    NSDictionary * commentDic = [self.bulletComments firstObject];
    if(commentDic){
        [self.bulletComments removeObjectAtIndex:0];
    }
    return commentDic;
}

-(NSMutableArray *)datasource{
    if(!_datasource){
        NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
        NSArray * ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.datasource = [NSMutableArray arrayWithArray:ary];
    }
    return _datasource;
}

-(NSMutableArray *)bulletComments{
    if(!_bulletComments){
        self.bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}

-(NSMutableArray *)bulletViews{
    if(!_bulletViews){
        self.bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}


@end
