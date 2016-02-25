//
//  JYStatus.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/17.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JYUser;
@interface JYStatus : NSObject

//内容(文字)
@property(nonatomic,copy)NSString *text;

//微博的创建时间
@property(nonatomic,copy)NSString *created_at;

//微博来源
@property(nonatomic,copy)NSString *source;

//微博ID
@property(nonatomic,copy)NSString *idstr;

//微博的转发数
@property(nonatomic,assign)int reposts_count;

//微博的评论数
@property(nonatomic,assign)int comments_count;

//微博的表态数(赞)
@property(nonatomic,assign)int attitudes_count;

//微博的作者对象
@property(nonatomic,strong)JYUser *user;

//微博的单张配图
//@property(nonatomic,copy)NSString *thumbnail_pic;
@property(nonatomic,strong)NSArray *pic_urls;

//被转发的微博
@property(nonatomic,strong)JYStatus *retweeted_status;

//+(instancetype)statusWithDict:(NSDictionary *)dict;
//-(instancetype)initWithDict:(NSDictionary *)dict;
@end
