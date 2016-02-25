//
//  JYNewFeatureController.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/15.
//  Copyright © 2016年 顾金跃. All rights reserved.
//
#define JYNewFeatureImageCount 3
#import "JYNewFeatureController.h"
#import "JYTabBarViewController.h"

@interface JYNewFeatureController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation JYNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加ScrollView
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    scrollView.frame=self.view.bounds;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    
    //2.添加图片
    CGFloat imageW=scrollView.frame.size.width;
    CGFloat imageH=scrollView.frame.size.height;
    for(int i=0;i<JYNewFeatureImageCount;i++)
    {
        UIImageView *imageView=[[UIImageView alloc]init];
        //设置图片
        NSString *imageName=[NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image=[UIImage imageNamed:imageName];
        
        //设置frame
        CGFloat imageX=i*imageW;
        imageView.frame=CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        //在最后一个图片上添加按钮
        if(i==JYNewFeatureImageCount-1)
        {
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize=CGSizeMake(imageW*JYNewFeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator=NO;
    //强制分页
    scrollView.pagingEnabled=YES;
    //不让ScrollView弹
    scrollView.bounces=NO;
    
    
    //3.添加PageControl
    UIPageControl *pageControl=[[UIPageControl alloc]init];
    pageControl.numberOfPages=JYNewFeatureImageCount;
    pageControl.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-30);
    //设置宽高
    pageControl.bounds=CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled=NO;
    
    //设置圆点的颜色
    pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    pageControl.pageIndicatorTintColor=[UIColor grayColor];
    
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
}
//只要scrollView滚动了,就可以调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.取出水平方向上滚动的距离
    CGFloat offsetX=scrollView.contentOffset.x;
    
    //2.取出页码
    double pageDouble=offsetX/scrollView.frame.size.width;
    int pageInt=(int)(pageDouble+0.5);
    
    self.pageControl.currentPage=pageInt;
}

//添加内容到最后一个按钮
-(void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled=YES;
    //1.添加开始按钮
    UIButton *startButton=[[UIButton alloc]init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    //2.设置frame
    startButton.center=CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height*0.62);
    startButton.bounds=CGRectMake(0, 0, startButton.currentBackgroundImage.size.width, startButton.currentBackgroundImage.size.height);
    [imageView addSubview:startButton];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    
    //3.添加checkbox
    UIButton *checkButton=[[UIButton alloc]init];
    [checkButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    checkButton.selected=YES;
    
    [checkButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    checkButton.bounds=startButton.bounds;
    
    CGFloat checkBoxCenterX=imageView.frame.size.width/2;
    CGFloat checkBoxCenterY=imageView.frame.size.height*0.5;
    checkButton.center=CGPointMake(checkBoxCenterX, checkBoxCenterY);
    
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [imageView addSubview:checkButton];
    [checkButton addTarget:self action:@selector(checkBocClick:) forControlEvents:UIControlEventTouchUpInside];
}

//开始微博
-(void)start
{
    //显示状态栏
    //[UIApplication sharedApplication].statusBarHidden=NO;
    
    JYTabBarViewController *tabBarController=[[JYTabBarViewController alloc]init];
    //切换窗口的根控制器
    self.view.window.rootViewController=tabBarController;
}
-(void)checkBocClick:(UIButton *)checkBox
{
    checkBox.selected=!checkBox.isSelected;
}
-(void)dealloc
{
    NSLog(@"dealloc---");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
