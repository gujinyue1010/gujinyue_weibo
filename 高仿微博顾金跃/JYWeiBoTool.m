//
//  JYWeiBoTool.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/16.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYWeiBoTool.h"
#import "JYTabBarViewController.h"
#import "JYNewFeatureController.h"

@implementation JYWeiBoTool
+(void)chooseRootController
{
    //3.取出沙盒中上次使用的版本号
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *lastVersion=[defaults stringForKey:@"lastVersion"];
    
    //4.获取当前软件的版本号
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if([currentVersion isEqualToString:lastVersion])
    {
        //不是第一次使用
        [UIApplication sharedApplication].keyWindow.rootViewController=[[JYTabBarViewController alloc]init];
    }
    else
    {
        //有新版本了
        [UIApplication sharedApplication].keyWindow.rootViewController=[[JYNewFeatureController alloc]init];
        //存储新版本
        [defaults setObject:currentVersion forKey:@"lastVersion"];
        //同步
        [defaults synchronize];
    }
}
@end
