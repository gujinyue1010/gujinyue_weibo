//
//  NSDate+JYDate.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/24.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "NSDate+JYDate.h"

@implementation NSDate (JYDate)
//是否为今天
-(BOOL)isToday
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    
    //1.获得当前时间的年月日
    NSDateComponents *nowCmps=[calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    //2.获得self的年月日
    NSDateComponents *selfCmps=[calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    
    return (selfCmps.year==nowCmps.year)&&(selfCmps.month==nowCmps.month)&&(selfCmps.day==nowCmps.day);
}

-(BOOL)isYesterday
{
    return NO;
}

-(BOOL)isThisYear
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    
    //1.获得当前时间的年月日
    NSDateComponents *nowCmps=[calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    //2.获得self的年月日
    NSDateComponents *selfCmps=[calendar components:NSCalendarUnitYear fromDate:self];
    
    return  nowCmps.year==selfCmps.year;
}

-(NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
