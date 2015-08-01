//
//  HLTabBarItem.m
//  chlWeibo
//
//  Created by chlin7 on 15-6-6.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//
//图片的高度比例
#define HLTabBarItemImageRatio 0.6

//按钮的默认颜色
#define HLTabBarItemTitleColor (IOS7?[UIColor blackColor] :[UIColor whiteColor])
//选中颜色
#define HLTabBarItemSelectedTitleColor (IOS7?HLColor(234,103,7):HLColor(248,139,0))

#import "HLTabBarItem.h"
#import "HLBadgeButton.h"

@interface HLTabBarItem()
//提醒数字
@property(nonatomic,weak) HLBadgeButton *badgeButton;

@end

@implementation HLTabBarItem

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self setTitleColor:HLTabBarItemTitleColor forState:(UIControlStateNormal)];
        [self setTitleColor:HLTabBarItemSelectedTitleColor forState:(UIControlStateSelected)];
        if (!IOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:(UIControlStateSelected)];
        }
        //提醒数字
        HLBadgeButton *badgeButton =[[HLBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
        
    }
    return self;
}
-(void)setHidden:(BOOL)hidden{}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*HLTabBarItemImageRatio);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height*HLTabBarItemImageRatio, contentRect.size.width, contentRect.size.height-contentRect.size.height*HLTabBarItemImageRatio);
}
/**
 *  设置item属性
 */

-(void)setTabBarItem:(UITabBarItem *)tabBarItem{
    _tabBarItem = tabBarItem;
    
    //KVO  监听属性改变(当前监听badgeValue)-需要销毁（当值发生改变的时候会执行observeValueForKeyPath方法）
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"title" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"image" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self setupTabBarValue];
    
}
/**
 *监听某个对象属性值的改变，就会调用
 *keyPath  属性命
 *ofObject  那个对象的属性被改变
 *change  属性发生的改变
 *context
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self setupTabBarValue];
}
-(void)dealloc{
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.tabBarItem removeObserver:self forKeyPath:@"title"];
    [self.tabBarItem removeObserver:self forKeyPath:@"image"];
    [self.tabBarItem removeObserver:self forKeyPath:@"selectedImage"];
}

-(void)setupTabBarValue{
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
    
    self.badgeButton.badgeValue = self.tabBarItem.badgeValue;
    
    CGFloat badgeY = 0;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    
    self.badgeButton.frame = badgeF;

}

@end
