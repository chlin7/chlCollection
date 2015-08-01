//
//  UIBarButtonItem+HL.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/1.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "UIBarButtonItem+HL.h"

@implementation UIBarButtonItem (HL)


/**
 *快速创建一个导航栏的显示图片的Item
 */
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action{
    UIButton *barButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButtonItem setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [barButtonItem setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [barButtonItem addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    barButtonItem.frame = (CGRect){CGPointZero,barButtonItem.currentBackgroundImage.size};
    return[[UIBarButtonItem alloc] initWithCustomView:barButtonItem];
}

@end
