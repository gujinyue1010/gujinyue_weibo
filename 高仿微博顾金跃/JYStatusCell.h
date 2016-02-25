//
//  JYStatusCell.h
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/17.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYStatusFrame;
@interface JYStatusCell : UITableViewCell
@property(nonatomic,strong)JYStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
