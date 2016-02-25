//
//  JYTabBar.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/13.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYTabBar.h"
#import "JYTabBarButton.h"

@interface JYTabBar()

@property(nonatomic,weak)JYTabBarButton *selectedButton;
@property(nonatomic,weak)UIButton *plusButton;

@property(nonatomic,strong)NSMutableArray *tabbarButtons;

@end

@implementation JYTabBar

//懒加载
-(NSMutableArray *)tabbarButtons
{
    if(_tabbarButtons==nil)
    {
        _tabbarButtons=[NSMutableArray array];
    }
    return _tabbarButtons;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
//        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background_os7"]];
        
        //添加一个加号按钮
        UIButton *plusButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds=CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        self.plusButton=plusButton;
        
    }
    return self;
}

-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1.创建按钮
    JYTabBarButton *button=[[JYTabBarButton alloc]init];
    [self addSubview:button];
    
    //5.添加按钮到数组中
    [self.tabbarButtons addObject:button];
    
    //2.设置数据
//    [button setTitle:item.title forState:UIControlStateNormal];
//    [button setImage:item.image forState:UIControlStateNormal];
//    [button setImage:item.selectedImage forState:UIControlStateSelected];
//    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_slider_os7"] forState:UIControlStateSelected];
     button.item=item;
    
    //3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //4.默认选中第0个按钮
    if(self.tabbarButtons.count==1)
    {
        [self buttonClick:button];
    }
    
    
}

-(void)buttonClick:(JYTabBarButton *)button
{
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)])
    {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    self.selectedButton.selected=NO;
    button.selected=YES;
    self.selectedButton=button;
}

//专门用来设置尺寸
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整加号按钮的frame
    CGFloat h=self.frame.size.height;
    CGFloat w=self.frame.size.width;
    self.plusButton.center=CGPointMake(w*0.5, h*0.5);
    
    
    CGFloat buttonY=0;
    CGFloat buttonW=w/self.subviews.count;
    CGFloat buttonH=h;
    for(int index=0;index<self.tabbarButtons.count;index++)
    {
        //1.取出按钮
        UIButton *button=self.tabbarButtons[index];
        
        //2.设置frame
        CGFloat buttonX=index*buttonW;
        if(index>1)
        {
            buttonX+=buttonW;
        }
        button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //3.绑定tag
        button.tag=index;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
