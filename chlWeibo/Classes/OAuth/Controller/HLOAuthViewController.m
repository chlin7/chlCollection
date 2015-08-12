//
//  HLOAuthViewController.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/3.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLOAuthViewController.h"
#import "HLAccount.h"
#import "HLTabBarViewController.h"
#import "HLNewfeatureController.h"
#import "HLWeiboTool.h"
#import "HLAccountTool.h"
#import "MBProgressHUD.h"

@interface HLOAuthViewController() <UIWebViewDelegate>

@end

#define oAuthUrl @"https://api.weibo.com/oauth2/authorize"
#define getTokenUrl @"https://api.weibo.com/oauth2/access_token"
#define clientId @"3163859255"
#define clientSecret @"ec055098e0d3a717e18643b45cfbe8d9"
#define grantType @"authorization_code"
#define redirectUri @"http://www.baidu.com"

@implementation HLOAuthViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //1.0添加webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    //2.0加载授权页面
    NSString *strUrl = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",oAuthUrl,clientId,redirectUri];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
   
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    //显示进度
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //关闭进度
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //关闭进度
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma webview代理方法
/**
 *  当webview发送请求之前调用，询问代理可不可以加载页面
 *
 *  @param webView
 *  @param request
 *  @param navigationType
 *
 *  @return
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.location != NSNotFound) {
        long loc = range.length+range.location;
        NSString *codeStr = [urlStr substringFromIndex:loc];
        //发送POST请求给新浪，获取access token
        [self accessTokenWithCode:codeStr];
    }
    
    return YES;
}
/**
 *  通过code获取accessToken
 *
 *  @param code
 */
-(void)accessTokenWithCode:(NSString *)code{
    //1.0 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //返回的json数据
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //2.0 封装请求对象
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:clientId forKey:@"client_id"];
    [params setObject:clientSecret forKey:@"client_secret"];
    [params setObject:grantType forKey:@"grant_type"];
    [params setObject:code forKey:@"code"];
    [params setObject:redirectUri forKey:@"redirect_uri"];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //3.0 发送请求
    [mgr POST:getTokenUrl parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
        //4.0 字典存储为模型
        HLAccount *account = [HLAccount accountWithDict:responseObject];
        //5.0 存储数据模型
        [HLAccountTool saveAccount:account];
        //6.0 选择根控制器
        [HLWeiboTool chooseRootController];
        
        //关闭进度
        [MBProgressHUD hideHUDForView:self.view animated:YES];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DEBUGLog(@"++++++++++++++++++");
    }];
    
}

@end
