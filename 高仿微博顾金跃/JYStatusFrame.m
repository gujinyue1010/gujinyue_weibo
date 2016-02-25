//
//  JYStatusFrame.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/19.
//  Copyright © 2016年 顾金跃. All rights reserved.
//


#import "JYStatusFrame.h"
#import "JYStatus.h"
#import "JYUser.h"
#import "JYPhotosView.h"

@implementation JYStatusFrame

//重写
-(void)setStatus:(JYStatus *)status
{
    _status=status;
    
    //cell的宽度
    CGFloat cellW=[UIScreen mainScreen].bounds.size.width-2*JYStatusTableBorder;
    
    //1.topView
    CGFloat topViewW=cellW;
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewH=0;
    
    //2.头像
    CGFloat iconViewWH=35;
    CGFloat iconViewX=JYStatusCellBorder;
    CGFloat iconViewY=JYStatusCellBorder;
    _iconViewF=CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.昵称
    CGFloat nameLabelX=CGRectGetMaxX(_iconViewF)+JYStatusCellBorder;
    CGFloat nameLabelY=iconViewY;
    CGSize nameLabelSize=[status.user.name sizeWithFont:JYStatusNameFont];
    _nameLabelF=CGRectMake(nameLabelX, nameLabelY, nameLabelSize.width, nameLabelSize.height);
    
    //4.会员
     if(status.user.mbtype)
     {
         CGFloat vipViewW=14;
         CGFloat vipViewH=nameLabelSize.height;
         CGFloat vipViewX=CGRectGetMaxX(_nameLabelF)+JYStatusCellBorder;
         CGFloat vipViewY=nameLabelY;
         _vipViewF=CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
     }
    
    //5.时间
    CGFloat timeLabelX=nameLabelX;
    CGFloat timeLabelY=CGRectGetMaxY(_nameLabelF)+JYStatusCellBorder*0.5;
    CGSize timeLabelSize=[status.created_at sizeWithFont:JYStatusTimeFont];
    _timeLabelF=(CGRect){{timeLabelX,timeLabelY},timeLabelSize};
   
    
    //6.来源
    CGFloat sourceLabelX=CGRectGetMaxX(_timeLabelF)+JYStatusCellBorder;
    CGFloat sourceLabelY=timeLabelY;
    CGSize sourceLabelSize=[status.source sizeWithFont:JYStatusSourceFont];
    _sourceLabelF=(CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
   
    
    //7.微博正文内容
    CGFloat contentLabelX=iconViewX;
    CGFloat contentLabelY= MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF))+JYStatusCellBorder*0.6;
    
    CGFloat contentLabelMaxW=topViewW-2*JYStatusCellBorder;
    CGSize contentLabelSize=[status.text sizeWithFont:JYStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    
   _contentLabelF=(CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    
   //8.配图
    if (status.pic_urls.count)
    {
        //根据图片个数计算整个相册的尺寸
        CGSize photosViewSize=[JYPhotosView photosViewSizeWithPhotosCount:(int)status.pic_urls.count];
        CGFloat photosViewX=contentLabelX;
        CGFloat photosViewY=CGRectGetMaxY(_contentLabelF)+JYStatusCellBorder;
        _photosViewF=CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
        
        
//        CGFloat photoViewWH=70;
//        CGFloat photoViewX=contentLabelX;
//        CGFloat photoViewY=CGRectGetMaxY(_contentLabelF)+JYStatusCellBorder;
//        _photoViewF=CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
        
    }
    
    
    
    
    //9.被转发微博
    if(status.retweeted_status)
    {
        CGFloat retweetViewW=contentLabelMaxW;
        CGFloat retweetViewX=contentLabelX;
        CGFloat retweetViewY=CGRectGetMaxY(_contentLabelF)+JYStatusCellBorder*0.8;
        CGFloat retweetViewH=0;
        
        //10.被转发微博的昵称
        CGFloat retweetNameLabelX=JYStatusCellBorder;
        CGFloat retweetNameLabelY=JYStatusCellBorder*1.5;
        NSString *name=[NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
        CGSize retweetNameLabelSize=[name sizeWithFont:JYRetweetStatusNameFont];
        _retweetNameLabelF=(CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};
        
        //11.被转发微博的正文
        CGFloat retweetContentLabelX=retweetNameLabelX;
        CGFloat retweetContentLabelY=CGRectGetMaxY(_retweetNameLabelF) +JYStatusCellBorder*0.5;
        CGFloat retweetContentLabelMaxW=retweetViewW-2*JYStatusCellBorder;
        CGSize retweetContentLabelSize=[status.retweeted_status.text sizeWithFont:JYRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF=(CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        
        //12.被转发微博的配图
        if(status.retweeted_status.pic_urls.count)
        {
            CGSize retweetPhotosViewSize=[JYPhotosView photosViewSizeWithPhotosCount:(int)status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotosViewX=retweetContentLabelX;
            CGFloat retweetPhotosViewY=CGRectGetMaxY(_retweetContentLabelF)+JYStatusCellBorder;
            
            _retweetPhotosViewF=CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
            
            
//            CGFloat retweetPhotoViewWH=70;
//            CGFloat retweetPhotoViewX=retweetContentLabelX;
//            CGFloat retweetPhotoViewY=CGRectGetMaxY(_retweetContentLabelF)+JYStatusCellBorder;
//            _retweetPhotosViewF=CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
            
            
            retweetViewH=CGRectGetMaxY(_retweetPhotosViewF);
        }
        else
        {
            retweetViewH=CGRectGetMaxY(_retweetContentLabelF);
        }
        
        retweetViewH+=JYStatusCellBorder;
        _retweetViewF=CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        
        //有转发微博时topViewH
        topViewH=CGRectGetMaxY(_retweetViewF);

    }
    else
    {
        //没有转发微博
        if(status.pic_urls.count)
        {
            //有配图
            topViewH=CGRectGetMaxY(_photosViewF);
        }
        else
        {
            //没有配图
            topViewH=CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH+=JYStatusCellBorder;
    _topViewF=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //13.工具条
    
    CGFloat statusToolbarX=topViewX;
    CGFloat statusToolbarY=CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW=topViewW;
    CGFloat statusToolbarH=35;
    _statusToolBarF=CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    //14.cell的高度
    _cellHeight=CGRectGetMaxY(_statusToolBarF)+JYStatusTableBorder;
    
    
}
@end
