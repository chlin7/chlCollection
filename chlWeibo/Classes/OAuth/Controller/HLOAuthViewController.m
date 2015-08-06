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

@interface HLOAuthViewController() <UIWebViewDelegate>

@end

@implementation HLOAuthViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //1.0添加webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    //2.0加载授权页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1359433872&redirect_uri=http://ios.itcast.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    //
    
    //
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
    
    //2.0 封装请求对象
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1359433872" forKey:@"client_id"];
    [params setObject:@"37c372aa97a9329fc561947151c1bd38" forKey:@"client_secret"];
    [params setObject:@"authorization_code" forKey:@"grant_type"];
    [params setObject:code forKey:@"code"];
    [params setObject:@"http://ios.itcast.cn" forKey:@"redirect_uri"];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //3.0 发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
        //4.0 字典存储为模型
        HLAccount *account = [HLAccount accountWithDict:responseObject];
        //5.0 存储数据模型
        NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingString:@"account.data"];
        [NSKeyedArchiver archiveRootObject:account toFile:file];
        
        //6.0 登录成功后有可能跳转到首页或者新特性 界面
        NSString *versionKey = @"CFBundleVersion";
        //取出沙盒中存取的版本号
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *lastVersion = [userDefault stringForKey:versionKey];
        //获取当前的版本号(plists文件中)
        NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:versionKey];
        
        if ([currentVersion isEqualToString:lastVersion]) {
            //显示状态栏
            [UIApplication sharedApplication].statusBarHidden = NO;
            self.view.window.rootViewController = [[HLTabBarViewController alloc] init];
        }else{//新版本更新
            self.view.window.rootViewController = [[HLNewfeatureController alloc] init];
            //存储新的版本号
            [userDefault setObject:currentVersion forKey:versionKey];
            [userDefault synchronize];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DEBUGLog(@"++++++++++++++++++");
    }];
    
}

@end
