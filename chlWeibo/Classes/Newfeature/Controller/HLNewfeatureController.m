//
//  HLNewfeatureController.m
//  chlWeibo
//  项目更新信息展示界面
//  Created by chlin7 on 15/8/1.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLNewfeatureController.h"
#import "HLTabBarViewController.h"

#define HLNewfeatureCount 3

@interface HLNewfeatureController()<UIScrollViewDelegate>

@property(nonatomic,weak) UIPageControl *pageControl;

@end

@implementation HLNewfeatureController

-(void)viewDidLoad{
    
    //0.0设置背景颜色
//    [self.view setBackgroundColor:HLColor(246, 246, 246)];
    
    //1.0 添加UIScrollView
    [self setupScrollView];
    
    //2.0 添加pageControl
    [self setupPageControl];
}
/**
 *添加pageControl
 */
-(void)setupPageControl{
    //1.0 添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.userInteractionEnabled = NO;
    pageControl.numberOfPages = HLNewfeatureCount;
    CGFloat centerX = SCREEN_WIDTH * 0.5;
    CGFloat centerY = SCREEN_HEIGHT - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    //设置bounds  x y 不起作用
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    //2.0设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = HLColor(253, 89, 42);
    pageControl.pageIndicatorTintColor = HLColor(189, 189, 189);
}
/**
 *添加scrollview
 */
-(void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    //2.0 添加图片
    CGFloat imageH = scrollView.frame.size.height;
    CGFloat imageW = scrollView.frame.size.width;
    for (int i = 0; i < HLNewfeatureCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        
        //设置尺寸
        CGFloat imageX = i*imageW;
        CGFloat imageY = 0;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        [scrollView addSubview:imageView];
        
        //在最后一张图片添加按钮操作
        if (i == HLNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    //3.0 设置滚动的内容范围
    scrollView.contentSize = CGSizeMake(imageW*HLNewfeatureCount, 0);
    //隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //分页
    scrollView.pagingEnabled = YES;
    //屏蔽弹窗效果
    scrollView.bounces = NO;
}
/**
 *  在最后一个UIImageVIew添加操作视图
 *
 *  @param lastImageView
 */
-(void)setupLastImageView:(UIImageView *)lastImageView{
    //0.0 设置ImageView允许用户交互
    lastImageView.userInteractionEnabled = YES;
    //1.0 添加开始按钮
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    //设置frame
    CGFloat centerX = SCREEN_WIDTH * 0.5;
    CGFloat centerY = SCREEN_HEIGHT * 0.6;
    startBtn.center = CGPointMake(centerX, centerY);
    startBtn.bounds = (CGRect){CGPointZero,startBtn.currentBackgroundImage.size};
    [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lastImageView addSubview:startBtn];
    
    [startBtn addTarget:self action:@selector(startUse) forControlEvents:UIControlEventTouchUpInside];
    
    //2.0添加checkbox
    UIButton *checkBox = [[UIButton alloc] init];
    [checkBox setTitle:@"分享给朋友" forState:UIControlStateNormal];
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBox.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [checkBox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    //设置frame
    CGFloat checkBoxY = centerY - 50;
    checkBox.center = CGPointMake(centerX, checkBoxY);
    checkBox.bounds = startBtn.bounds;
    checkBox.selected = YES;
    [lastImageView addSubview:checkBox];
    //添加监听
    [checkBox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  check 点击
 *
 *  @param checkBox
 */
-(void)checkBoxClick:(UIButton *)checkBox{
    checkBox.selected = !checkBox.selected;
}
/**
 *  开始提体验
 */
-(void)startUse{
    //显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    //切换rootViewController
    HLTabBarViewController *tabBarVC = [[HLTabBarViewController alloc] init];
//    [[UIApplication sharedApplication].keyWindow setRootViewController:tabBarVC];
    [self.view.window setRootViewController:tabBarVC];
}
/**
 *只要scrollview滚动就会调用
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1.0 取出水平滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    //2.0 计算出滚动到第几页
    double pageDouble = offsetX/scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}

@end
