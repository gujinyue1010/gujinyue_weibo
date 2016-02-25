//
//  JYPhotoView.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/25.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYPhotoView.h"
#import "JYPhoto.h"
#import "UIImageView+WebCache.h"


@interface JYPhotoView()
@property(nonatomic,weak)UIImageView *gifView;
@end

@implementation JYPhotoView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        //添加一个GIF小图片
        UIImage *image=[UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView=[[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        
        self.gifView=gifView;
    }
    return self;
}

-(void)setPhoto:(JYPhoto *)photo
{
    _photo=photo;
    
    // 控制gifView的可见性
    self.gifView.hidden=![photo.thumbnail_pic hasPrefix:@"gif"];
    
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint=CGPointMake(1, 1);
    self.gifView.layer.position=CGPointMake(self.frame.size.width, self.frame.size.height);
}
@end
