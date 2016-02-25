//
//  JYStatusToolBar.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/25.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYStatusToolBar.h"
#import "UIImage+JYImage.h"
#import "JYStatus.h"

@interface JYStatusToolBar()
@property(nonatomic,strong)NSMutableArray *btns;
@property(nonatomic,strong)NSMutableArray *dividers;

@property(nonatomic,weak)UIButton *reweetBtn;
@property(nonatomic,weak)UIButton *commentBtn;
@property(nonatomic,weak)UIButton *attitudeBtn;

@end

@implementation JYStatusToolBar

-(NSMutableArray *)btns
{
    if(_btns==nil)
    {
        _btns=[NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dividers
{
    if(_dividers==nil)
    {
        _dividers=[NSMutableArray array];
    }
    return  _dividers;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled=YES;
        //1.设置图片
        self.image=[UIImage resizedImageWithName:@"timeline_card_bottom_background_os7"];
        self.highlightedImage=[UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted_os7"];
        
        //2.添加按钮
        self.reweetBtn=[self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet_os7" bgImage:@"timeline_card_leftbottom_highlighted_os7"];
        self.commentBtn= [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment_os7" bgImage:@"timeline_card_middlebottom_highlighted_os7"];
        self.attitudeBtn=[self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike_os7" bgImage:@"timeline_card_rightbottom_highlighted_os7"];
        
        //3.添加分割线
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}

/*
 初始化按钮
 */
-(UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn=[[UIButton alloc]init];
    btn.adjustsImageWhenHighlighted=NO;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    
    //添加按钮到数组
    [self.btns addObject:btn];
    
    return btn;
}

/*
 初始化分割线
 */
-(void)setupDivider
{
    UIImageView *divider=[[UIImageView alloc]init];
    divider.image=[UIImage resizedImageWithName:@"timeline_card_bottom_line_os7"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //分割线的宽度
     CGFloat dividerW=2;
    //分割线的个数
    int dividerCount=(int)self.dividers.count;
    
    //1.设置按钮的frame
    CGFloat btnW=(self.frame.size.width-dividerW*dividerCount)/self.btns.count;
    CGFloat btnH=self.frame.size.height;
    CGFloat btnY=0;
    
    for (int i=0; i<self.btns.count; i++)
    {
        UIButton *btn=self.btns[i];
        CGFloat btnX=i*(btnW+dividerW);
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        
    }
    
    //2.设置分割线的frame
    CGFloat dividerH=btnH;
   
    CGFloat dividerY=0;
    for (int j=0; j<dividerCount; j++)
    {
        UIImageView *imageView=self.dividers[j];
        UIButton *btn=self.btns[j];
        CGFloat dividerX=CGRectGetMaxX(btn.frame);
        imageView.frame=CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

-(void)setStatus:(JYStatus *)status
{
    _status=status;
    //1.设置转发数
    if(status.reposts_count)
    {
        NSString *title=[NSString stringWithFormat:@"%d",status.reposts_count];
        [self.reweetBtn setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [self.reweetBtn setTitle:@"转发" forState:UIControlStateNormal];
    }
    
    if(status.comments_count)
    {
        NSString *title=[NSString stringWithFormat:@"%d",status.comments_count];
        [self.commentBtn setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    }
    
    if(status.attitudes_count)
    {
        NSString *title=[NSString stringWithFormat:@"%d",status.attitudes_count];
        [self.attitudeBtn setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [self.attitudeBtn setTitle:@"赞" forState:UIControlStateNormal];
    }
}
@end
