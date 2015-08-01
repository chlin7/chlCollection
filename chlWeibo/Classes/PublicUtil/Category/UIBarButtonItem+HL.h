//
//  UIBarButtonItem+HL.h
//  chlWeibo
//
//  Created by chlin7 on 15/8/1.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HL)


/**
 *快速创建一个导航栏的显示图片的Item
 */
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
