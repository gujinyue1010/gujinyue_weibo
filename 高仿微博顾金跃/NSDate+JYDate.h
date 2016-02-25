//
//  NSDate+JYDate.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/24.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JYDate)
//是否为今天
-(BOOL)isToday;

//是否为昨天
-(BOOL)isYesterday;

//是否为今年
-(BOOL)isThisYear;

//获得与当前时间的差距
-(NSDateComponents *)deltaWithNow;
@end
