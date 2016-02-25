//
//  JYDiscoverViewController.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/13.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYDiscoverViewController.h"
#import "UIImage+JYImage.h"

@interface JYDiscoverViewController ()

@end

@implementation JYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *searchBar=[[UITextField alloc]init];
    //设置背景
    searchBar.background=[UIImage resizedImageWithName:@"searchbar_textfield_background_os7"];
    //尺寸
    searchBar.frame=CGRectMake(0, 0, self.view.frame.size.width*0.95, 30);
    
    //左边的放大镜图标
    UIImageView *iconView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    iconView.frame=CGRectMake(0, 0, 30, 30);
    iconView.contentMode=UIViewContentModeCenter;
    //iconView.backgroundColor=[UIColor greenColor];
    
    searchBar.leftView=iconView;
    searchBar.leftViewMode=UITextFieldViewModeAlways;
    
    //字体
    searchBar.font=[UIFont systemFontOfSize:13];
    //右边的清除按钮
    searchBar.clearButtonMode=UITextFieldViewModeAlways;
    //设置提醒文字
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    searchBar.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"搜索..." attributes:attrs];
    
    
    //设置键盘右下角的样式
    searchBar.returnKeyType=UIReturnKeySearch;
    searchBar.enablesReturnKeyAutomatically=YES;
    
    self.navigationItem.titleView=searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
