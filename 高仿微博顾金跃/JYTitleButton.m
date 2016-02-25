//
//  JYTitleButton.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/15.
//  Copyright © 2016年 顾金跃. All rights reserved.
//
#define JYTitleButtonImageW 25
#import "JYTitleButton.h"
#import "UIImage+JYImage.h"

@implementation JYTitleButton
+(instancetype)titleButton
{
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
         //高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted=NO;
        //图片居中
        self.imageView.contentMode=UIViewContentModeCenter;
        
        self.titleLabel.textAlignment=UITextAlignmentRight;
        self.titleLabel.font=[UIFont systemFontOfSize:16];
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted_os7"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}
//处理图标位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY=0;
    CGFloat imageW=JYTitleButtonImageW;
    CGFloat imageX=contentRect.size.width-imageW;
    CGFloat imageH=contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
//处理文字位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX=0;
    CGFloat titleY=0;
    CGFloat titleW=contentRect.size.width-JYTitleButtonImageW;
    CGFloat titleH=contentRect.size.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
