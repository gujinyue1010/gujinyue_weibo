//
//  JYTabBarButton.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/13.
//  Copyright © 2016年 顾金跃. All rights reserved.
//
//图标比例
#define JYTabBarButtonImageRatio 0.6
#import "JYTabBarButton.h"

@interface JYTabBarButton()
//提醒数字按钮
@property(nonatomic,weak)UIButton *badgeButton ;
@end

@implementation JYTabBarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        //按钮选中时候的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider_os7"] forState:UIControlStateSelected];
        
        //按钮的图片居中
        self.imageView.contentMode=UIViewContentModeCenter;
        
        //按钮的文字居中
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        //按钮的文字大小
        self.titleLabel.font=[UIFont systemFontOfSize:12];
        //设置按钮文字的颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:(234/255.0) green:(103/255.0) blue:(7/255.0) alpha:1.0] forState:UIControlStateSelected];
        
        //添加一个提醒数字按钮
        UIButton *badgeButton=[[UIButton alloc]init];
        badgeButton.hidden=YES;
        badgeButton.userInteractionEnabled=YES;
        badgeButton.titleLabel.font=[UIFont systemFontOfSize:8];

        [badgeButton setBackgroundImage:[self resizedImageWithName:@"main_badge_os7"] forState:UIControlStateNormal];
        badgeButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        
        [self addSubview:badgeButton];
        self.badgeButton=badgeButton;
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW=contentRect.size.width;
    CGFloat imageH=contentRect.size.height*JYTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY=contentRect.size.height*JYTabBarButtonImageRatio;
    CGFloat titleW=contentRect.size.width;
    CGFloat titleH=contentRect.size.height-titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setItem:(UITabBarItem *)item
{
    _item=item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    //设置提醒数字
    if(self.item.badgeValue)
    {
        self.badgeButton.hidden=NO;
        //设置文字
        [self.badgeButton setTitle:self.item.badgeValue forState:UIControlStateNormal];
        
        CGFloat badgeY=0;
        CGFloat badgeH=self.badgeButton.currentBackgroundImage.size.height;
        CGFloat badgeW=self.badgeButton.currentBackgroundImage.size.width;
        //文字的尺寸
        if(self.item.badgeValue.length>1)
        {
            CGSize badgeSize=[self.item.badgeValue sizeWithFont:self.badgeButton.titleLabel.font];
            CGFloat badgeW=badgeSize.width+10;
        }
        
        CGFloat badgeX=self.frame.size.width-badgeW-10;
        
        
        self.badgeButton.frame=CGRectMake(badgeX, badgeY, badgeW, badgeH);
    }
    else
    {
        
    }

    
    //KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
}

//监听到某个对象的属性改变了就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@ %@",object,keyPath);
   
    
    //设置提醒数字
    if(self.item.badgeValue)
    {
        self.badgeButton.hidden=NO;
        //设置文字
        [self.badgeButton setTitle:self.item.badgeValue forState:UIControlStateNormal];
        
        CGFloat badgeY=0;
        CGFloat badgeH=self.badgeButton.currentBackgroundImage.size.height;
        CGFloat badgeW=self.badgeButton.currentBackgroundImage.size.width;
        //文字的尺寸
        if(self.item.badgeValue.length>1)
        {
            CGSize badgeSize=[self.item.badgeValue sizeWithFont:self.badgeButton.titleLabel.font];
            CGFloat badgeW=badgeSize.width+10;
        }
        
        CGFloat badgeX=self.frame.size.width-badgeW-10;
        
        
        self.badgeButton.frame=CGRectMake(badgeX, badgeY, badgeW, badgeH);
    }
    else
    {
        
    }

}

-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}
//返回一张自由拉伸的图片
-(UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image=[UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}
//按钮取消高亮效果
-(void)setHighlighted:(BOOL)highlighted
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
