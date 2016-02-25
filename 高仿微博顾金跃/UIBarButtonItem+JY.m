//
//  UIBarButtonItem+JY.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/14.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "UIBarButtonItem+JY.h"

@implementation UIBarButtonItem (JY)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    button.frame=CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
