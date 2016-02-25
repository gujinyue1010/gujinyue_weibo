//
//  JYAccount.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/16.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYAccount.h"

@implementation JYAccount

+(instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//从文件中解析对象的时候调用
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in=[aDecoder decodeInt64ForKey:@"remind_in"];
        self.expires_in=[aDecoder decodeInt64ForKey:@"expires_in"];
        self.uid=[aDecoder decodeInt64ForKey:@"uid"];
        self.expireTime=[aDecoder decodeObjectForKey:@"expireTime"];
    }
    return self;
}

//将对象写入文件的时候调用
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expireTime forKey:@"expireTime"];
}
@end
