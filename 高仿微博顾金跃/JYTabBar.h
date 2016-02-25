//
//  JYTabBar.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/13.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYTabBar;

@protocol JYTabBarDelegate <NSObject>
@optional
-(void)tabBar:(JYTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface JYTabBar : UIView
-(void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property(nonatomic,weak)id<JYTabBarDelegate>delegate;
@end
