//
//  JYPhotosView.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/25.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYPhotosView.h"
#import "JYPhoto.h"
#import "JYPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define JYPhotoW 75
#define JYPhotoH 75

#define JYPhotoMargin 6

@implementation JYPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self=[super initWithFrame:frame];
    if(self)
    {
        //初始化9个子控件
        for(int i=0;i<9;i++)
        {
            JYPhotoView *photoView=[[JYPhotoView alloc]init];
            photoView.userInteractionEnabled=YES;
            photoView.tag=i;
            
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTap:)]];
            
            [self addSubview:photoView];
        }
    }
    return self;
}


-(void)photoTap:(UITapGestureRecognizer *)recognizer
{
    int count =(int)self.photos.count;
    
    //1.封装图片数据
    NSMutableArray *myphotos=[NSMutableArray arrayWithCapacity:count];
    for (int i=0; i<count; i++)
    {
        //一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto=[[MJPhoto alloc]init];
        
        mjphoto.srcImageView=self.subviews[i];//来源于哪个UIImageView
        
        JYPhoto *jyphoto=self.photos[i];
        NSString *photoUrl=[jyphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        mjphoto.url=[NSURL URLWithString:photoUrl];//图片路径
        [myphotos addObject:mjphoto];
        
    }
    
    //2.显示相册
    MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
    browser.currentPhotoIndex=recognizer.view.tag;//弹出相册时显示的第一张图片是？
    browser.photos=myphotos;//设置所有的图片
    [browser show];
    
}

-(void)setPhotos:(NSArray *)photos
{
    _photos=photos;
    for(int i=0;i<self.subviews.count;i++)
    {
        //取出i位置对应的UIImageView
        JYPhotoView *photoView=self.subviews[i];
        
        //判断这个imageView是否需要显示数据
        if(i<photos.count)
        {
            //显示图片
            photoView.hidden=NO;
            
            // 传递模型数据
            photoView.photo=photos[i];
            
            //设置子控件的frame
            int maxColums=(photos.count==4)?2:3;
            int col=i%maxColums;
            int row=i/maxColums;
            
            CGFloat photoX=col*(JYPhotoW+JYPhotoMargin);
            CGFloat photoY=row*(JYPhotoH+JYPhotoMargin);
            
            photoView.frame=CGRectMake(photoX, photoY, JYPhotoW, JYPhotoH);
            
            if(photos.count==1)
            {
                //按照图片的原来宽高比进行缩放(一定要看到整张图片)
                photoView.contentMode=UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds=NO;
            }
            else
            {
                //按照图片的原来宽高比进行缩放(只能图片最中间的内容)
                photoView.contentMode=UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds=YES;
            }
        }
        else
        {
            //隐藏imageView
            photoView.hidden=YES;
        }
    }
}

+(CGSize)photosViewSizeWithPhotosCount:(int)count
{
    //一行最多有3列
    int maxColumns=(count==4)?2:3;
    
    //总行数
    int rows=(count+maxColumns-1)/maxColumns;
    
    //高度
    CGFloat photosH=rows*JYPhotoH+(rows-1)*JYPhotoMargin;
    
    //总列数
    int cols=(count>=maxColumns)?maxColumns:count;
    
    //宽度
    CGFloat photosW=cols*JYPhotoW+(cols-1)*JYPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
