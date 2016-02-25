//
//  JYTabBarViewController.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/13.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYTabBarViewController.h"
#import "JYHomeViewController.h"
#import "JYMessageViewController.h"
#import "JYDiscoverViewController.h"
#import "JYMeViewController.h"
#import "JYTabBar.h"
#import "JYNavigationController.h"

@interface JYTabBarViewController ()<JYTabBarDelegate>
//自定义的tabbar
@property(nonatomic,weak)JYTabBar *customTabBar;
@end

@implementation JYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //初始化所有的子控制器
//    //1.首页
//    JYHomeViewController *home=[[JYHomeViewController alloc]init];
//    home.view.backgroundColor=[UIColor greenColor];
//    
//    //home.tabBarItem.title=@"首页";
//    //home.navigationItem.title=@"首页";
//    home.title=@"首页";
//    home.tabBarItem.image=[UIImage imageNamed:@"tabbar_home"];
//    //对于选中的图片,系统默认会渲染成蓝色,通过设置渲染模式可以使其保持原色而不渲染
//    home.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_home_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UINavigationController *homeNav=[[UINavigationController alloc]initWithRootViewController:home];
//    [self addChildViewController:homeNav];
//    
//    
//    
//    //2.消息
//    JYMessageViewController *message=[[JYMessageViewController alloc]init];
//    message.view.backgroundColor=[UIColor blueColor];
//    
//    //message.tabBarItem.title=@"消息";
//    //message.navigationItem.title=@"消息";
//    message.title=@"消息";
//    message.tabBarItem.image=[UIImage imageNamed:@"tabbar_message_center"];
//    message.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_message_center_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UINavigationController *messageNav=[[UINavigationController alloc]initWithRootViewController:message];
//    [self addChildViewController:messageNav];
//    
//    
//    
//    //3.广场
//    JYDiscoverViewController *discover=[[JYDiscoverViewController alloc]init];
//    discover.view.backgroundColor=[UIColor orangeColor];
//    
//    //discover.tabBarItem.title=@" 广场";
//    //discover.navigationItem.title=@"广场";
//    discover.title=@"广场";
//    discover.tabBarItem.image=[UIImage imageNamed:@"tabbar_discover"];
//    discover.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_discover_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UINavigationController *discoverNav=[[UINavigationController alloc]initWithRootViewController:discover];
//    [self addChildViewController:discoverNav];
//    
//    
//    
//    //4.我
//    JYMeViewController *me=[[JYMeViewController alloc]init];
//    me.view.backgroundColor=[UIColor whiteColor];
//    
//    //me.tabBarItem.title=@"我";
//    //me.navigationItem.title=@"我";
//    me.title=@"我";
//    me.tabBarItem.image=[UIImage imageNamed:@"tabbar_profile"];
//    me.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_profile_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UINavigationController *meNav=[[UINavigationController alloc]initWithRootViewController:me];
//    [self addChildViewController:meNav];
    
    
    //1.初始化tabbar
    [self setupTabbar];
    
    //2.初始化所有的子控制器
    [self setupAllChildControllers];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //NSLog(@"%@",self.tabBar.subviews);
    
    for(UIView *view in self.tabBar.subviews)
    {
       // NSLog(@"%@",view.superclass);
        if([view isKindOfClass:[UIControl class]])
        {
            [view removeFromSuperview];
        }
    }
}

-(void)setupAllChildControllers
{
    //1.首页
    JYHomeViewController *home=[[JYHomeViewController alloc]init];
    home.tabBarItem.badgeValue=@"...";
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home_os7" selectedImageName:@"tabbar_home_selected_os7"];
    
    //2.消息
    JYMessageViewController *message=[[JYMessageViewController alloc]init];
    message.tabBarItem.badgeValue=@"8";
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center_os7" selectedImageName:@"tabbar_message_center_selected_os7"];
    
    //3.广场
    JYDiscoverViewController *discover=[[JYDiscoverViewController alloc]init];
    //discover.tabBarItem.badgeValue=@"new";
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover_os7" selectedImageName:@"tabbar_discover_selected_os7"];
    
    //4.我
    JYMeViewController *me=[[JYMeViewController alloc]init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile_os7" selectedImageName:@"tabbar_profile_selected_os7"];

}

-(void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //1.控制器属性
    childVc.title=title;
    //2.设置图标
    childVc.tabBarItem.image=[UIImage imageNamed:imageName];
    //3.设置选中的图标
    //对于选中的图片,系统默认会渲染成蓝色,通过设置渲染模式可以使其保持原色而不渲染
    childVc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //4.包装一个导航控制器
    JYNavigationController *nav=[[JYNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    //5.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

-(void)setupTabbar
{
    //自定义的tabbar完全覆盖系统的tabbar
    JYTabBar *customTabbar=[[JYTabBar alloc]init];
    //customTabbar.backgroundColor=[UIColor greenColor];
    customTabbar.frame=self.tabBar.bounds;
    customTabbar.delegate=self;
    
    [self.tabBar addSubview:customTabbar];
    self.customTabBar=customTabbar;
}

//实现代理
-(void)tabBar:(JYTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex=to;
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
