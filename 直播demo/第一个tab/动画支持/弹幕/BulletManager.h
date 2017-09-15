//
//  BulletManager.h
//  danMu
//
//  Created by Shaoting Zhou on 2017/9/11.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;
@interface BulletManager : NSObject

@property (nonatomic,copy) void(^generateViewBlock)(BulletView* view);

-(void)start;
-(void)stop;
-(void)createBulletView:(NSDictionary *)commentDic trajectory:(int)trajectory;

@end
