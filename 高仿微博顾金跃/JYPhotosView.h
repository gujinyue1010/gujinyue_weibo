//
//  JYPhotosView.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/25.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYPhotosView : UIView
/*
  需要展示的图片(数组里封装的JYPhoto模型)
 */
@property(nonatomic,strong)NSArray *photos;

/*
 根据图片的个数返回相册的最终尺寸
 */
+(CGSize)photosViewSizeWithPhotosCount:(int)count;
@end
