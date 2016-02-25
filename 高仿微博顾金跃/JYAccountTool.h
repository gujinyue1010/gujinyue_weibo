//
//  JYAccountTool.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/16.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYAccount.h"
@interface JYAccountTool : NSObject
+(void)saveAccount:(JYAccount *)account;
+(JYAccount *)account;
@end
