//
//  JYStatusFrame.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/19.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

//昵称的字体
#define JYStatusNameFont [UIFont systemFontOfSize:16]
//时间的字体
#define JYStatusTimeFont [UIFont systemFontOfSize:13]
//来源的字体
#define JYStatusSourceFont [UIFont systemFontOfSize:13]
//正文的字体
#define JYStatusContentFont [UIFont systemFontOfSize:14]


//被转发微博正文的字体
#define JYRetweetStatusContentFont [UIFont systemFontOfSize:13]
//被转发微博作者昵称的字体
#define JYRetweetStatusNameFont [UIFont systemFontOfSize:15]

//表格的边框宽度
#define JYStatusTableBorder 6

//cell的边框宽度
#define  JYStatusCellBorder 8


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JYStatus;

@interface JYStatusFrame : NSObject
@property(nonatomic,strong)JYStatus *status;

//顶部的view
@property(nonatomic,assign,readonly)CGRect topViewF;
//头像
@property(nonatomic,assign,readonly)CGRect iconViewF;
//会员图标
@property(nonatomic,assign,readonly)CGRect vipViewF;
//配图
@property(nonatomic,assign,readonly)CGRect photosViewF;
//昵称
@property(nonatomic,assign,readonly)CGRect nameLabelF;
//时间
@property(nonatomic,assign,readonly)CGRect timeLabelF;
//来源
@property(nonatomic,assign,readonly)CGRect sourceLabelF;
//正文
@property(nonatomic,assign,readonly)CGRect contentLabelF;



//被转发微博的view
@property(nonatomic,assign,readonly)CGRect retweetViewF;
//被转发微博作者的昵称
@property(nonatomic,assign,readonly)CGRect retweetNameLabelF;
//被转发微博的正文
@property(nonatomic,assign,readonly)CGRect retweetContentLabelF;
//被转发微博的配图
@property(nonatomic,assign,readonly)CGRect retweetPhotosViewF;



//微博的工具条
@property(nonatomic,assign,readonly)CGRect statusToolBarF;

//cell的高度
@property(nonatomic,assign,readonly)CGFloat cellHeight;

@end
