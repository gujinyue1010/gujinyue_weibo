//
//  AppDelegate.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/2.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "AppDelegate.h"
#import "JYWeiBoTool.h"
#import "JYAccount.h"
#import "JYOAuthViewController.h"
#import "JYAccountTool.h"
#import "JYNewFeatureController.h"
#import "JYTabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //1.延长启动界面的时间
    [NSThread sleepForTimeInterval:1.0];
    
    //2.先判断有无账号信息
    JYAccount *account=[JYAccountTool account];
    
    if(account)
    {
        //登录成功
        [JYWeiBoTool chooseRootController];
    }
    else
    {
        //之前没有登录成功
        self.window.rootViewController=[[JYOAuthViewController alloc]init];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
