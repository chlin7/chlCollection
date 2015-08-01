//
//  HLNavigationController.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/1.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLNavigationController.h"

@interface HLNavigationController ()

@end

@implementation HLNavigationController

/**
 *第一次使用这个类的时候调用
 */
+(void)initialize{
    //1.设置导航栏主题
    [self setupNavBarTheme];
    //2.设置导航栏按钮主题
    [self setupBarButtongItemTheme];
   
}
/**
 *设置导航栏主题
 */
+(void)setupNavBarTheme{
    //取出appearce对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置背景
    if (!IOS7) {
        [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIScrollViewIndicatorStyleBlack;
    }
    //设置标题属性(颜色、阴影、字体等)
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc] init];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19.0];
    [navBar setTitleTextAttributes:textAttrs];
}
/**
 *设置导航栏按钮的主题
 */
+(void)setupBarButtongItemTheme{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置背景
    if (!IOS7) {
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:(UIControlStateNormal) barMetrics:(UIBarMetricsDefault)];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:(UIControlStateHighlighted) barMetrics:(UIBarMetricsDefault)];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disabled"] forState:(UIControlStateDisabled) barMetrics:(UIBarMetricsDefault)];
        
    }
    
    //设置文字的属性
    //设置标题属性(颜色、阴影、字体等)
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc] init];
    textAttrs[UITextAttributeTextColor] = IOS7?[UIColor orangeColor]:[UIColor grayColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:IOS7?14.0:12.0];
    [item setTitleTextAttributes:textAttrs forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:textAttrs forState:(UIControlStateHighlighted)];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
