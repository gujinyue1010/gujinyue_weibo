//
//  JYAccount.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/16.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYAccount : NSObject<NSCoding>

@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,assign)long long expires_in;
@property(nonatomic,assign)long long remind_in;
@property(nonatomic,assign)long long uid;

//账号的过期时间
@property(nonatomic,strong)NSDate *expireTime;

+(instancetype)accountWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
