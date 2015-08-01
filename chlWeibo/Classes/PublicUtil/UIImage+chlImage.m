//
//  UIImage+chlImage.m
//  chlWeibo
//
//  Created by chlin7 on 15-6-5.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "UIImage+chlImage.h"

@implementation UIImage (chlImage)

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
    UIImage *image = [self imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}
@end
