//
//  JYStatusCell.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/17.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYStatusCell.h"
#import "JYStatus.h"
#import "JYStatusFrame.h"
#import "JYUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+JYImage.h"
#import "JYStatusToolBar.h"
#import "JYRetweetStatusView.h"
#import "JYStatusTopView.h"

@interface JYStatusCell()

//顶部的view
@property(nonatomic,weak)JYStatusTopView *topView;
////头像
//@property(nonatomic,weak)UIImageView *iconView;
////会员图标
//@property(nonatomic,weak)UIImageView *vipView;
////配图
//@property(nonatomic,weak)UIImageView *photoView;
////昵称
//@property(nonatomic,weak)UILabel *nameLabel;
////时间
//@property(nonatomic,weak)UILabel *timeLabel;
////来源
//@property(nonatomic,weak)UILabel *sourceLabel;
////正文
//@property(nonatomic,weak)UILabel *contentLabel;



////被转发微博的view
//@property(nonatomic,weak)JYRetweetStatusView *retweetView;
////被转发微博作者的昵称
//@property(nonatomic,weak)UILabel *retweetNameLabel;
////被转发微博的正文
//@property(nonatomic,weak)UILabel *retweetContentLabel;
////被转发微博的配图
//@property(nonatomic,weak)UIImageView *retweetPhotoView;



//微博的工具条
@property(nonatomic,weak)JYStatusToolBar *statusToolBar;

@end


@implementation JYStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"status";
    JYStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil)
    {
        cell=[[JYStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //1.添加原创微博内部的子控件
        //[self setupOriginalSubviews];
        
        //1.添加顶部的View
        [self setupTopView];
        
        //2.添加被转发微博内部的子控件
        //[self setupRetweetSubviews];
        
        //3.添加微博的工具条
        [self setupStatusToolBar];
        
    }
    return self;
}

//-(void)setupOriginalSubviews
-(void)setupTopView
{
    //0.设置选中时的背景
    self.selectedBackgroundView=[[UIView alloc]init];
    self.backgroundColor=[UIColor clearColor];
    
    //1.最外面的父控件
    JYStatusTopView *topView=[[JYStatusTopView alloc]init];
//    topView.image=[UIImage resizedImageWithName:@"timeline_card_top_background_os7"];
//    topView.highlightedImage=[UIImage resizedImageWithName:@"timeline_card_top_background_highlighted_os7"];
    [self.contentView addSubview:topView];
    self.topView=topView;
    
//    //2.头像
//    UIImageView *iconView=[[UIImageView alloc]init];
//    [self.topView addSubview:iconView];
//    self.iconView=iconView;
//    
//    //3.会员图标
//    UIImageView *vipView=[[UIImageView alloc]init];
//    vipView.contentMode=UIViewContentModeCenter;
//    [self.topView addSubview:vipView];
//    self.vipView=vipView;
//    
//    //4.配图
//    UIImageView *photoView=[[UIImageView alloc]init];
//    [self.topView addSubview:photoView];
//    self.photoView=photoView;
//    
//    //5.昵称
//    UILabel *nameLabel=[[UILabel alloc]init];
//    nameLabel.font=JYStatusNameFont;
//    nameLabel.backgroundColor=[UIColor clearColor];
//    [self.topView addSubview:nameLabel];
//    self.nameLabel=nameLabel;
//    
//    //6.时间
//    UILabel *timeLabel=[[UILabel alloc]init];
//    timeLabel.font=JYStatusTimeFont;
//    timeLabel.textColor=[UIColor colorWithRed:(240/255.0f) green:(140/255.0f) blue:(19/255.0f) alpha:1.0f];
//    timeLabel.backgroundColor=[UIColor clearColor];
//    [self.topView addSubview:timeLabel];
//    self.timeLabel=timeLabel;
//    
//    //7.来源
//    UILabel *sourceLabel=[[UILabel alloc]init];
//    sourceLabel.font=JYStatusSourceFont;
//    sourceLabel.textColor=[UIColor colorWithRed:(135/255.0f) green:(135/255.0f) blue:(135/255.0f) alpha:1.0f];
//    sourceLabel.backgroundColor=[UIColor clearColor];
//    [self.topView addSubview:sourceLabel];
//    self.sourceLabel=sourceLabel;
//    
//    //8.正文
//    UILabel *contentLabel=[[UILabel alloc]init];
//    contentLabel.font=JYStatusContentFont;
//    contentLabel.textColor=[UIColor colorWithRed:(39/255.0f) green:(39/255.0f) blue:(39/255.0f) alpha:1.0f];
//    contentLabel.backgroundColor=[UIColor clearColor];
//    contentLabel.numberOfLines=0;
//    [self.topView addSubview:contentLabel];
//    self.contentLabel=contentLabel;
}

//-(void)setupRetweetSubviews
//{
//    //1.被转发微博的view(父控件)
//    JYRetweetStatusView *retweetView=[[JYRetweetStatusView alloc]init];
////    retweetView.image=[UIImage resizedImageWithName:@"timeline_retweet_background_os7" left:0.9 top:0.5];
//    [self.topView addSubview:retweetView];
//    self.retweetView=retweetView;
    
//    //2.被转发微博作者的昵称
//    UILabel *retweetNameLabel=[[UILabel alloc]init];
//    retweetNameLabel.font=JYRetweetStatusNameFont;
//    retweetNameLabel.textColor=[UIColor colorWithRed:(30/255.0f) green:(69/255.0f) blue:(230/255.0f) alpha:1.0f];
//    retweetNameLabel.backgroundColor=[UIColor clearColor];
//    [self.retweetView addSubview:retweetNameLabel];
//    self.retweetNameLabel=retweetNameLabel;
//    
//    //3.被转发微博的正文
//    UILabel *retweetContentLabel=[[UILabel alloc]init];
//    retweetContentLabel.font=JYRetweetStatusContentFont;
//    retweetContentLabel.backgroundColor=[UIColor clearColor];
//    retweetContentLabel.numberOfLines=0;
//    [self.retweetView addSubview:retweetContentLabel];
//    self.retweetContentLabel=retweetContentLabel;
//
//    //4.被转发微博的配图
//    UIImageView *retweetPhotoView=[[UIImageView alloc]init];
//    [self.retweetView addSubview:retweetPhotoView];
//    self.retweetPhotoView=retweetPhotoView;
    
//}

-(void)setupStatusToolBar
{
    JYStatusToolBar *statusToolBar=[[JYStatusToolBar alloc]init];
//    statusToolBar.image=[UIImage resizedImageWithName:@"timeline_card_bottom_background_os7"];
//    statusToolBar.highlightedImage=[UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted_os7"];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar=statusToolBar;
}

//拦截frame的设置
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=JYStatusTableBorder;
    frame.origin.x=JYStatusTableBorder;
    frame.size.width-=2*JYStatusTableBorder;
    frame.size.height-=JYStatusTableBorder;
    [super setFrame:frame];
}

//传递模型数据
-(void)setStatusFrame:(JYStatusFrame *)statusFrame
{
    _statusFrame=statusFrame;
    
    //1.原创微博
    //[self setupOriginalData];
    
    //1.设置顶部View的数据
    [self setupTopViewData];
    
    //2.被转发微博
    //[self setupRetweetData];
    
    //3.微博的工具条
    [self setupStatusToolbarData];
}

//-(void)setupOriginalData
-(void)setupTopViewData
{
//    //0.设置cell选中时的背景
//    UIImageView *bgView=[[UIImageView alloc]initWithImage:[UIImage resizedImageWithName:@"common_card_background_highlighted_os7"]];
//    self.selectedBackgroundView=bgView;
    
    //1.topView
    self.topView.frame=self.statusFrame.topViewF;
    
    //2.传递模型数据
    self.topView.statusFrame=self.statusFrame;
    
//    //2.头像
//    JYStatus *status=self.statusFrame.status;
//    JYUser *user=status.user;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
//    self.iconView.frame=self.statusFrame.iconViewF;
//    
//    //3.昵称
//    self.nameLabel.text=user.name;
//    self.nameLabel.frame=self.statusFrame.nameLabelF;
//    
//    //4.vip
//    if(user.mbtype)
//    {
//        self.vipView.hidden=NO;
//        self.vipView.image=[UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank
//                                                ]];
//        self.nameLabel.textColor=[UIColor orangeColor];
//        self.vipView.frame=self.statusFrame.vipViewF;
//    }
//    else
//    {
//        self.vipView.hidden=YES;
//    }
//    
//    //5.时间
//    self.timeLabel.text=status.created_at;
//    
//    CGFloat timeLabelX=self.statusFrame.nameLabelF.origin.x;
//    CGFloat timeLabelY=CGRectGetMaxY(self.statusFrame.nameLabelF)+JYStatusCellBorder*0.5;
//    CGSize timeLabelSize=[status.created_at sizeWithFont:JYStatusTimeFont];
//    self.timeLabel.frame=(CGRect){{timeLabelX,timeLabelY},timeLabelSize};
//    
//    
//    //6.来源
//    self.sourceLabel.text=status.source;
//    CGFloat sourceLabelX=CGRectGetMaxX(self.timeLabel.frame)+JYStatusCellBorder;
//    CGFloat sourceLabelY=timeLabelY;
//    CGSize sourceLabelSize=[status.source sizeWithFont:JYStatusSourceFont];
//    self.sourceLabel.frame=(CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
//  
//    
//    //7.正文
//    self.contentLabel.text=status.text;
//    self.contentLabel.frame=self.statusFrame.contentLabelF;
//    
//    //8.配图
//    if(status.thumbnail_pic)
//    {
//        self.photoView.hidden=NO;
//        self.photoView.frame=self.statusFrame.photoViewF;
//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    }
//    else
//    {
//        self.photoView.hidden=YES;
//          
//    }
    
}
//-(void)setupRetweetData
//{
//    JYStatus *retweetStatus=self.statusFrame.status.retweeted_status;
//    
//    if(retweetStatus)
//    {
//        self.retweetView.hidden=NO;
//        //1.父控件
//        self.retweetView.frame=self.statusFrame.retweetViewF;
//        
//        //2.传递模型数据
//        self.retweetView.statusFrame=self.statusFrame;
//        
////        //2.昵称
////        self.retweetNameLabel.text=[NSString stringWithFormat:@"@%@",user.name];
////        self.retweetNameLabel.frame=self.statusFrame.retweetNameLabelF;
////        
////        //3.正文
////        self.retweetContentLabel.text=retweetStatus.text;
////        self.retweetContentLabel.frame=self.statusFrame.retweetContentLabelF;
////        
////        //4.配图
////        if(retweetStatus.thumbnail_pic)
////        {
////            self.retweetPhotoView.hidden=NO;
////            self.retweetPhotoView.frame=self.statusFrame.retweetPhotoViewF;
////            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
////        }
////        else
////        {
////            self.retweetPhotoView.hidden=YES;
////        }
//    }
//    else
//    {
//        self.retweetView.hidden=YES;
//    }
//}

-(void)setupStatusToolbarData
{
    self.statusToolBar.frame=self.statusFrame.statusToolBarF;
    self.statusToolBar.status=self.statusFrame.status;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
