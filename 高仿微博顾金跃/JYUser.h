//
//  JYUser.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/17.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYUser : NSObject

//用户的ID
@property(nonatomic,copy)NSString *idstr;

//用户的昵称
@property(nonatomic,copy)NSString *name;

//用户的头像
@property(nonatomic,copy)NSString *profile_image_url;

//会员等级
@property(nonatomic,assign,getter=isVip) int mbrank;

//会员类型>2
@property(nonatomic,assign)int mbtype
;

//+(instancetype)userWithDict:(NSDictionary *)dict;
//-(instancetype)initWithDict:(NSDictionary *)dict;
@end
