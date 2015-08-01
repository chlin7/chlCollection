//
//  HLTabBar.h
//  chlWeibo
//
//  Created by chlin7 on 15-6-6.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLTabBar;
@protocol HLTabBarDelegate <NSObject>

@optional
-(void)tabBar:(HLTabBar *)tabBar didSelectEdButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface HLTabBar : UIView

-(void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem;


@property(nonatomic,weak) id<HLTabBarDelegate> delegate;

@end
