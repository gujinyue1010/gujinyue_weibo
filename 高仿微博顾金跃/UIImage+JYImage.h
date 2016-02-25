//
//  UIImage+JYImage.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/14.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JYImage)
+(UIImage *)resizedImageWithName:(NSString *)name;
+(UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
