//
//  JYStatusToolBar.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/25.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYStatus;
@interface JYStatusToolBar : UIImageView
//把模型数据传递过来
@property(nonatomic,strong)JYStatus *status;
@end
