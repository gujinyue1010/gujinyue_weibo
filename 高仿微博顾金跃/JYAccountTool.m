//
//  JYAccountTool.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/16.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYAccountTool.h"

@implementation JYAccountTool
+(void)saveAccount:(JYAccount *)account
{
    
    //2.先判断有无账号信息
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *file=[doc stringByAppendingPathComponent:@"account.data"];
    
    //3.计算账号的过期时间
    NSDate *now=[NSDate date];
    account.expireTime=[now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:file];
}
+(JYAccount *)account
{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *file=[doc stringByAppendingPathComponent:@"account.data"];
    
    //1.取出账号
    JYAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    //2.判断是否过期
    NSDate *now=[NSDate date];
    
    if([now compare:account.expireTime]==NSOrderedAscending)
    {
        //还没有过期
        return account;
    }
    else
    {
        //过期了
        return nil;
    }
    
    
    return account;
   
}
@end
