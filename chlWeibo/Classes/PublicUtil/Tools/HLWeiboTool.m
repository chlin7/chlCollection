//
//  HLWeiboTool.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/6.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLWeiboTool.h"
#import "HLNewfeatureController.h"
#import "HLTabBarViewController.h"

@implementation HLWeiboTool

+(void)chooseRootController{
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
        [UIApplication sharedApplication].keyWindow.rootViewController = [[HLTabBarViewController alloc] init];
    }else{//新版本更新
        [UIApplication sharedApplication].keyWindow.rootViewController = [[HLNewfeatureController alloc] init];
        //存储新的版本号
        [userDefault setObject:currentVersion forKey:versionKey];
        [userDefault synchronize];
    }
}

@end
