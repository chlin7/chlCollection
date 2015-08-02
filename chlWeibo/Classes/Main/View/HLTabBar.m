//
//  HLTabBar.m
//  chlWeibo
//
//  Created by chlin7 on 15-6-6.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLTabBar.h"
#import "HLTabBarItem.h"

@interface HLTabBar()

@property(nonatomic,strong) NSMutableArray *tabBarButtons;

@property(nonatomic,weak) HLTabBarItem *currentSelectedBtn;

@property(nonatomic,weak) UIButton *plushBtn;

@end

@implementation HLTabBar

//懒加载
-(NSMutableArray *)tabBarButtons{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

-(id)initWithFrame:(CGRect)frame{
   self =  [super initWithFrame:frame];
    
    if (self) {
        if (!IOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
    }
    //添加加号后处理（如果要去掉，还去屏蔽laysubview方法index大于1的时候x坐标的处理）
    UIButton *plushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plushBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:(UIControlStateNormal)];
    [plushBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:(UIControlStateHighlighted)];
    [plushBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:(UIControlStateNormal)];
    [plushBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:(UIControlStateHighlighted)];
    
    plushBtn.bounds = CGRectMake(0, 0, plushBtn.currentBackgroundImage.size.width, plushBtn.currentBackgroundImage.size.height);
    [self addSubview:plushBtn];
    self.plushBtn = plushBtn;
    return self;
}

/**
 *创建tabbarItem
 */
-(void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem{
    
    //1 创建按钮
    HLTabBarItem *btnTabBar = [[HLTabBarItem alloc] init];
    [self addSubview:btnTabBar];
    //2 设置数据
    btnTabBar.tabBarItem = tabBarItem;
    
    [self.tabBarButtons addObject:btnTabBar];
    
    //3 监听按钮点击
    [btnTabBar addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    //4 默认选中第0个按钮
    if (_tabBarButtons.count == 1) {
        [self btnClick:btnTabBar];
    }
}

/**
 *监听按钮点击
 */
-(void)btnClick:(HLTabBarItem *)btn{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectEdButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectEdButtonFrom:self.currentSelectedBtn.tag to:btn.tag];
    }
    //设置按钮的状态
    self.currentSelectedBtn.selected = NO;
    btn.selected = YES;
    self.currentSelectedBtn = btn;
}
/**
 *设置frame
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    
    self.plushBtn.center = CGPointMake(selfW * 0.5, selfH * 0.5);
    
    CGFloat btnY = 0;
    CGFloat btnW = selfW/self.subviews.count;
    CGFloat btnH = selfH;
    for (int index = 0; index < self.tabBarButtons.count; index++) {
        CGFloat btnX = index*btnW;
        //1 取出按钮
        HLTabBarItem *btn = self.tabBarButtons[index];
        //添加加号后处理
        if (index > 1) {
            btnX += btnW;
        }
        //2 设置按钮frame
        [btn setFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        
        btn.tag = index;
    }
}

@end
