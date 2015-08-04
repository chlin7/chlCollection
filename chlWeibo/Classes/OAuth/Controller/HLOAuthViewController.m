//
//  HLOAuthViewController.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/3.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLOAuthViewController.h"

@interface HLOAuthViewController() <UIWebViewDelegate>

@end

@implementation HLOAuthViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //1.0添加webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    //2.0加载授权页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3163859255&redirect_uri="];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    //
    
    //
}

#pragma webview代理方法
/**
 *  当webview发送请求之前调用，询问代理可不可以加载页面
 *
 *  @param webView        <#webView description#>
 *  @param request        <#request description#>
 *  @param navigationType <#navigationType description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.location != NSNotFound) {
        long loc = range.length+range.location;
        [urlStr substringFromIndex:loc];
        //发送POST请求给新浪，获取access token
//        NSURL *
    }
    
    return YES;
}

@end
