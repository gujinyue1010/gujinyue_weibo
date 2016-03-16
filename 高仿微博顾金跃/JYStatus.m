//
//  JYStatus.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/17.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYStatus.h"
#import "JYUser.h"
#import "NSDate+JYDate.h"
#import "MJExtension.h"
#import "JYPhoto.h"

@implementation JYStatus
//+(instancetype)statusWithDict:(NSDictionary *)dict
//{
//    return [[self alloc]initWithDict:dict];
//}
//
//-(instancetype)initWithDict:(NSDictionary *)dict
//{
//    if(self=[super init])
//    {
//        self.idstr=dict[@"idstr"];
//        self.text=dict[@"text"];
//        self.source=dict[@"source"];
//        self.reposts_count=[dict[@"reposts_count"]intValue];
//        self.comments_count=[dict[@"comments_count"]intValue];
//        self.user=[JYUser userWithDict:dict[@"user"]];
//    }
//    return self;
//}

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[JYPhoto class]};
}

-(NSString *)created_at
{
    
    //1.获得微博的发送时间
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
#warning 真机调试下，必须加上这段
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate=[fmt dateFromString:_created_at];
   
    
    //3.判断微博发送时间和现在时间的差距
    if(createdDate.isToday)
    {
        //今天
        if(createdDate.deltaWithNow.hour>=1)
        {
            return [NSString stringWithFormat:@"%ld小时前",(long)createdDate.deltaWithNow.hour];
        }
        else if(createdDate.deltaWithNow.minute>=1)
        {
            return [NSString stringWithFormat:@"%ld分钟前",(long)createdDate.deltaWithNow.minute];
        }
        else
        {
            return @"刚刚";
        }
        
    }
    else if(createdDate.isYesterday)
    {
        //昨天
        fmt.dateFormat=@"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else if(createdDate.isThisYear)
    {
        //今年(至少是前天)
        fmt.dateFormat=@"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else
    {
        //非今年
        fmt.dateFormat=@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}
-(void)setSource:(NSString *)source
{
    int jianLoc=(int)[source rangeOfString:@">"].location;
    if (jianLoc==(int)NSNotFound) {
        _source=[source copy];
    }else{
        int loc=jianLoc+1;
        int length=(int)[source rangeOfString:@"</"].location-loc;
        source=[source substringWithRange:NSMakeRange(loc, length)];
        //        NSLog(@"=======%@",source);
        _source=[NSString stringWithFormat:@"来自%@",source];
    }
    
}
//-(NSString *)source
//{
//    int startLoc=(int)[_source rangeOfString:@">"].location+1;
//    int length=(int)[_source rangeOfString:@"</"].location-startLoc;
//    
//    return [NSString stringWithFormat:@"来自%@",[_source substringWithRange:NSMakeRange(startLoc, length)]];
//}

//-(void)setSource:(NSString *)source
//{
//    int startLoc=(int)[source rangeOfString:@">"].location+1;
//    int length=(int)[source rangeOfString:@"</"].location-startLoc;
//    source=[source substringWithRange:NSMakeRange(startLoc,length)];
//    
//    _source=[NSString stringWithFormat:@"来自%@",source];
//}
@end
