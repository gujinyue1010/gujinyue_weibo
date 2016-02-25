//
//  JYRetweetStatusView.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/25.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYRetweetStatusView.h"
#import "UIImage+JYImage.h"
#import "JYStatusFrame.h"
#import "JYStatus.h"
#import "JYUser.h"
#import "JYPhoto.h"
#import "UIImageView+WebCache.h"
#import "JYPhotosView.h"

@interface JYRetweetStatusView()
//被转发微博作者的昵称
@property(nonatomic,weak)UILabel *retweetNameLabel;
//被转发微博的正文
@property(nonatomic,weak)UILabel *retweetContentLabel;
//被转发微博的配图
@property(nonatomic,weak)JYPhotosView *retweetPhotosView;
@end

@implementation JYRetweetStatusView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled=YES;
        //1.设置图片
         self.image=[UIImage resizedImageWithName:@"timeline_retweet_background_os7" left:0.9 top:0.5];
        
        //2.被转发微博作者的昵称
        UILabel *retweetNameLabel=[[UILabel alloc]init];
        retweetNameLabel.font=JYRetweetStatusNameFont;
        retweetNameLabel.textColor=[UIColor colorWithRed:(30/255.0f) green:(69/255.0f) blue:(230/255.0f) alpha:1.0f];
        retweetNameLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel=retweetNameLabel;
        
        //3.被转发微博的正文
        UILabel *retweetContentLabel=[[UILabel alloc]init];
        retweetContentLabel.font=JYRetweetStatusContentFont;
        retweetContentLabel.backgroundColor=[UIColor clearColor];
        retweetContentLabel.numberOfLines=0;
        retweetContentLabel.textColor=[UIColor colorWithRed:(90/255.0f) green:(90/255.0f) blue:(90/255.0f) alpha:1.0f];
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel=retweetContentLabel;
        
        //4.被转发微博的配图
        JYPhotosView *retweetPhotosView=[[JYPhotosView alloc]init];
        [self addSubview:retweetPhotosView];
        self.retweetPhotosView=retweetPhotosView;

        
    }
    return self;
}

-(void)setStatusFrame:(JYStatusFrame *)statusFrame
{
    _statusFrame=statusFrame;
    JYStatus *retweetStatus=statusFrame.status.retweeted_status;
    JYUser *user=retweetStatus.user;
    
    //2.昵称
    self.retweetNameLabel.text=[NSString stringWithFormat:@"@%@",user.name];
    self.retweetNameLabel.frame=self.statusFrame.retweetNameLabelF;
    
    //3.正文
    self.retweetContentLabel.text=retweetStatus.text;
    self.retweetContentLabel.frame=self.statusFrame.retweetContentLabelF;
    
    //4.配图
    if(retweetStatus.pic_urls.count)
    {
        self.retweetPhotosView.hidden=NO;
        self.retweetPhotosView.frame=self.statusFrame.retweetPhotosViewF;
        self.retweetPhotosView.photos=retweetStatus.pic_urls;
        
//        JYPhoto *photo=retweetStatus.pic_urls[0];
//        [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
    else
    {
        self.retweetPhotosView.hidden=YES;
    }
}
@end
