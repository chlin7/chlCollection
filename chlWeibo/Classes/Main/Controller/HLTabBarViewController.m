//
//  HLTabBarViewController.m
//  chlWeibo
//
//  Created by chlin7 on 15-6-3.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLTabBarViewController.h"
#import "HLHomeViewController.h"
#import "HLMessageViewController.h"
#import "HLDiscoverViewController.h"
#import "HLMineViewController.h"
#import "HLTabBar.h"

@interface HLTabBarViewController ()<HLTabBarDelegate>
@property(nonatomic,weak) HLTabBar *customTabBar;
@end

@implementation HLTabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //初始化tabbar
    [self setupTabbar];
    //初始化子控制器
    [self setupAllChildViewController];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
/**
 *  初始化所有子控制器
 */
-(void)setupAllChildViewController{
    //初始化子控制器
    HLHomeViewController *home = [[HLHomeViewController alloc] init];
    
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    HLMessageViewController *message = [[HLMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    message.tabBarItem.badgeValue = @"120";
    
    HLDiscoverViewController *discover = [[HLDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    HLMineViewController *me = [[HLMineViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
    
}
/**
 *初始化自定义的tabbar
 */
-(void)setupTabbar{
    HLTabBar *customTabBar = [[HLTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    customTabBar.delegate = self;
    self.customTabBar = customTabBar;

}
/**
 *  初始化tabBar的子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */
-(void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //1.设置控制器属性
    childVc.title = title;
    //设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    //设置选中的图标
    childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //2.包装成导航
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    //添加tabbar
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];

}
/**
 *代理  控制当前选中页面
 */
-(void)tabBar:(HLTabBar *)tabBar didSelectEdButtonFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
