//
//  JYOAuthViewController.m
//  高仿微博顾金跃
//
//  Created by 顾金跃 on 16/2/15.
//  Copyright © 2016年 顾金跃. All rights reserved.
//

#import "JYOAuthViewController.h"
#import "AFNetworking.h"
#import "JYAccount.h"
#import "JYTabBarViewController.h"
#import "JYNewFeatureController.h"
#import "JYWeiBoTool.h"
#import "JYAccountTool.h"
#import "MBProgressHUD+MJ.h"
@interface JYOAuthViewController ()<UIWebViewDelegate>

@end

@implementation JYOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加webView
    UIWebView *webView=[[UIWebView alloc]init];
    webView.frame=self.view.bounds;
    webView.delegate=self;
    [self.view addSubview:webView];
    
    //2.加载授权页面
    NSURL *url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=62846697&redirect_uri=http://www.163.com"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

//1.当webView发送一个请求之前都会先调用这个方法,询问代理
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   // NSLog(@"可以加载吗？：%@",request.URL);
    //1.请求的url路径
    NSString *urlStr=request.URL.absoluteString;
    
    //2.查找code＝在urlStr中的范围
    NSRange range=[urlStr rangeOfString:@"code="];
    if(range.location!=NSNotFound)
    {
       // NSLog(@"找到了%@",urlStr);
        //3.截取code＝后面的请求标记(经过用户授权成功的)
        int loc=(int)(range.location+range.length);
        NSString *code=[urlStr substringFromIndex:loc];
        //NSLog(@"code=%@",code);
        
        //4.发送POST请求给新浪,通过code换取一个accessToken
        //1.创建请求管理类
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        //2.封装请求参数
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"client_id"]=@"62846697";
        params[@"client_secret"]=@"f408b282e0856ad55936724aac17d56a";
        params[@"grant_type"]=@"authorization_code";
        params[@"code"]=code;
        params[@"redirect_uri"]=@"http://www.163.com";
        //3.发送请求
        [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSLog(@"返回成功%@",responseObject);
            //4.存储模型数据
            JYAccount *jyAccount=[JYAccount accountWithDict:responseObject];
            
            [JYAccountTool saveAccount:jyAccount];
            
            //6.登录成功后，可能去新特性，可能直接去主页
            [JYWeiBoTool chooseRootController];
            
            //7.去掉隐藏
           [MBProgressHUD hideHUD];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"failure:%@",error);
            [MBProgressHUD hideHUD];
        }];
        
        return NO;
        
    }
    return  YES;
}

//webView开始发送请求的时候
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //显示提醒狂
    [MBProgressHUD showMessage:@"正在加载"];
}

//webView加载完毕的时候
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //加载提醒框
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
