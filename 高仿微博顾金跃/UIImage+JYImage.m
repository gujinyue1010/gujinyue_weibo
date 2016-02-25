//
//  UIImage+JYImage.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/14.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "UIImage+JYImage.h"

@implementation UIImage (JYImage)
+(UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image=[UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

+(UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image=[UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}
@end
