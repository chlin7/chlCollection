//
//  UIImage+chlImage.h
//  chlWeibo
//
//  Created by chlin7 on 15-6-5.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (chlImage)

/**
 *根据是否是》IOS7饭后不同名称的图片
 */
+(UIImage *)imageWithName:(NSString *)name;


/**
 *返回一张自由拉伸的图片
 */
+(UIImage *)resizedImageWithName:(NSString *)name;

@end
