//
//  JYStatusTopView.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/25.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYStatusTopView.h"
#import "UIImage+JYImage.h"
#import "JYStatusFrame.h"
#import "JYUser.h"
#import "JYStatus.h"
#import "UIImageView+WebCache.h"
#import "JYRetweetStatusView.h"
#import "JYPhoto.h"
#import "JYPhotosView.h"


@interface JYStatusTopView()
//头像
@property(nonatomic,weak)UIImageView *iconView;
//会员图标
@property(nonatomic,weak)UIImageView *vipView;

//配图
@property(nonatomic,weak)JYPhotosView *photosView;

//昵称
@property(nonatomic,weak)UILabel *nameLabel;
//时间
@property(nonatomic,weak)UILabel *timeLabel;
//来源
@property(nonatomic,weak)UILabel *sourceLabel;
//正文
@property(nonatomic,weak)UILabel *contentLabel;

//被转发微博的view
@property(nonatomic,weak)JYRetweetStatusView *retweetView;

@end

@implementation JYStatusTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if(self)
    {
        self.userInteractionEnabled=YES;
        //1.设置图片
        self.image=[UIImage resizedImageWithName:@"timeline_card_top_background_os7"];
        self.highlightedImage=[UIImage resizedImageWithName:@"timeline_card_top_background_highlighted_os7"];
        
        //2.头像
        UIImageView *iconView=[[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView=iconView;
        
        //3.会员图标
        UIImageView *vipView=[[UIImageView alloc]init];
        vipView.contentMode=UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView=vipView;
        
        //4.配图
        JYPhotosView *photosView=[[JYPhotosView alloc]init];
        [self addSubview:photosView];
        self.photosView=photosView;
        
        //5.昵称
        UILabel *nameLabel=[[UILabel alloc]init];
        nameLabel.font=JYStatusNameFont;
        nameLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        //6.时间
        UILabel *timeLabel=[[UILabel alloc]init];
        timeLabel.font=JYStatusTimeFont;
        timeLabel.textColor=[UIColor colorWithRed:(240/255.0f) green:(140/255.0f) blue:(19/255.0f) alpha:1.0f];
        timeLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        //7.来源
        UILabel *sourceLabel=[[UILabel alloc]init];
        sourceLabel.font=JYStatusSourceFont;
        sourceLabel.textColor=[UIColor colorWithRed:(135/255.0f) green:(135/255.0f) blue:(135/255.0f) alpha:1.0f];
        sourceLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel=sourceLabel;
        
        //8.正文
        UILabel *contentLabel=[[UILabel alloc]init];
        contentLabel.font=JYStatusContentFont;
        contentLabel.textColor=[UIColor colorWithRed:(39/255.0f) green:(39/255.0f) blue:(39/255.0f) alpha:1.0f];
        contentLabel.backgroundColor=[UIColor clearColor];
        contentLabel.numberOfLines=0;
        [self addSubview:contentLabel];
        self.contentLabel=contentLabel;
        
        //9.添加被转发微博的view
        //1.被转发微博的view(父控件)
        JYRetweetStatusView *retweetView=[[JYRetweetStatusView alloc]init];
        [self addSubview:retweetView];
        self.retweetView=retweetView;

    }
    return self;
}
-(void)setStatusFrame:(JYStatusFrame *)statusFrame
{
    _statusFrame=statusFrame;
    
    //1.取出模型数据
    JYStatus *status=statusFrame.status;
    JYUser *user=status.user;
    
    //2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame=self.statusFrame.iconViewF;
    
    //3.昵称
    self.nameLabel.text=user.name;
    self.nameLabel.frame=self.statusFrame.nameLabelF;
    
    //4.vip
    if(user.mbtype)
    {
        self.vipView.hidden=NO;
        self.vipView.image=[UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank
                                                ]];
        self.nameLabel.textColor=[UIColor orangeColor];
        self.vipView.frame=self.statusFrame.vipViewF;
    }
    else
    {
        self.vipView.hidden=YES;
    }
    
    //5.时间
    self.timeLabel.text=status.created_at;
    
    CGFloat timeLabelX=self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY=CGRectGetMaxY(self.statusFrame.nameLabelF)+JYStatusCellBorder*0.5;
    CGSize timeLabelSize=[status.created_at sizeWithFont:JYStatusTimeFont];
    self.timeLabel.frame=(CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    
    //6.来源
    self.sourceLabel.text=status.source;
    CGFloat sourceLabelX=CGRectGetMaxX(self.timeLabel.frame)+JYStatusCellBorder;
    CGFloat sourceLabelY=timeLabelY;
    CGSize sourceLabelSize=[status.source sizeWithFont:JYStatusSourceFont];
    self.sourceLabel.frame=(CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    
    //7.正文
    self.contentLabel.text=status.text;
    self.contentLabel.frame=self.statusFrame.contentLabelF;
    
    //8.配图
    if(status.pic_urls.count)
    {
        self.photosView.hidden=NO;
        self.photosView.frame=self.statusFrame.photosViewF;
        
        self.photosView.photos=status.pic_urls;
        
//        JYPhoto *photo=status.pic_urls[0];
//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
    else
    {
        self.photosView.hidden=YES;
        
    }
    
    //9.被转发微博
    JYStatus *retweetStatus=self.statusFrame.status.retweeted_status;
    
    if(retweetStatus)
    {
        self.retweetView.hidden=NO;
        //1.父控件
        self.retweetView.frame=self.statusFrame.retweetViewF;
        
        //2.传递模型数据
        self.retweetView.statusFrame=self.statusFrame;
        
    }
    else
    {
        self.retweetView.hidden=YES;
    }

}

@end
