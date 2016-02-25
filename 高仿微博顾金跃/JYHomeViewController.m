//
//  JYHomeViewController.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/13.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYHomeViewController.h"
#import "UIBarButtonItem+JY.h"
#import "UIImage+JYImage.h"
#import "JYTitleButton.h"
#import "AFNetworking.h"
#import "JYAccountTool.h"
#import "UIImageView+WebCache.h"
#import "JYStatus.h"
#import "JYUser.h"
#import "MJExtension.h"
#import "JYStatusFrame.h"
#import "JYStatusCell.h"
#import "MJRefresh.h"

@interface JYHomeViewController ()<MJRefreshBaseViewDelegate>
@property(nonatomic,strong)NSMutableArray *statusFrames;
@property(nonatomic,weak)MJRefreshFooterView *footer;
@property(nonatomic,weak)MJRefreshHeaderView *header;
@end

@implementation JYHomeViewController

-(NSMutableArray *)statusFrames
{
    if(_statusFrames==nil)
    {
        _statusFrames=[NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0.集成刷新控件
    [self setupRefreshView];
    
    //1.设置导航栏
    [self setupNavBar];
    
    //2.加载微博数据
    //[self setupStatusData];
    
}

-(void)titleClick:(JYTitleButton *)button
{
    if(button.tag==-1)
    {
        [button setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        button.tag=0;
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        button.tag=-1;
    }
    
}
-(void)findFriend
{
    NSLog(@"findFriend");
}
-(void)pop
{
    NSLog(@"pop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    JYStatusCell *cell=[JYStatusCell cellWithTableView:tableView];
    
    //2.传递模型
    cell.statusFrame=self.statusFrames[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc=[[UIViewController alloc]init];
    vc.view.backgroundColor=[UIColor greenColor];
    //vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYStatusFrame *statusFrame=self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}


-(void)setupRefreshView
{
//    //1.下拉刷新
//    UIRefreshControl *refreshControl=[[UIRefreshControl alloc]init];
//    //监听刷新控件的状态改变
//    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refreshControl];
//    
//    //自动进入刷新状态
//    [refreshControl beginRefreshing];
//    
//    //直接加载数据
//    [self refreshControlStateChange:refreshControl];
    
    //1.下拉刷新
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.tableView;
    header.delegate=self;
    self.header=header;
    [header beginRefreshing];
    
    //2.上拉刷新
    MJRefreshFooterView *footer=[MJRefreshFooterView footer];
    footer.scrollView=self.tableView;
    footer.delegate=self;
    self.footer=footer;
}

-(void)dealloc
{
    [self.footer free];
    [self.header free];
}
//刷新控件开始刷新状态的时候调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if([refreshView isKindOfClass:[MJRefreshHeaderView class]])
    {
        //下拉刷新
        [self loadNewData];
    }
    else
    {
        //上拉加载
        [self loadMoreData];
    }
}
-(void)loadNewData
{
    //刷新数据(向新浪获取更新数据)
    //1.创建请求管理对象
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    //2.说明服务器返回的是json数据
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    //3.封装请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=[JYAccountTool account].access_token;
    params[@"count"]=@10;
    
    //返回id比since_id大的微博
    if(self.statusFrames.count)
    {
        JYStatusFrame *statusFrame=self.statusFrames[0];
        params[@"since_id"]=statusFrame.status.idstr;
    }
    
    //4.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //将字典数组转为模型数组(里面放的就是JYStatus模型)
         NSArray *statusArray=[JYStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         
         //创建frame模型对象
         NSMutableArray *statusFrameArray=[NSMutableArray array];
         for(JYStatus *status in statusArray)
         {
             JYStatusFrame *statusFrame=[[JYStatusFrame alloc]init];
             //传递微博模型数据
             statusFrame.status=status;
             [statusFrameArray addObject:statusFrame];
         }
         
         //将最新数据追加到旧数据的前面
         
         NSMutableArray *tempArray=[NSMutableArray array];
         [tempArray addObjectsFromArray:statusFrameArray];
         [tempArray addObjectsFromArray:self.statusFrames];
         self.statusFrames=tempArray;
         
         
         //刷新表格
         [self.tableView reloadData];
         
         //让刷新控件停止显示刷新状态
         [self.header endRefreshing];
         
         //显示最新微博的数量(给用户一些友善的提示)
         [self showNewStatusCount:(int)statusFrameArray.count];
         
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.header endRefreshing];
     }];
}
-(void)loadMoreData
{
    //发送请求加载更多的数据
    //1.创建请求管理对象
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    //2.说明服务器返回的是json数据
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    //3.封装请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=[JYAccountTool account].access_token;
    params[@"count"]=@5;
    
    //返回id比max_id小的微博
    if(self.statusFrames.count)
    {
        JYStatusFrame *statusFrame=[self.statusFrames lastObject];
        long long maxId=[statusFrame.status.idstr longLongValue]-1;
        params[@"max_id"]=@(maxId);
    }
    
    //4.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //将字典数组转为模型数组(里面放的就是JYStatus模型)
         NSArray *statusArray=[JYStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         //创建frame模型对象
         NSMutableArray *statusFrameArray=[NSMutableArray array];
         for(JYStatus *status in statusArray)
         {
             JYStatusFrame *statusFrame=[[JYStatusFrame alloc]init];
             //传递微博模型数据
             statusFrame.status=status;
             [statusFrameArray addObject:statusFrame];
         }
         
         //添加新数据到旧数据的后面
         [self.statusFrames addObjectsFromArray:statusFrameArray];
         
         //刷新表格
         [self.tableView reloadData];
         
         [self.footer endRefreshing];
         
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.footer endRefreshing];
     }];
    

}
//-(void)refreshControlStateChange:(UIRefreshControl *)refreshControl
//{
//    //刷新数据(向新浪获取更新数据)
//    //1.创建请求管理对象
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    
//    //2.说明服务器返回的是json数据
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    
//    //3.封装请求参数
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"access_token"]=[JYAccountTool account].access_token;
//    params[@"count"]=@10;
//    
//    //返回id比since_id大的微博
//    if(self.statusFrames.count)
//    {
//        JYStatusFrame *statusFrame=self.statusFrames[0];
//        params[@"since_id"]=statusFrame.status.idstr;
//    }
//
//    //4.发送请求
//    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//        //将字典数组转为模型数组(里面放的就是JYStatus模型)
//         NSArray *statusArray=[JYStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//         
//         
//         //创建frame模型对象
//         NSMutableArray *statusFrameArray=[NSMutableArray array];
//         for(JYStatus *status in statusArray)
//         {
//             JYStatusFrame *statusFrame=[[JYStatusFrame alloc]init];
//             //传递微博模型数据
//             statusFrame.status=status;
//             [statusFrameArray addObject:statusFrame];
//         }
//         
//         //将最新数据追加到旧数据的前面
//         
//         NSMutableArray *tempArray=[NSMutableArray array];
//         [tempArray addObjectsFromArray:statusFrameArray];
//         [tempArray addObjectsFromArray:self.statusFrames];
//         self.statusFrames=tempArray;
//         
//         
//         //刷新表格
//         [self.tableView reloadData];
//         
//         //让刷新控件停止显示刷新状态
//         [refreshControl endRefreshing];
//         
//         //显示最新微博的数量(给用户一些友善的提示)
//         [self showNewStatusCount:(int)statusFrameArray.count];
//         
//     }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         [refreshControl endRefreshing];
//     }];
//}

-(void)showNewStatusCount:(int)count
{
    //1.创建一个按钮
    UIButton *btn=[[UIButton alloc]init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    //2.设置图片和文字
    btn.userInteractionEnabled=NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    if(count)
    {
        NSString *title=[NSString stringWithFormat:@"共有%d条新的微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    
    //3.设置按钮的初始frame
    CGFloat btnH=30;
    CGFloat btnY=64-btnH;
    CGFloat btnX=2;
    CGFloat btnW=self.view.frame.size.width-2*btnX;
    btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    
    //4.通过动画移动按钮
    [UIView animateWithDuration:1.0 animations:^{
        btn.transform=CGAffineTransformMakeTranslation(0, btnH+2);
    }completion:^(BOOL finished) {
        //向下移动的动画执行完毕后
        [UIView animateWithDuration:0.8 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
    
}
-(void)setupNavBar
{
    //1.左边按钮
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch_os7" highIcon:@"navigationbar_friendsearch_highlighted_os7" target:self action:@selector(findFriend)];
    
    //2.右边按钮
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithIcon:@"navigationbar_pop_os7" highIcon:@"navigationbar_pop_highlighted_os7" target:self action:@selector(pop)];
    
    
    //3.中间按钮
    JYTitleButton *titleButton=[[JYTitleButton alloc]init];
    //图标
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //文字
    [titleButton setTitle:@"顾金跃微博" forState:UIControlStateNormal];
    //尺寸
    titleButton.frame=CGRectMake(0, 0, 120, 35);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=titleButton;
    
    self.tableView.backgroundColor=[UIColor colorWithRed:(226/255.0f) green:(226/255.0f) blue:(226/255.0f) alpha:1.0f];
    
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, JYStatusTableBorder, 0);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

}

//-(void)setupStatusData
//{
//    //1.创建请求管理对象
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    
//    //2.说明服务器返回的是json数据
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    
//    //3.封装请求参数
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"access_token"]=[JYAccountTool account].access_token;
//    params[@"count"]=@"5";
//    
//    //4.发送请求
//    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
////        // NSLog(@"===%@",responseObject[@"statuses"]);
////         
////         //1.取出所有的微博数据(每一条微博数据都是字典)
////         NSArray *dictArray=responseObject[@"statuses"];
////         
////         //2.字典转模型
////         NSMutableArray *statusArray=[NSMutableArray array];
////         
////         for(NSDictionary *dict in dictArray)
////         {
////             //3.创建模型
////             //JYStatus *status=[JYStatus statusWithDict:dict];
////             JYStatus *status=[JYStatus objectWithKeyValues:dict];
////             
////             //4.添加模型
////             [statusArray addObject:status];
////         }
////         
////         self.statuses=statusArray;
//         
//         //将字典数组转为模型数组(里面放的就是JYStatus模型)
//         NSArray *statusArray=[JYStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//         
//         
//         //创建frame模型对象
//         NSMutableArray *statusFrameArray=[NSMutableArray array];
//         for(JYStatus *status in statusArray)
//         {
//             JYStatusFrame *statusFrame=[[JYStatusFrame alloc]init];
//             //传递微博模型数据
//             statusFrame.status=status;
//             [statusFrameArray addObject:statusFrame];
//         }
//         self.statusFrames=statusFrameArray;
//         //刷新表格
//         [self.tableView reloadData];
//     }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//        
//    }];
//    
//}
@end
