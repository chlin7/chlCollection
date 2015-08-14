//
//  UIImage+HL.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/1.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "UIImage+HL.h"

@implementation UIImage (HL)
/**
 *  设置UIImage，设置IOS7判断
 *
 *  @param name 图片名称
 *
 *  @return UIImage
 */
+(UIImage *)imageWithName:(NSString *)name{
    if (IOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) {//没有os7后缀的图片
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    return [UIImage imageNamed:name];
}


+(UIImage *)resizedImageWithName:(NSString *)name{
    
    return [self resizedImageWithName:name left:0.5 top:0.5];
}
+(UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top{
    
    UIImage *image = [self imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}
@end
