//
//  UIImage+HL.h
//  chlWeibo
//
//  Created by chlin7 on 15/8/1.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HL)
/**
 *根据是否是》IOS7返回不同名称的图片
 */
+(UIImage *)imageWithName:(NSString *)name;


/**
 *返回一张自由拉伸的图片
 */
+(UIImage *)resizedImageWithName:(NSString *)name;

@end
